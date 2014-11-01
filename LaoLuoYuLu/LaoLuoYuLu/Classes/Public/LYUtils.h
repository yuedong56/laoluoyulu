//
//  LYUtils.h
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-5.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  常用公共方法

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LYUtils : NSObject

#pragma 网络检查

/** 检查网络是否可用 */
+ (BOOL)checkNetworkAvailable;

/** 检查网络状态类型（wifi、2G/3G）*/
+ (NetworkStatus)checkNetworkStateType;

/** 获取photo句柄单例 */
+ (ALAssetsLibrary *)defaultAssetsLibrary;

@end
