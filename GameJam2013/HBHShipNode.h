//
//  HBHShipNode.h
//  GameJam2013
//
//  Created by Harlan Haskins on 9/14/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHScene.h"
#import <SpriteKit/SpriteKit.h>

@interface HBHShipNode : SKSpriteNode
- (void) die;
@property BOOL dead;
@end
