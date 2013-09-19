//
//  HBHPowerUp.h
//  GameJam2013
//
//  Created by Harlan Haskins on 9/15/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PowerUpProtocol <NSObject>

- (SKAction*) actionForPowerUp;

@end

@interface HBHPowerUp : NSObject

@end
