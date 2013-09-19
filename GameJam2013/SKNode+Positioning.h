//
//
//  SKNode+Positioning.h
//
//  Created by Harlan Haskins, Based on UIView+Positioning created by Shai Mishali on 5/22/13.
//  Copyright (c) 2013 Harlan Haskins. Some rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>

/**
 `SKNode+Positioning` provides easy shorthand methods to defining the frame properties (width, height, x, y) of any SKNode based object in an easy fashion, as well as extra helpful properties and methods.
 */

@interface SKNode (Positioning)

/** Node's X Position. */
@property (nonatomic, assign) CGFloat x;

/** Node's Y Position. */
@property (nonatomic, assign) CGFloat y;

/** Node's width. */
@property (nonatomic, assign) CGFloat width;

/** Node's height. */
@property (nonatomic, assign) CGFloat height;

/** Node's size - Sets Width and Height. Note: This method will be overridden on SKSpriteNodes, as they manage their own sizes. */
@property (nonatomic, assign) CGSize size;

/** Y value representing the top of the node. */
@property (nonatomic, assign) CGFloat top;

/** X Value representing the right side of the node. */
@property (nonatomic, assign) CGFloat right;

/** Y value representing the bottom of the node. */
@property (nonatomic, assign) CGFloat bottom;

/** X Value representing the left side of the node. */
@property (nonatomic, assign) CGFloat left;

/** X value of the node's center. */
@property (nonatomic, assign) CGFloat centerX;

/** Y value of the node's center. */
@property (nonatomic, assign) CGFloat centerY;

/** Center as CGPoint. */
@property (nonatomic, assign) CGPoint center;

/** Returns the child node with the highest X value. */
@property (nonatomic, strong, readonly) SKNode *lastChildNodeOnX;

/** Returns the child node with the highest Y value. */
@property (nonatomic, strong, readonly) SKNode *lastChildNodeOnY;

/**
 Centers the node to its parent node, if the parent node exists.
 */
- (void)centerToParent;

@end
