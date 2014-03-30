//
//  CDView.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-30.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "CDView.h"

@implementation CDView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float cd_x = (ScreenWidth-CDImageView_Width)/2;
        self.CDImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cd_x, 0, CDImageView_Width, CDImageView_Height)];
        self.CDImageView.image = ImageWithFile(@"player_cd.png");
        [self addSubview:self.CDImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
