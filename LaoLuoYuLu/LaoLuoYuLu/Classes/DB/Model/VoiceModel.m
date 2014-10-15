//
//  VoiceModel.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "VoiceModel.h"

@implementation VoiceModel

- (instancetype)initVoiceFromDataBaseWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.ID       = [[dic valueForKey:@"id"] integerValue];
        self.menuID   = [[dic valueForKey:@"menu_id"] integerValue];
        self.name     = [NSString stringWithFormat:@"%@",[dic valueForKey:@"name"]];
        self.duration = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duration"]];
        self.size     = [NSString stringWithFormat:@"%@",[dic valueForKey:@"size"]];
        self.isCollected = [[NSString stringWithFormat:@"%@", [dic valueForKey:@"is_recommend"]] boolValue];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"_ID = %d, _menuID = %d, _name = %@, _duration = %@, _size = %@, _isCollected = %d", (int)_ID, (int)_menuID, _name, _duration, _size, _isCollected];
}

@end
