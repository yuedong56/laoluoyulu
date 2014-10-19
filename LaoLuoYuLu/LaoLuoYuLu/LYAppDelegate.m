//
//  LYAppDelegate.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "LYAppDelegate.h"
#import "LeftMenuViewController.h"
#import "CenterViewController.h"
#import "PlayerViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIView+Common.h"

@implementation LYAppDelegate

/** 初始化抽屉结构 */
- (void)initDrawerViewController
{
    self.leftNavCol = [[UINavigationController alloc] initWithRootViewController:[LeftMenuViewController new]];
    MenuModel *menuMol = [[[LYDataManager instance] selectMenuList] objectAtIndex:0];
    self.centerNavCol = [[UINavigationController alloc] initWithRootViewController:[[CenterViewController alloc] initWithMenu:menuMol]];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.centerNavCol
                                                            leftDrawerViewController:self.leftNavCol];
    [self.drawerController setMaximumLeftDrawerWidth:LeftMenuWidth];
    [self.drawerController setMaximumRightDrawerWidth:RightMenuWidth];
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible)
    {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.drawerController.showsShadow = NO;
    //抽屉特殊效果
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    self.window.rootViewController = self.drawerController;
}

- (void)showLeftSideView
{
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)showRightSideView
{
    [self.drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

/** 初始化播放器界面 */
- (void)initPlayerView
{
    if (!self.playerView) {
        self.playerView = [[PlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.playerView.hidden = YES;
        [self.window addSubview:self.playerView];
    }
}

#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initDrawerViewController];
    [self initPlayerView];
    
    return YES;
}

@end


