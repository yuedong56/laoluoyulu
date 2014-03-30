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
#import "LYUserDefaults.h"
#import "NetWorkRequest.h"

//新浪
#define AppKey @"3452838915"
#define AppSecret @"eccb513bf56450c93dc4ae375ef8ed50"
#define RedirectUri @"http://"

//LYAppDelegate
#define APP_DELEGATE ((LYAppDelegate *)[[UIApplication sharedApplication] delegate])
//抽屉结构的宽度
#define LeftMenuWidth 260.0f
#define RightMenuWidth 320.0f
//导航栏主题色
#define Nav_Color [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]
//无网络提示语
#define NONetworkMessage @"你TMD都没开网，点个屌啊！"

//首先将旋转的值由角度转换为弧度
#define degreesToRadinas(x) (M_PI * (x)/180.0)

#endif
