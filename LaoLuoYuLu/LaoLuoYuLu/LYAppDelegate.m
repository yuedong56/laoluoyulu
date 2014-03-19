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
#import "MMExampleDrawerVisualStateManager.h"

@implementation LYAppDelegate


/**
 * @brief 初始化抽屉结构
 */

- (void)initDrawerViewController
{
    UINavigationController *leftNC = [[UINavigationController alloc] initWithRootViewController:[LeftMenuViewController new]];
    UINavigationController *centerNC = [[UINavigationController alloc] initWithRootViewController:[CenterViewController new]];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNC
                                                            leftDrawerViewController:leftNC
                                                           rightDrawerViewController:nil];
    [self.drawerController setMaximumLeftDrawerWidth:LeftMenuWidth];
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
    //抽屉特殊效果
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    self.window.rootViewController = self.drawerController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initDrawerViewController];
    
    return YES;
}

@end
