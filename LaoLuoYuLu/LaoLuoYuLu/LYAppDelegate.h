//
//  LYAppDelegate.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MBProgressHUD.h"

@interface LYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MMDrawerController *drawerController;

@property (nonatomic, strong) MBProgressHUD *progressHUD;

- (void)showProgressHUDWithText:(NSString *)text;
- (void)hideProgressHUDWithText:(NSString *)text;

@end
