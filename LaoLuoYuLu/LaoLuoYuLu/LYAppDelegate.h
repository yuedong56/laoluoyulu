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
#import "MenuModel.h"
#import "LYToastView.h"

@interface LYAppDelegate : UIResponder <UIApplicationDelegate>
{
    LYToastView *toastView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MMDrawerController *drawerController;
@property (strong, nonatomic) UINavigationController *centerNavCol;
@property (strong, nonatomic) UINavigationController *leftNavCol;

@property (strong, nonatomic) VoiceModel *currentVoiceModel;
@property (strong, nonatomic) MenuModel *currentMenuModel;
@property (strong, nonatomic) PlayerView *playerView;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSTimer *instanceTimer;    //播放器定时器

- (void)showLeftSideView;
- (void)showRightSideView;

#pragma mark - toastView
- (void)showToastView:(NSString *)text;
- (void)hideToastViewAfter:(NSTimeInterval)duration;

@end
