//
//  HBHCopShipNode.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/14/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHCopShipNode.h"

@implementation HBHCopShipNode

- (instancetype) init {
    if (self = [super init]) {
        
        self.texture = [SKTexture textureWithImageNamed:@"square"];
        self.colorBlendFactor = 0.0f;
        
        SKSpriteNode *shadow = [SKSpriteNode spriteNodeWithImageNamed:@"shadow"];
        shadow.zPosition = 0.0f;
        shadow.alpha = 0.75f;
        SKSpriteNode *shadowTwo = [SKSpriteNode spriteNodeWithImageNamed:@"shadow"];
        shadowTwo.zPosition = 0.0f;
        shadowTwo.alpha = 0.75f;
        
//        shadowTwo.size = shadow.size = CGSizeApplyAffineTransform(shadow.size, CGAffineTransformMakeScale(0.75, 0.75));
        
        self.zPosition = 1.0f;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = CopShipBitMask;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = PlayerShipBitMask;
        
        self.name = @"Cop";
        
//        NSTimer *timer = [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(checkIfStillOnScreen:) userInfo:nil repeats:YES];
        
        shadow.color = [SKColor redColor];
        shadowTwo.color = [SKColor blueColor];
        shadow.colorBlendFactor = shadowTwo.colorBlendFactor = 1.0f;
        
        self.anchorPoint = shadow.anchorPoint = shadowTwo.anchorPoint = CGPointMake(0.5, 0.5);
        shadow.position = CGPointMake(shadow.position.x, shadow.position.y + shadow.size.height * 0.25);
        shadowTwo.position = CGPointMake(shadowTwo.position.x, shadowTwo.position.y - shadowTwo.size.height * 0.25);
        
        [self addChild:shadow];
        [self addChild:shadowTwo];
        SKAction *blueAction = [SKAction colorizeWithColor:[SKColor blueColor] colorBlendFactor:1.0f duration:0.5f];
        SKAction *redAction = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0f duration:0.5f];
        [shadow runAction:[SKAction repeatActionForever:[SKAction sequence:@[blueAction, redAction]]]];
        [shadowTwo runAction:[SKAction repeatActionForever:[SKAction sequence:@[redAction, blueAction]]]];
        NSInteger xMovement = (((NSInteger)arc4random_uniform(25) + 200) * 3);
        
        CGFloat movementFloat = (CGFloat)xMovement;
        
        SKAction *movementAction = [SKAction moveByX:-movementFloat y:0 duration:1.0f];
        [self runAction:[SKAction repeatActionForever:movementAction]];
        
        [self performSelector:@selector(removeFromParent) withObject:nil afterDelay:30.0f];
    }
    return self;
}

- (void) checkIfStillOnScreen:(NSTimer*)sender {
    CGFloat xPosition = self.position.x;
    if (xPosition <= -self.width) {
        [self removeFromParent];
        [sender invalidate];
    }
}

@end
