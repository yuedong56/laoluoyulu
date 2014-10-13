//
//  LeftMenuViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define Header_Height 25

#import "LeftMenuViewController.h"
#import "WeiBoViewController.h"
#import "CenterViewController.h"
#import "LeftMenuCell.h"
#import "MenuModel.h"
#import "SettingViewController.h"

@interface LeftMenuViewController ()
{
    NSIndexPath *selectIndexPath;  //当前选择的indexPath
}
@property (nonatomic, strong) NSMutableArray *imagesArr;//左侧图标数组

@end

@implementation LeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.view.backgroundColor = DarkGrayColor;
    self.navigationController.navigationBarHidden = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.menuListArr = [[LYDataManager instance] selectMenuList];
    self.imagesArr = [self getImagesArray];
    
    [self initTableHeadView];
    [self initTableFootView];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (selectIndexPath.section==0) {
        [self.tableView selectRowAtIndexPath:selectIndexPath
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    }
}

/**
 * @brief 左侧图标数组
 */
- (NSMutableArray *)getImagesArray
{
    NSArray *section1Arr = [NSArray arrayWithObjects:
                            @"left_all.png",
                            @"left_first.png",
                            @"left_second.png",
                            @"left_third.png",
                            @"left_four.png",
                            @"left_five.png",
                            @"left_otherVoice.png", nil];
    NSArray *section2Arr = [NSArray arrayWithObjects:
                            @"left_setting.png",
                            @"left_recommend.png", nil];
    return [NSMutableArray arrayWithObjects:section1Arr,section2Arr, nil];
}

/**
 * @brief 初始化 TableHeadView
 */
- (void)initTableHeadView
{
    self.tableHeadView = [[TableHeadView alloc] initWithFrame:CGRectMake(0, 0, LeftMenuWidth, TableHeader_Height)];
    self.tableHeadView.backgroundColor = DarkGrayColor;
    self.tableView.tableHeaderView = self.tableHeadView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHeadViewTapGesture:)];
    [self.tableHeadView addGestureRecognizer:tap];
}

/**
 * @brief 初始化 TableFootView
 */
- (void)initTableFootView
{
    self.tableFootView = [[TableFootView alloc] initWithFrame:CGRectMake(0, 0, LeftMenuWidth, TableFooter_Height)];
    self.tableFootView.backgroundColor = DarkGrayColor;
    self.tableView.tableFooterView = self.tableFootView;
}

#pragma mark - Gesture
- (void)handleHeadViewTapGesture:(UITapGestureRecognizer *)gesture
{
    if (![LYUtils checkNetworkAvailable]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你妹" message:NONetworkMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    } else {
        CLog(@"弹出老罗微博页面！");
        WeiBoViewController *weiboVC = [WeiBoViewController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:weiboVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.menuListArr.count;
    } else if (section == 1) {
        return 2;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIView *selectedBGView = [[UIView alloc] init];
    selectedBGView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    cell.selectedBackgroundView = selectedBGView;
    
    if (indexPath.section == 0) {
        MenuModel *model = [self.menuListArr objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.name;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"系统设置";
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"应用推荐";
        }
    }
    
    NSArray *imageArr = [self.imagesArr objectAtIndex:indexPath.section];
    cell.leftImageView.image = ImageNamed([imageArr objectAtIndex:indexPath.row]);

    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Row_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Header_Height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LeftMenuWidth, Header_Height)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerView.frame];
    titleLabel.backgroundColor = GrayColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textColor = WhiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    
    if (section == 0) {
        titleLabel.text = @"老罗语录";
    } else {
        titleLabel.text = @"设置";
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)  //老罗语录
    {
        MenuModel *menu = [self.menuListArr objectAtIndex:indexPath.row];
        CenterViewController *centerVC = [[CenterViewController alloc] initWithMenu:menu];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:centerVC];
        [APP_DELEGATE.drawerController setCenterViewController:nav
                                            withCloseAnimation:YES
                                                    completion:nil];
    }
    else if (indexPath.section == 1)  //设置
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == 0)
        {//系统设置
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[SettingViewController alloc] init]];
            [self presentViewController:nav animated:YES completion:NULL];
        }
        else if (indexPath.row == 1)
        {//应用推荐
            
        }
    }
    
    selectIndexPath = indexPath;
}

@end


