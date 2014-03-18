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

/** 
 * @brief 检查网络是否可用
 */
+ (BOOL)checkNetworkAvailable;

/**
 * @brief 检查网络状态类型（wifi、2G/3G）
 */
+ (NetworkStatus)checkNetworkStateType;

/**
 * @brief 获取photo句柄单例
 */
+ (ALAssetsLibrary *)defaultAssetsLibrary;

@end
