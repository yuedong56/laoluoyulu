//
//  VoiceModel.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  语音

#import <Foundation/Foundation.h>

@interface VoiceModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *menuID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *menuName;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, assign) BOOL isCollected;  //是否已经收藏入播放列表

- (instancetype)initVoiceFromDataBaseWithDic:(NSDictionary *)dic;

@end
