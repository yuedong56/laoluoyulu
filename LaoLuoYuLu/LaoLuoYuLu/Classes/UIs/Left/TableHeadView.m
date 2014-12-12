//
//  TableHeadView.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-13.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "TableHeadView.h"

@implementation TableHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, (TableHeader_Height-HeadImage_Width)/2, HeadImage_Width, HeadImage_Width)];
        self.headImageView.layer.cornerRadius = HeadImage_Width/2;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.image = ImageNamed(@"left_chuizilogo");
        self.headImageView.backgroundColor = RedColor;
        [self addSubview:self.headImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LeftMenuWidth, TableHeader_Height)];
        self.titleLabel.backgroundColor = ClearColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"罗永浩";
        self.titleLabel.textColor = WhiteColor;
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.titleLabel];
        
        UIImageView *sinaLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, 26, 25, 25)];
        sinaLogoImageView.image = ImageNamed(@"left_sina");
        [self addSubview:sinaLogoImageView];
    }
    return self;
}

@end
