//
//  HBHDiamondNode.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/15/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHDiamondNode.h"

@implementation HBHDiamondNode

- (instancetype) init {
    if (self = [super initWithImageNamed:@"money"]) {
        self.texture.filteringMode = SKTextureFilteringNearest;
        self.size = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(1.5, 1.5));
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.zPosition = 1.0f;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = PowerUpBitMask;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = PlayerShipBitMask;
        
        NSInteger xMovement = (((NSInteger)arc4random_uniform(25) + 200) * 3);
        
        CGFloat movementFloat = (CGFloat)xMovement;
        
        SKAction *movementAction = [SKAction moveByX:-movementFloat y:0 duration:1.0f];
        [self runAction:[SKAction repeatActionForever:movementAction]];
        
        [self performSelector:@selector(removeFromParent) withObject:nil afterDelay:30.0f];
    }
    return self;
}

- (SKAction*) actionForPowerUp {
    SKAction *increaseScoreAction = [SKAction customActionWithDuration:0.25f actionBlock:^(SKNode* node, CGFloat elapsedTime) {
        HBHScene *scene = (HBHScene*)node.parent;
        [scene increaseScoreBy:1];
    }];
    return increaseScoreAction;
}

@end
