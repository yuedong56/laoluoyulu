//
//  CenterViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterVoiceCell.h"

@interface CenterViewController ()<UIAlertViewDelegate>
{
    NSIndexPath *cancelCollectIndexPath;  //要取消收藏的语音
}
@end

@implementation CenterViewController

- (instancetype)initWithMenu:(MenuModel *)menu
{
    self = [super init];
    if (self) {
        APP_DELEGATE.currentMenuModel = menu;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.titleLabel.text = APP_DELEGATE.currentMenuModel.name;
    
    //导航栏左按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float w = 44;
    leftButton.frame = CGRectMake(8, 0, w, w);
    [leftButton setImage:ImageWithFile(@"center_leftButton.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftButton];
    
    //导航栏右按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float r_w = 44;
    rightButton.frame = CGRectMake(ScreenWidth-r_w-3, 1, r_w, r_w);
    [rightButton setImage:ImageWithFile(@"center_currentPlay.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rightButton];
    
    //列表
    self.voiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.voiceTableView.separatorColor = ClearColor;
    [self.view addSubview:self.voiceTableView];
    //刷新列表
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.01];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

//刷新reloadData
- (void)reloadData
{
    self.voiceTableView.dataSource = self;
    self.voiceTableView.delegate = self;
    self.voiceListArr  = [[LYDataManager instance] selectVoiceListWithMenuID:APP_DELEGATE.currentMenuModel.ID];
    [self.voiceTableView reloadData];
}

#pragma mark - Button Events
- (void)leftButtonClick:(UIButton *)button
{
    [APP_DELEGATE showLeftSideView];
}

- (void)rightButtonClick:(UIButton *)button
{
    [APP_DELEGATE.playerView showWithModel:APP_DELEGATE.currentVoiceModel];
}

/** 添加收藏、删除收藏按钮 */
- (void)collectButtonClick:(UIButton *)button event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.voiceTableView];
    NSIndexPath *indexPath = [self.voiceTableView indexPathForRowAtPoint:currentTouchPosition];
    
    if (!indexPath) {
        return;
    }

    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    
    if ([APP_DELEGATE.currentMenuModel.ID intValue] == 0) //收藏
    {
        cancelCollectIndexPath = indexPath;
        [UIView showAlertWithTitle:@"提示" msg:[NSString stringWithFormat:@"确定删除对 [%@] 的收藏？删除只会删掉该收藏记录，不会删掉语音！", voiceModel.name] tag:1000 delegate:self btnTitle:@"确定删除" otherBtnTitle:@"取消"];
    }
    else
    {
        voiceModel.isCollected = YES;
        [[LYDataManager instance] updateVoiceIsCollected:voiceModel.isCollected
                                                 voiceID:voiceModel.ID];
        
        [self.voiceTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [APP_DELEGATE showToastView:@"已加入收藏!"];
    }
}

/** 取消收藏语音 */
- (void)cancelCollectWithIndexPaht:(NSIndexPath *)indexPath
{
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    voiceModel.isCollected = NO;
    [[LYDataManager instance] updateVoiceIsCollected:voiceModel.isCollected
                                             voiceID:voiceModel.ID];
    
    [self.voiceListArr removeObjectAtIndex:indexPath.row];
    [self.voiceTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000)
    {
        if (buttonIndex == 0)
        {  //删除收藏
            [self cancelCollectWithIndexPaht:cancelCollectIndexPath];
        }
    }
}

#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.voiceListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    CenterVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CenterVoiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    [cell setContentWithModel:voiceModel index:(int)indexPath.row];
    [cell.collectButton addTarget:self
                           action:@selector(collectButtonClick:event:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CenterVoiceCell *cell = (CenterVoiceCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark - UITableView dataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    //播放语音
    [APP_DELEGATE performSelectorInBackground:@selector(playWithModel:) withObject:voiceModel];
    
    APP_DELEGATE.currentVoiceLists = [NSMutableArray arrayWithArray:self.voiceListArr];
    APP_DELEGATE.currentVoiceIndex = (int)indexPath.row;
    
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [APP_DELEGATE.currentMenuModel.ID intValue]==0 ? YES : NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self cancelCollectWithIndexPaht:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end


