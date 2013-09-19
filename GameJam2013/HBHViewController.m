//
//  HBHViewController.m
//  GameJam2013
//
//  Created by Harlan Haskins on 9/14/13.
//  Copyright (c) 2013 Haskins. All rights reserved.
//

#import "HBHViewController.h"

@implementation HBHViewController {
    SKView * skView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    // Configure the view.
    skView = [[SKView alloc] initWithFrame:[self flippedBounds]];
    skView.showsFPS =
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    HBHMenuScene * scene = [HBHMenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    scene.delegate = self;
    
    // Present the scene.
    [skView presentScene:scene];
    [self.view addSubview:skView];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (CGRect) flippedBounds {
    CGRect bounds = [[UIScreen mainScreen] bounds]; // portrait bounds
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);
    }
    return bounds;
}

- (void) resetGame {
    HBHMenuScene * scene = [HBHMenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.delegate = self;
    
    [skView presentScene:scene transition:[SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.5f]];
}

@end
