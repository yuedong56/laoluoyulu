//
//  PlayerViewController.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-28.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  播放器页面

#import "BaseViewController.h"
#import "VoiceModel.h"
#import "CDView.h"
#import "ControlView.h"

@interface PlayerViewController : BaseViewController

@property (nonatomic, strong) VoiceModel *currentVoiceModel;
@property (nonatomic, strong) CDView *cdView;
@property (nonatomic, strong) ControlView *controlView;

@end
