//
//  LYAppDelegate.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"
#import "VoiceModel.h"

@interface LYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MMDrawerController *drawerController;
@property (strong, nonatomic) UINavigationController *centerNavCol;
@property (strong, nonatomic) UINavigationController *leftNavCol;

@property (strong, nonatomic) PlayerView *playerView;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) VoiceModel *currentVoiceModel;

- (void)showLeftSideView;
- (void)showRightSideView;

@end
