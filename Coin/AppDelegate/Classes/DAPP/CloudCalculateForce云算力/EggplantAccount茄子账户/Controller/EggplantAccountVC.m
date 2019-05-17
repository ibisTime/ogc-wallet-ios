//
//  EggplantAccountVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "EggplantAccountVC.h"
#import "EggplantAccountHeadView.h"
#import "EggplantAccountTableView.h"
#import "FlashAgainstVC.h"
@interface EggplantAccountVC ()<RefreshDelegate>

@property (nonatomic , strong)EggplantAccountTableView *tableView;

@property (nonatomic , strong)EggplantAccountHeadView *headView;

@end

@implementation EggplantAccountVC

-(EggplantAccountHeadView *)headView
{
    if (!_headView) {
        _headView = [[EggplantAccountHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        [_headView.exchangeBtn addTarget:self action:@selector(exchangeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headView;
}

-(void)exchangeBtnClick
{
    FlashAgainstVC *vc = [FlashAgainstVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"茄子账户";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[EggplantAccountTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}

@end
