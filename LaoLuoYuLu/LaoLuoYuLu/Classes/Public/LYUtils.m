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

/** 评分、升级时跳到 AppStore */
+ (void)goToAppstore
{
    NSString *iTunesLink = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8", AppStoreID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

/** 将json字符串转为字典(NSDictionary) */
+ (NSDictionary *)toDictionaryWithJsonString:(NSString *)jsonStr
{
    if (jsonStr) {
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        return jsonDic;
    }
    return nil;
}

/** 将id类型(如NSArray、NSDictionary)转为json字符串 */
+ (NSString *)toJsonStringWithData:(id)data
{
    if (data)
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        if ([jsonData length] > 0 && error == nil) {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

@end


