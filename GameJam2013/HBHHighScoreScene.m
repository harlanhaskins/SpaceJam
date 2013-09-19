//
//  HBHHighScoreScene.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/15/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHMenuScene.h"
#import "HBHHighScoreScene.h"

@implementation HBHHighScoreScene {
    NSMutableArray *highScores;
}

- (instancetype) initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
        titleLabel.fontSize = 100.0f;
        titleLabel.text = @"High Scores";
        
        titleLabel.y = self.height - titleLabel.height * 1.5;
        titleLabel.x += titleLabel.width + 70;
        [self addChild:titleLabel];
        
        SKAction *rotateAction = [SKAction rotateByAngle:(M_PI/128) duration:2.0f];
        SKAction *rotateBackAction = [SKAction rotateByAngle:(-M_PI/128) duration:2.0f];
        SKAction *rotateForeverAction = [SKAction repeatActionForever:[SKAction sequence:@[rotateAction, rotateAction.reversedAction, rotateBackAction, rotateBackAction.reversedAction]]];
        rotateForeverAction.timingMode = SKActionTimingEaseInEaseOut;
        
        [titleLabel runAction:rotateForeverAction];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"scores.plist"];
        
        highScores = [NSMutableArray new];
        [highScores addObjectsFromArray:[NSArray arrayWithContentsOfFile:filePath]];
        
        for (int i = 0; i < highScores.count; i++) {
            NSDictionary *scoreDict = highScores[i];
            SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
            scoreLabel.fontSize = 48.0f;
            scoreLabel.text = [NSString stringWithFormat:@"%@ - %d", scoreDict[@"initials"], [scoreDict[@"score"] intValue]];
            scoreLabel.y = (titleLabel.bottom) - (80 + (i * (scoreLabel.height + 2)));
            scoreLabel.x = (self.width / 2);
            [self addChild:scoreLabel];
        }
        
        
        SKLabelNode *backLabel = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
        backLabel.fontSize = 60.0f;
        backLabel.text = @"Back";
        backLabel.y += 20.0f;
        backLabel.x += (backLabel.width) + 20.0f;
        [self addChild:backLabel];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKLabelNode *node = (SKLabelNode*)[self nodeAtPoint:[[touches anyObject] locationInNode:self]];
    if (![node isKindOfClass:[SKScene class]]) {
        if ([node.text isEqualToString:@"Back"]) {
            HBHMenuScene *scene = [[HBHMenuScene alloc] initWithSize:self.size];
            scene.delegate = self.delegate;
            [self.view presentScene:scene transition:[SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.5f]];
        }
    }
}

@end
