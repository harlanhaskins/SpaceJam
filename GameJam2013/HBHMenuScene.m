//
//  HBHMenuScene.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/15/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHHighScoreScene.h"
#import "HBHScene.h"
#import "HBHMenuScene.h"

@implementation HBHMenuScene

- (instancetype) initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.anchorPoint = CGPointMake(0.5, 0.5);
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
        titleLabel.fontSize = 118.0f;
        titleLabel.text = @"Space\nJam";
        titleLabel.y += titleLabel.height * 2;
        [self addChild:titleLabel];
        
        SKLabelNode *playLabel = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
        playLabel.fontSize = 60.0f;
        playLabel.text = @"Play Game";
        [self addChild:playLabel];
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
        scoreLabel.fontSize = 60.0f;
        scoreLabel.text = @"View High Scores";
        
        SKLabelNode *instructionsLabel = [SKLabelNode labelNodeWithFontNamed:@"JoystixMonospace-Regular"];
        instructionsLabel.fontSize = 24.0f;
        instructionsLabel.text = @"Collect money! Avoid Cops! Do drugs!";
        
        [self addChild:instructionsLabel];
        
        scoreLabel.y = playLabel.y - (scoreLabel.height + playLabel.height);
        
        instructionsLabel.y = scoreLabel.y - (instructionsLabel.height + scoreLabel.height * 2);
        
        [self addChild:scoreLabel];
        
        SKAction *rotateAction = [SKAction rotateByAngle:(M_PI/128) duration:2.0f];
        SKAction *rotateBackAction = [SKAction rotateByAngle:(-M_PI/128) duration:2.0f];
        SKAction *rotateForeverAction = [SKAction repeatActionForever:[SKAction sequence:@[rotateAction, rotateAction.reversedAction, rotateBackAction, rotateBackAction.reversedAction]]];
        rotateForeverAction.timingMode = SKActionTimingEaseInEaseOut;
        [titleLabel runAction:rotateForeverAction];
        [scoreLabel runAction:rotateForeverAction];
        [playLabel runAction:rotateForeverAction];
        [instructionsLabel runAction:rotateForeverAction];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKLabelNode *node = (SKLabelNode*)[self nodeAtPoint:[[touches anyObject] locationInNode:self]];
    if (![node isKindOfClass:[SKScene class]]) {
        if ([node.text isEqualToString:@"Play Game"]) {
            HBHScene *scene = [[HBHScene alloc] initWithSize:self.size];
            scene.delegate = self.delegate;
            [self.view presentScene:scene transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5f]];
        }
        else if ([node.text isEqualToString:@"View High Scores"]){
            HBHHighScoreScene *scene = [[HBHHighScoreScene alloc] initWithSize:self.size];
            scene.delegate = self.delegate;
            [self.view presentScene:scene transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5f]];
        }
    }
}

@end
