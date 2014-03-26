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

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger menuID;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, assign) NSInteger *size;

@end
