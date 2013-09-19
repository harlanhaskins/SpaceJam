//
//  SKNode+Positioning.m
//
//  Created by Harlan Haskins, Based on UIView+Positioning created by Shai Mishali on 5/22/13.
//  Copyright (c) 2013 Harlan Haskins. Some rights reserved.
//

#import "SKNode+Positioning.h"

@implementation SKNode (Positioning)
@dynamic x, y, width, height, size;

// Setters
- (void)setX:(CGFloat)x {
	CGPoint p        = self.position;
	p.x              = x;
	self.position    = p;
}

- (void)setY:(CGFloat)y {
	CGPoint p        = self.position;
	p.y              = y;
	self.position    = p;
}

- (void)setWidth:(CGFloat)width {
	CGSize s        = self.frame.size;
	CGFloat proportion = s.width / width;
	self.xScale         = proportion;
}

- (void)setHeight:(CGFloat)height {
	CGSize s        = self.frame.size;
	CGFloat proportion = s.height / height;
	self.yScale         = proportion;
}

- (void)setSize:(CGSize)size {
	self.width      = size.width;
	self.height     = size.height;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	CGFloat anchorPointAdjuster = 0.0f;
	if ([self respondsToSelector:@selector(anchorPoint)]) {
		anchorPointAdjuster = [(SKSpriteNode *)self anchorPoint].x;
	}
	self.x = right - frame.size.width + (frame.size.width * anchorPointAdjuster);
}

- (void)setLeft:(CGFloat)left {
	CGRect frame = self.frame;
	CGFloat anchorPointAdjuster = 0.0f;
	if ([self respondsToSelector:@selector(anchorPoint)]) {
		anchorPointAdjuster = [(SKSpriteNode *)self anchorPoint].x;
	}
	self.x = left - (frame.size.width * anchorPointAdjuster);
}

- (void)setTop:(CGFloat)top {
	CGRect frame = self.frame;
	CGFloat anchorPointAdjuster = 0.0f;
	if ([self respondsToSelector:@selector(anchorPoint)]) {
		anchorPointAdjuster = [(SKSpriteNode *)self anchorPoint].y;
	}
	self.y = top - frame.size.height + (frame.size.height * anchorPointAdjuster);
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	CGFloat anchorPointAdjuster = 0.0f;
	if ([self respondsToSelector:@selector(anchorPoint)]) {
		anchorPointAdjuster = [(SKSpriteNode *)self anchorPoint].y;
	}
	self.y = bottom + (frame.size.height * anchorPointAdjuster);
}

- (void)setCenterX:(CGFloat)centerX {
	self.x = centerX - (self.width / 2);
}

- (void)setCenterY:(CGFloat)centerY {
	self.y = centerY - (self.height / 2);
}

- (void)setCenter:(CGPoint)centerPoint {
	self.centerX = centerPoint.x;
	self.centerY = centerPoint.y;
}

// Getters
- (CGFloat)x {
	return self.frame.origin.x;
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (CGPoint)origin {
	return CGPointMake(self.x, self.y);
}

- (CGSize)size {
	return CGSizeMake(self.width, self.height);
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (CGFloat)bottom {
	return self.frame.origin.y;
}

- (CGFloat)top {
	return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)centerX {
	return self.position.x + (self.width / 2);
}

- (CGFloat)centerY {
	return self.position.y + (self.height / 2);
}

- (CGPoint)center {
	return CGPointMake(self.centerX, self.centerY);
}

- (SKNode *)lastChildNodeOnX {
	if (self.children.count > 0) {
		SKNode *outNode = self.children[0];
        
		for (SKNode *n in self.children)
			if (n.x > outNode.x)
				outNode = n;
        
		return outNode;
	}
    
	return nil;
}

- (SKNode *)lastChildNodeOnY {
	if (self.children.count > 0) {
		SKNode *outNode = self.children[0];
        
		for (SKNode *n in self.children)
			if (n.y > outNode.y)
				outNode = n;
        
		return outNode;
	}
    
	return nil;
}

// Methods
- (void)centerToParent {
	if (self.parent) {
		switch ([UIApplication sharedApplication].statusBarOrientation) {
			case UIInterfaceOrientationLandscapeLeft:
			case UIInterfaceOrientationLandscapeRight: {
				self.x  =   (self.parent.height / 2) - (self.width / 2);
				self.y  =   (self.parent.width / 2) - (self.height / 2);
				break;
			}
                
			case UIInterfaceOrientationPortrait:
			case UIInterfaceOrientationPortraitUpsideDown: {
				self.x  =   (self.parent.width / 2) - (self.width / 2);
				self.y  =   (self.parent.height / 2) - (self.height / 2);
				break;
			}
		}
	}
}

@end
