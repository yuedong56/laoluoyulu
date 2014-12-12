//
//  AboutViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-9.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define kAboutHeader_H 220
#define kAboutCell_H 44

#import "AboutViewController.h"
#import "MyWeiboViewController.h"

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *table;
}

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_F(0.9);
    
    [self setNavStyle];
    [self initTable];
}

/** 设置导航栏样式 */
- (void)setNavStyle
{
    self.title = @"关于";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:WhiteColor forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIFont boldSystemFontOfSize:20] forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    self.navigationController.navigationBar.barTintColor = GrayColor;
    self.navigationController.navigationBar.tintColor = WhiteColor; //返回按钮颜色
    
    self.navigationItem.leftBarButtonItem.tintColor = WhiteColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/** 初始化 tableView */
- (void)initTable
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kAboutHeader_H+kAboutCell_H*3) style:UITableViewStylePlain];
    table.separatorColor = ClearColor;
    table.bounces = NO;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

#pragma mark - UITableView Delegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier = @"cellIndetifier";
    AboutCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (!cell) {
        cell = [[AboutCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndetifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"当前版本";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"V%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setContentWithType:NO];
        } break;
        case 1:
        {
            cell.textLabel.text = @"官方QQ群";
            cell.detailTextLabel.text = @"263372594";
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setContentWithType:NO];
        } break;
        case 2:
        {
            cell.textLabel.text = @"关注作者微博";
            cell.detailTextLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            [cell setContentWithType:YES];
        } break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutCell *cell = (AboutCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kAboutHeader_H;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kAboutHeader_H)];
    headerView.backgroundColor = COLOR_F(0.9);
    //logo
    float logo_w = 60;
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-logo_w)/2, 100, logo_w, logo_w)];
    logoImageView.image = ImageWithFile(@"icon_120.png");
    logoImageView.layer.cornerRadius = 10;
    logoImageView.layer.masksToBounds = YES;
    [headerView addSubview:logoImageView];
    
    //title
    float label_y = logoImageView.frame.origin.y + logoImageView.frame.size.height + 5;
    CGRect label_frame = CGRectMake(0, label_y, ScreenWidth, 40);
    UILabel *appNameLabel = [self.view labelWithFrame:label_frame
                                                 font:FONT_BOLD(18)
                                            textColor:DarkGrayColor
                                              bgColor:ClearColor
                                            alignment:NSTextAlignmentCenter];
    appNameLabel.text = @"老罗语录";
    [headerView addSubview:appNameLabel];
    
    //line
    UIImageView *seperateLine = [[UIImageView alloc] initWithImage:kSeperateLineImage];
    seperateLine.frame = CGRectMake(0, kAboutHeader_H-1, ScreenWidth, 1);
    [headerView addSubview:seperateLine];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        MyWeiboViewController *vc = [[MyWeiboViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end




@implementation AboutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //分割线
        seperateLine = [[UIImageView alloc] initWithImage:kSeperateLineImage];
        [self addSubview:seperateLine];
        
        self.frame = CGRectMake(0, 0, ScreenWidth, kAboutCell_H);
    }
    return self;
}

/** isLast: 是否是最后一个cell */
- (void)setContentWithType:(BOOL)isLast
{
    if (isLast) {
        seperateLine.frame = CGRectMake(0, kAboutCell_H-0.5, ScreenWidth, 1);
    } else {
        seperateLine.frame = CGRectMake(16, kAboutCell_H-0.5, ScreenWidth-32, 1);
    }
}

@end

