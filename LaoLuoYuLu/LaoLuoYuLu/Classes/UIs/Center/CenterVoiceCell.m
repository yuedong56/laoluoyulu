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
        self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collectButton.tintColor = LightGrayColor;
        [self addSubview:self.collectButton];
        
        selectView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-kSelectView_W, 0, kSelectView_W, kCenterVoiceCell_H)];
        selectView.backgroundColor = GrayColor;
        selectView.hidden = YES;
        [self addSubview:selectView];
        
        self.frame = CGRectMake(0, 0, ScreenWidth, kCenterVoiceCell_H);
    }
    return self;
}

- (void)setContentWithModel:(VoiceModel *)model index:(int)index
{
    self.textLabel.text = [NSString stringWithFormat:@"%d. %@", index+1, model.name];
    
//    if ([APP_DELEGATE.currentMenuModel.ID intValue] == 0)  //收藏
//    {
//        self.collectButton.frame = CGRectZero;
//    }
//    else  //其他
//    {
        float collect_x = 44;
        self.collectButton.frame = CGRectMake(ScreenWidth-collect_x, (44-collect_x)/2, collect_x, collect_x);
//    }
    [self.collectButton setImage:ImageNamed(@"delete5") forState:UIControlStateNormal];
//    [self.collectButton setImage:ImageNamed(@"center_delete0") forState:UIControlStateHighlighted];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end



