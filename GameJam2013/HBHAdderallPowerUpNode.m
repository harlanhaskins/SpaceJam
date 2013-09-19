//
//  HBHAdderallPowerUpNode.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/15/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHShipNode.h"
#import "HBHCopShipNode.h"
#import "HBHAdderallPowerUpNode.h"

@implementation HBHAdderallPowerUpNode
- (instancetype) init {
    if (self = [super initWithImageNamed:@"adderall"]) {
        
        self.texture.filteringMode = SKTextureFilteringNearest;
        self.size = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(1.0, 1.0));
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
    SKAction *slowDownAction = [SKAction customActionWithDuration:1.0f actionBlock:^(SKNode* node, CGFloat elapsedTime) {
        HBHScene *scene = (HBHScene*)node.parent;
        scene.speed = 0.5f;
        HBHShipNode *shipNode = (HBHShipNode*)[scene childNodeWithName:@"PlayerShip"];
        shipNode.speed = 1/scene.speed;
    }];
    slowDownAction.timingMode = SKActionTimingEaseInEaseOut;
    SKAction *speedUpAction = [SKAction customActionWithDuration:1.0f actionBlock:^(SKNode* node, CGFloat elapsedTime) {
        HBHScene *scene = (HBHScene*)node.parent;
        scene.speed = 1.0f;
        HBHShipNode *shipNode = (HBHShipNode*)[scene childNodeWithName:@"PlayerShip"];
        shipNode.speed = 1.0f;
    }];
    speedUpAction.timingMode = SKActionTimingEaseInEaseOut;
    return [SKAction sequence:@[slowDownAction, [SKAction waitForDuration:5.0f], speedUpAction]];
}
@end
