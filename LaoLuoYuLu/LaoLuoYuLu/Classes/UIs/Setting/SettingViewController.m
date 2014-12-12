//
//  SettingViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-8.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define kHeaderColor COLOR_F(0.9)
#define kHeaderHeight 26

#import "SettingViewController.h"
#import "SettingCell.h"

#import "AboutViewController.h"
#import "SuggestViewController.h"

@interface SettingViewController ()<UIAlertViewDelegate>
{
    UITableView *table;
    NSMutableArray *lists;
}

@end

@implementation SettingViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initLists];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self setNavStyle];
    [self initTableView];
}

/** 设置导航栏样式 */
- (void)setNavStyle
{
    self.title = @"设置";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:WhiteColor forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIFont boldSystemFontOfSize:20] forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    self.navigationController.navigationBar.barTintColor = GrayColor;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(leftButtonPress:)];
    item.tintColor = WhiteColor;
    self.navigationItem.leftBarButtonItem = item;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/** 初始化数组 */
- (void)initLists
{
    lists = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableArray *sections0 = [NSMutableArray arrayWithCapacity:0];
    [sections0 addObject:@"吐槽提意见"];
    [lists addObject:sections0];
    
    NSMutableArray *sections1 = [NSMutableArray arrayWithCapacity:0];
    [sections1 addObject:@"检查更新"];
    [sections1 addObject:@"我要打分"];
    [lists addObject:sections1];
    
    NSMutableArray *sections2 = [NSMutableArray arrayWithCapacity:0];
    [sections2 addObject:@"关于"];
    [lists addObject:sections2];
}

/** 初始化列表 */
- (void)initTableView
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = kHeaderColor;
    table.bounces = NO;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
}

#pragma mark - Button Events
/** 取消按钮 */
- (void)leftButtonPress:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return lists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *sectionArr = [lists objectAtIndex:section];
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier = @"cellIndetifier";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    
    if (!cell)
    {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIndetifier];
    }
    
    if (indexPath.section==1 && indexPath.row==0)  //分割线
    {
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 1)];
        line.image = kSeperateLineImage;
        [cell addSubview:line];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSMutableArray *secArr = [lists objectAtIndex:indexPath.section];
    NSString *title = [secArr objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeaderHeight)];
    headerView.backgroundColor = kHeaderColor;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeaderHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {//吐槽提意见
                SuggestViewController *vc = [[SuggestViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } break;
        case 1:
        {
            if (indexPath.row == 0) {//检查更新
                [NetWorkRequest requestUpdateWithAppID:AppStoreID
                                                 block:^(id data, NSError *error)
                 {
                     CLog(@"检查版本更新-%@", data);
                     if (data)
                     {
                         //AppStore版本号
                         NSString *version_appstore = [data valueForKey:@"version"];
                         
                         //本地版本
                         NSString *version_local = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                         if (![version_appstore isEqualToString:version_local])
                         {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本 V%@", version_appstore] message:@"是否立即升级到最新版本？" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新", nil];
                             alert.tag = 2000;
                             [alert show];
                         }
                         else
                         {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您当前版本已为最新版本，暂不需要更新！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                             [alert show];
                         }
                     }
                     else
                     {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请稍后重试！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                         [alert show];
                     }
                }];
            } else if (indexPath.row == 1) {//我要打分
                [LYUtils goToAppstore];
            }
        } break;
        case 2:
        {
            if (indexPath.row == 0) {//关于
                AboutViewController *vc = [[AboutViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } break;
        default: break;
    }
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 2000:
        {
            if (buttonIndex == 1) {
                [LYUtils goToAppstore];
            }
        } break;
        default: break;
    }
}

@end


