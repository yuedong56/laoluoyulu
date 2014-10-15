//
//  CenterViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterVoiceCell.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (instancetype)initWithMenu:(MenuModel *)menu
{
    self = [super init];
    if (self) {
        self.currentMenuModel = menu;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.titleLabel.text = self.currentMenuModel.name;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float w = 44;
    leftButton.frame = CGRectMake(8, 0, w, w);
    [leftButton setImage:ImageWithFile(@"center_leftButton.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float r_w = 44;
    rightButton.frame = CGRectMake(ScreenWidth-r_w-3, 1, r_w, r_w);
    [rightButton setImage:ImageWithFile(@"center_currentPlay.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rightButton];
    
    self.voiceListArr = [[LYDataManager instance] selectVoiceListWithMenuID:self.currentMenuModel.ID];

    self.voiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)
                                                       style:UITableViewStylePlain];
    self.voiceTableView.dataSource = self;
    self.voiceTableView.delegate = self;
    [self.view addSubview:self.voiceTableView];
}

#pragma mark - Button Events
- (void)leftButtonClick:(UIButton *)button
{
    [APP_DELEGATE showLeftSideView];
}

- (void)rightButtonClick:(UIButton *)button
{
//    self presentViewController:<#(UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>
}

- (void)collectButtonClick:(UIButton *)button event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.voiceTableView];
    NSIndexPath *indexPath = [self.voiceTableView indexPathForRowAtPoint:currentTouchPosition];
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    voiceModel.isCollected = !voiceModel.isCollected;
    [[LYDataManager instance] updateVoiceIsCollected:voiceModel.isCollected
                                             voiceID:[NSString stringWithFormat:@"%d", voiceModel.ID]];
    
    [self.voiceTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
        cell = [[CenterVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    [cell setContentWithModel:voiceModel index:(int)indexPath.row];
    [cell.collectButton addTarget:self
                           action:@selector(collectButtonClick:event:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UITableView dataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    PlayerViewController *vc = [[PlayerViewController alloc] initWithModel:voiceModel];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:NULL];
}

@end


