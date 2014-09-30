//
//  LYDataManager.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define DataFileName @"dataList.sqlite" //数据库文件名

//table 名称
#define kMenuTable @"Menu"
#define kVoiceTable @"Voice"

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface LYDataManager : NSObject

@property (nonatomic, strong) FMDatabase *lyDB;

+ (id)instance;

/**
 * @brief 获取菜单列表
 */
- (NSMutableArray *)selectMenuList;

/**
 * @brief 根据菜单ID获取语音列表
 */
- (NSMutableArray *)selectVoiceListWithMenuID:(NSInteger)menuID;

/** 获取已收藏的语音列表 */
- (NSMutableArray *)selectCollectedVoices;

/** 收藏、取消收藏 */
- (void)updateVoiceIsCollected:(BOOL)isCollected voiceID:(NSString *)voiceID;

@end
