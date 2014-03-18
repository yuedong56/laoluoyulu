//
//  LYUtils.m
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-5.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "LYUtils.h"

@implementation LYUtils

#pragma mark - 网络检查
/**
 * @brief 检查网络是否可用
 */
+ (BOOL)checkNetworkAvailable {
	Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

/**
 * @brief 检查网络状态类型（wifi、2G/3G）
 */
+ (NetworkStatus)checkNetworkStateType {
	Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
	return status;
}

/**
 * @brief 获取photo句柄单例
 */
+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}

@end
