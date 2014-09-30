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
        [self addSubview:self.collectButton];
    }
    return self;
}

- (void)setContentWithModel:(VoiceModel *)model index:(int)index
{
    self.textLabel.text = [NSString stringWithFormat:@"%d. %@", index+1, model.name];
    
    float collect_x = 44;
    self.collectButton.frame = CGRectMake(ScreenWidth-collect_x, (44-collect_x)/2, collect_x, collect_x);
    [self.collectButton setImage:ImageNamed(model.isCollected ? @"center_collection_s" : @"center_collection_n") forState:UIControlStateNormal];
    [self.collectButton setImage:ImageNamed(@"center_collection_s.png") forState:UIControlStateHighlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
