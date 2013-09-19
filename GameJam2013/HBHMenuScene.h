//
//  HBHMenuScene.h
//  GameJam2013
//
//  Created by Harlan Haskins on 9/15/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHScene.h"
#import <SpriteKit/SpriteKit.h>
@protocol MenuDelegate <GameDelegate>

@end

@interface HBHMenuScene : SKScene

@property (nonatomic) id<MenuDelegate> delegate;

@end
