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
        //选中标志
        selectView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-kSelectView_W, 0, kSelectView_W, kCenterVoiceCell_H)];
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
        self.textLabel.text = [NSString stringWithFormat:@"%@", model.name];
        self.detailTextLabel.text = [NSString stringWithFormat:@" 时长 : %@", model.duration];

        self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.collectButton];
        
        [self.collectButton setImage:ImageNamed(@"center_delete") forState:UIControlStateNormal];
    }
    else  //除收藏外其他
    {
        self.textLabel.text = [NSString stringWithFormat:@"%d. %@", index+1, model.name];
        self.detailTextLabel.text = [NSString stringWithFormat:@"     时长 : %@", model.duration];

        self.collectButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        self.collectButton.tintColor = GrayColor;
        [self addSubview:self.collectButton];
        
        self.collectButton.enabled = model.isCollected ? NO : YES;
    }
    
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



