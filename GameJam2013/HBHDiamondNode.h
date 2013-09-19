//
//  HBHDiamondNode.h
//  GameJam2013
//
//  Created by Harlan Haskins on 9/15/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHPowerUp.h"
#import "HBHShipNode.h"
#import "HBHScene.h"
#import <UIKit/UIKit.h>


@interface HBHDiamondNode : SKSpriteNode <PowerUpProtocol>

- (SKAction*) actionForPowerUp;

@end
