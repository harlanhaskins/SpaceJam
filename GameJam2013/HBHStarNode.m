//
//  HBHStarNode.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/14/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHStarNode.h"

@implementation HBHStarNode
- (instancetype) init {
    if (self = [super initWithImageNamed:@"square"]) {
        
        CGFloat scale = 0.01 * arc4random_uniform(50);
        CGSize size = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(scale, scale));
        self.size = size;
        self.physicsBody.restitution = 0.0f;
        
        SKAction *movementAction = [SKAction moveByX:(-1000 * (scale / 3)) y:0 duration:0.16];
        [self runAction:[SKAction repeatActionForever:movementAction]];
        
        [self performSelector:@selector(removeFromParent) withObject:nil afterDelay:30.0f];
    }
    return self;
}

- (void) checkIfStillOnScreen:(NSTimer*)sender {
    CGFloat xPosition = self.position.x;
    if (xPosition <= 0) {
        [self removeFromParent];
        [sender invalidate];
    }
}
@end
