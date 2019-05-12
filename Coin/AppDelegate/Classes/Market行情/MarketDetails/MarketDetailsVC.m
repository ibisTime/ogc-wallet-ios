//
//  MarketDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MarketDetailsVC.h"
#import "MarketDetaiilsTableView.h"
#import "MarketDetaiilsHeadView.h"
@interface MarketDetailsVC ()<RefreshDelegate,MarketDetaiilsHeadDelegate>

@property (nonatomic ,strong)MarketDetaiilsTableView *tableView;
@property (nonatomic , strong)MarketDetaiilsHeadView *headView;
@end

@implementation MarketDetailsVC


-(MarketDetaiilsTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MarketDetaiilsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.showsHorizontalScrollIndicator = YES;
        self.tableView.refreshDelegate = self;
        self.tableView.name = @"行情";
    }
    return _tableView;
}

-(MarketDetaiilsHeadView *)headView
{
    if (!_headView) {
        _headView = [[MarketDetaiilsHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500)];
        _headView.delegate = self;
    }
    return _headView;
}

-(void)MarketDetaiilsHeadButton:(UIButton *)sender
{
    if (sender.tag == 100) {
        self.tableView.name = @"行情";
    }else
    {
        self.tableView.name = @"简况";
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"BTC/USDT";
    self.navigationItem.titleView = self.titleText;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
