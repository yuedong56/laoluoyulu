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
        selectView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-kSelectView_W, 0, kSelectView_W, kCenterVoiceCell_H)];
        selectView.backgroundColor = GrayColor;
        selectView.hidden = YES;
        [self addSubview:selectView];
    }
    return self;
}

- (void)setContentWithModel:(VoiceModel *)model index:(int)index
{
    self.textLabel.text = [NSString stringWithFormat:@"%d. %@", index+1, model.name];
    [self.collectButton removeFromSuperview];
    self.collectButton = nil;
    
    if ([APP_DELEGATE.currentMenuModel.ID intValue] == 0)  //收藏
    {
        self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.collectButton];
        
        [self.collectButton setImage:ImageNamed(@"center_delete") forState:UIControlStateNormal];
    }
    else  //除收藏外其他
    {
        self.collectButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        self.collectButton.tintColor = GrayColor;
        [self addSubview:self.collectButton];
        
        self.collectButton.enabled = model.isCollected ? NO : YES;
    }
    
    float collect_x = 44;
    self.collectButton.frame = CGRectMake(ScreenWidth-collect_x-3, (44-collect_x)/2, collect_x, collect_x);
    
    self.frame = CGRectMake(0, 0, ScreenWidth, kCenterVoiceCell_H);
}


@end



