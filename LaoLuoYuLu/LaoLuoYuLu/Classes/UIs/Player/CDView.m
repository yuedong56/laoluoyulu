//
//  CDView.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-30.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define Stylus_Width 51
#define Stylus_Height 217

#import "CDView.h"

@implementation CDView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.smallCDImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SmallCDImageView_Width, SmallCDImageView_Height)];
        self.smallCDImageView.image = ImageWithFile(@"icon.png");
        [self addSubview:self.smallCDImageView];
        
        float bcd_x = (ScreenWidth-BigCDImageView_Width)/2;
        self.bigCDImageView = [[UIImageView alloc] initWithFrame:CGRectMake(bcd_x, 0, BigCDImageView_Width, BigCDImageView_Height)];
        self.bigCDImageView.image = ImageWithFile(@"player_cd.png");
        [self addSubview:self.bigCDImageView];
        self.smallCDImageView.center = self.bigCDImageView.center;
        
        self.stylusView = [[StylusView alloc] initWithFrame:CGRectMake(225, 20, Stylus_Width, Stylus_Height)];
        self.stylusView.transform = CGAffineTransformRotate(self.bigCDImageView.transform, degreesToRadinas(18));
        [self addSubview:self.stylusView];
    }
    return self;
}

@end



@implementation StylusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect stylus_frame = CGRectMake(0, 0, Stylus_Width, Stylus_Height);
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:stylus_frame];
        bgImageView.image = ImageWithFile(@"player_stylus_lp_bg.png");
        [self addSubview:bgImageView];
        
        UIImageView *lpImageView = [[UIImageView alloc] initWithFrame:stylus_frame];
        lpImageView.image = ImageWithFile(@"player_stylus_lp.png");
        [self addSubview:lpImageView];
        
        UIImageView *topImageView = [[UIImageView alloc] initWithFrame:stylus_frame];
        topImageView.image = ImageWithFile(@"player_stylus_lp_top.png");
        [self addSubview:topImageView];
    }
    return self;
}

@end