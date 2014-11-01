//
//  LYTimeUtils.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14/11/1.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

typedef enum {
    DateFormatHourAll,         //显示时分秒，如，“09:23:12”
    DateFormatHourMinute,      //显示时分，如，“09:23”
    DateFormatMinuteSecond,    //显示分秒，如，“12:21”
    DateFormatMonth,           //显示月日，如，“12-23”
    DateFormatYear             //显示年份，如，“2013”
} DateFormat;  //时间格式

#import <Foundation/Foundation.h>

@interface LYTimeUtils : NSObject

/** NSDate转为NSString */
+ (NSString *)stringFromDate:(NSDate *)date format:(DateFormat)dateFormat;

/** 将秒转为时间 XX:XX */
+ (NSString *)timeFormatted:(int)totalSeconds;

@end
