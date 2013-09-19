//
//  HBHMyScene.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/14/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHStarNode.h"
#import "HBHCopShipNode.h"
#import "HBHDiamondNode.h"
#import "HBHAdderallPowerUpNode.h"
#import "HBHScene.h"

@implementation HBHScene {
    HBHShipNode *shipNode;
    NSDate *referenceDateForScorekeeping;
    SKLabelNode *label;
    NSMutableArray *highScores;
    NSString *filePath;
    NSString *initials;
    UITextField *myTextField;
    BOOL dead;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        shipNode = [HBHShipNode new];
        shipNode.position = self.center;
        [self addChild:shipNode];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.restitution = 0.0f;
        self.physicsBody.categoryBitMask = SceneBitMask;
        self.physicsBody.collisionBitMask = PlayerShipBitMask;
        self.physicsWorld.contactDelegate = self;
        referenceDateForScorekeeping = [NSDate date];
        
        label = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
        label.text = [NSString stringWithFormat:@"Score: %d", 0];
        label.color = [UIColor whiteColor];
        label.top = self.top - 5.0f;
        label.right = self.right;
        [self addChild:label];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        filePath = [documentsDirectory stringByAppendingPathComponent:@"scores.plist"];
        
        highScores = [NSMutableArray arrayWithCapacity:15];
        [highScores addObjectsFromArray:[NSArray arrayWithContentsOfFile:filePath]];
        
        SKAction *musicAction = [SKAction repeatActionForever:[SKAction playSoundFileNamed:@"BackgroundLoop.mp3" waitForCompletion:YES]];
        [self runAction:musicAction];
        
        dead = NO;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    shipNode.physicsBody.affectedByGravity = NO;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    shipNode.physicsBody.affectedByGravity = YES;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (!dead) {
        
        if (!shipNode.physicsBody.affectedByGravity) {
            [shipNode.physicsBody applyForce:CGVectorMake(0, 220)];
        }
        
        CGFloat timeSince = roundf([[NSDate date] timeIntervalSinceDate:referenceDateForScorekeeping]);
        if (timeSince >= 1.0f) {
            self.score++;
            referenceDateForScorekeeping = [NSDate date];
        }
        [self generateStars];
        [self generateCops];
        [self generateDiamonds];
        [self generatePills];
        
        label.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
    }
}

- (void) generateCops {
    BOOL shouldGenerateCop = (arc4random_uniform(50) == 4);
    if (shouldGenerateCop) {
        HBHCopShipNode *copNode = [[HBHCopShipNode alloc] init];
        [self addChild:copNode];
        copNode.position = CGPointMake(self.width + (copNode.width / 2), arc4random_uniform(self.height));
    }
}

- (void) generateDiamonds{
    BOOL shouldGenerateDiamond = (arc4random_uniform(75) == 4);
    if (shouldGenerateDiamond) {
        HBHDiamondNode *diamondNode = [[HBHDiamondNode alloc] init];
        [self addChild:diamondNode];
        NSInteger minusMultiplier = arc4random_uniform(2) == 1 ? -1 : 1;
        diamondNode.position = CGPointMake(self.width + (diamondNode.width / 2), (arc4random_uniform(250) * minusMultiplier) + shipNode.position.y + (shipNode.frame.size.height / 2));
    }
}

- (void) generateStars {
    BOOL shouldGenerateStar = (arc4random_uniform(10) == 4);
    if (shouldGenerateStar) {
        HBHStarNode *starNode = [[HBHStarNode alloc] init];
        [self addChild:starNode];
        starNode.position = CGPointMake(self.width, arc4random_uniform(self.height));
    }
}

- (void) generatePills {
    if (self.speed == 1.0f) {
        BOOL shouldGeneratePill = (arc4random_uniform(750) == 4);
        if (shouldGeneratePill) {
            HBHAdderallPowerUpNode *pillNode = [[HBHAdderallPowerUpNode alloc] init];
            [self addChild:pillNode];
            NSInteger minusMultiplier = arc4random_uniform(2) == 1 ? -1 : 1;
            pillNode.position = CGPointMake(self.width, (arc4random_uniform(250) * minusMultiplier) + shipNode.position.y + (shipNode.frame.size.height / 2));
        }
    }
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    HBHCopShipNode *copNode;
    id<PowerUpProtocol> powerUp;
    HBHShipNode *playerShip;
    if ([contact.bodyA.node isKindOfClass:[SKScene class]] || [contact.bodyB.node isKindOfClass:[SKScene class]]) {
        return;
    }
    if ([contact.bodyA.node isKindOfClass:[HBHCopShipNode class]]) {
        copNode = (HBHCopShipNode*)contact.bodyA.node;
        playerShip = (HBHShipNode*)contact.bodyB.node;
    }
    else if ([contact.bodyB.node isKindOfClass:[HBHCopShipNode class]]) {
        copNode = (HBHCopShipNode*)contact.bodyB.node;
        playerShip = (HBHShipNode*)contact.bodyA.node;
    }
    else if ([contact.bodyB.node conformsToProtocol:@protocol(PowerUpProtocol)]) {
        powerUp = (id<PowerUpProtocol>)contact.bodyB.node;
        playerShip = (HBHShipNode*)contact.bodyA.node;
    }
    else if ([contact.bodyA.node conformsToProtocol:@protocol(PowerUpProtocol)]) {
        powerUp = (id<PowerUpProtocol>)contact.bodyA.node;
        playerShip = (HBHShipNode*)contact.bodyB.node;
    }
    
    if (playerShip && !playerShip.dead) {
        if (copNode) {
            [playerShip die];
            dead = YES;
            [self performSelector:@selector(resetGame) withObject:nil afterDelay:0.5f];
        }
        else if (powerUp) {
            SKAction *action = [powerUp actionForPowerUp];
            [playerShip runAction:action];
            [self removeChildrenInArray:@[powerUp]];
        }
    }
}

- (void) resetGame {
    [self sortHighScores];
    if ([self scoreIsHighScore]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"High Score!"
                                                              message:@"Type your initials!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        myAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        myAlertView.delegate = self;
        self.paused = YES;
        [myAlertView show];
    }
    else {
        [self.delegate resetGame];
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    initials = [alertView textFieldAtIndex:0].text;
    NSArray *array = [self arrayWithScoreInserted];
    [array writeToFile:filePath atomically:YES];
    [self.delegate resetGame];
}

- (NSArray*) arrayWithScoreInserted {
    
    while (initials.length < 3) {
        initials = [initials stringByAppendingString:@" "];
    }
    
    BOOL added = NO;
    NSMutableDictionary *scoreDict = [NSMutableDictionary new];
    [scoreDict setObject:@(self.score) forKey:@"score"];
    [scoreDict setObject:initials.uppercaseString forKey:@"initials"];
    
    NSMutableArray *newScores = [NSMutableArray new];
    
    for (int i = 0; i < highScores.count - 1; i++) {
        NSInteger score = [highScores[i][@"score"] integerValue];
        
        if (self.score > score && !added) {
            [newScores addObject:scoreDict];
            added = YES;
        }
        [newScores addObject:highScores[i]];
    }
    return newScores;
}

- (BOOL) scoreIsHighScore {
    return (self.score > [[highScores lastObject][@"score"] intValue]);
}

- (void) sortHighScores {
    [highScores sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSNumber *score1 = obj1[@"score"];
        NSNumber *score2 = obj2[@"score"];
        if (score1.intValue > score2.intValue)
            return NSOrderedAscending;
        if (score1.intValue < score2.intValue)
            return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

- (void) increaseScoreBy:(NSInteger)score {
    self.score += score;
}

@end
