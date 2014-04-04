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

@implementation LYAppDelegate


/**
 * @brief 初始化抽屉结构
 */

- (void)initDrawerViewController
{
    self.leftNavCol = [[UINavigationController alloc] initWithRootViewController:[LeftMenuViewController new]];
    self.centerNavCol = [[UINavigationController alloc] initWithRootViewController:[CenterViewController new]];
    self.rightNavCol = [[UINavigationController alloc] initWithRootViewController:[PlayerViewController new]];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.centerNavCol
                                                            leftDrawerViewController:self.leftNavCol
                                                           rightDrawerViewController:self.rightNavCol];
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
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeParallax];
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


#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initDrawerViewController];
    
    return YES;
}

@end
