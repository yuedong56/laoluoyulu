//
//  CenterCell.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-27.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "CenterVoiceCell.h"

@implementation CenterVoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //标题
        self.titleLabel = [self labelWithFrame:CGRectMake(16, 6, 200, 20) font:[UIFont systemFontOfSize:16] textColor:BlackColor bgColor:ClearColor alignment:NSTextAlignmentLeft];
        [self addSubview:self.titleLabel];
        
        //副标题
        float detail_y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 1;
        float detail_w = self.titleLabel.frame.size.width;
        self.detailTitleLabel = [self labelWithFrame:CGRectMake(16, detail_y, detail_w, 20) font:[UIFont systemFontOfSize:12] textColor:GrayColor bgColor:ClearColor alignment:NSTextAlignmentLeft];
        [self addSubview:self.detailTitleLabel];
        
        //时长
        float time_h = 20;
        self.timeLabel = [self labelWithFrame:CGRectMake(185, (kCenterVoiceCell_H-time_h)/2, 80, time_h) font:[UIFont systemFontOfSize:12] textColor:GrayColor bgColor:ClearColor alignment:NSTextAlignmentRight];
        [self addSubview:self.timeLabel];
        
        //选中标志
        selectView = [[UIView alloc] initWithFrame:CGRectMake(0/*ScreenWidth-kSelectView_W*/, 0, kSelectView_W, kCenterVoiceCell_H)];
        selectView.backgroundColor = GrayColor;
        [self addSubview:selectView];
        
        //分割线
        seperateLine = [[UIImageView alloc] initWithImage:kSeperateLineImage];
        [self addSubview:seperateLine];
    }
    return self;
}

- (void)setContentWithModel:(VoiceModel *)model index:(int)index
{
    selectView.hidden = YES;

    [self.collectButton removeFromSuperview];
    self.collectButton = nil;
    
    if ([APP_DELEGATE.currentMenuModel.ID intValue] == 0)  //我的收藏
    {
        self.titleLabel.frame = CGRectMake(16, 6, 200, 20);
        self.detailTitleLabel.text = model.menuName;

        self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.collectButton];
        
        [self.collectButton setImage:ImageNamed(@"center_delete") forState:UIControlStateNormal];
    }
    else  //除收藏外其他
    {
        self.titleLabel.frame = CGRectMake(16, (kCenterVoiceCell_H-20)/2, 200, 20);
        self.titleLabel.text = [NSString stringWithFormat:@"%d. %@", index+1, model.name];

        self.collectButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        self.collectButton.tintColor = GrayColor;
        [self addSubview:self.collectButton];
        
        self.collectButton.enabled = model.isCollected ? NO : YES;
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.name];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", model.duration];

    if ([APP_DELEGATE.currentVoiceModel.ID intValue] == [model.ID intValue])
    {
        selectView.hidden = NO;
    }
    
    float collect_x = 44;
    self.collectButton.frame = CGRectMake(ScreenWidth-collect_x-3, (kCenterVoiceCell_H-collect_x)/2, collect_x, collect_x);
    
    self.frame = CGRectMake(0, 0, ScreenWidth, kCenterVoiceCell_H);
    
    seperateLine.frame = CGRectMake(16, kCenterVoiceCell_H-0.5, ScreenWidth-16, 1);
}


@end


