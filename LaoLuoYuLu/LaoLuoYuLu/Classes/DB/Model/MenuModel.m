//
//  MenuModel.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

- (id)initMenuFromDataBaseWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.ID = [[dic valueForKey:@"id"] integerValue];
        self.name = [NSString stringWithFormat:@"%@",[dic valueForKey:@"name"]];
    }
    return self;
}

@end
