//
//  HBHMyScene.h
//  GameJam2013
//

//  Copyright (c) 2013 Haskins. All rights reserved.
//

typedef enum UnitBitMask {
    PlayerShipBitMask = 1 << 0,
    CopShipBitMask = 1 << 1,
    SceneBitMask = 1 << 2,
    PowerUpBitMask = 1 << 3
} UnitBitMask;

@protocol GameDelegate <NSObject>

- (void) resetGame;

@end

#import <SpriteKit/SpriteKit.h>

@interface HBHScene : SKScene <SKPhysicsContactDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) id<GameDelegate> delegate;
@property (nonatomic) NSInteger score;
@property (nonatomic) BOOL slowedDown;

- (void) increaseScoreBy:(NSInteger)score;

@end
