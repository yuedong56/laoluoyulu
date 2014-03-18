//
//  GlobalConfig.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#ifndef LaoLuoYuLu_GlobalConfig_h
#define LaoLuoYuLu_GlobalConfig_h

#import "LYDataManager.h"
#import "Reachability.h"
#import "LYAppDelegate.h"
#import "LYUtils.h"
//#import "LYUserDefaults.h"
//#import "NetWorkRequest.h"

//LYAppDelegate
#define APP_DELEGATE ((LYAppDelegate *)[[UIApplication sharedApplication] delegate])
//左侧抽屉结构的宽度
#define LeftMenuWidth 260.0f
//导航栏主题色
#define Nav_Color [UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:1];
//无网络提示语
#define NONetworkMessage @"你他妈的都开没网，点个屌啊！"

#endif
