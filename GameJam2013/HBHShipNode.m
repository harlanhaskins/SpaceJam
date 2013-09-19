//
//  HBHShipNode.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/14/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHShipNode.h"

@implementation HBHShipNode {
    SKAction *deathAction;
}

- (instancetype) init {
    if (self = [super initWithImageNamed:@"heisenberg"]) {
//        self.color = [UIColor colorWithRed:220.0f/255.0f green:122.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
//        self.colorBlendFactor = 1.0f;
        self.texture.filteringMode = SKTextureFilteringNearest;
        self.size = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(3.0, 3.0));
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.zPosition = topZPosition;
        self.physicsBody.restitution = 0.0f;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.categoryBitMask = PlayerShipBitMask;
        self.physicsBody.collisionBitMask = SceneBitMask;
        self.physicsBody.contactTestBitMask = CopShipBitMask | PowerUpBitMask;
        self.name = @"PlayerShip";
        [self createDeathAction];
    }
    return self;
}

- (void) createDeathAction {
    NSTimeInterval actionDuration = 0.25f;
    SKAction *colorizeAction = [SKAction colorizeWithColor:[SKColor orangeColor] colorBlendFactor:1.0f duration:actionDuration];
    SKAction *scaleAction = [SKAction scaleBy:3.0f duration:actionDuration];
    SKAction *fadeAction = [SKAction fadeAlphaTo:0.0f duration:actionDuration];
    SKAction *waitToRemoveAction = [SKAction sequence:@[[SKAction waitForDuration:actionDuration], [SKAction removeFromParent]]];
    deathAction = [SKAction group:@[colorizeAction, scaleAction, fadeAction, waitToRemoveAction]];
}

- (void) die {
    self.dead = YES;
    [self removeAllActions];
    self.anchorPoint = CGPointMake(0.5, 0.5);
    [self runAction:deathAction];
}


@end
