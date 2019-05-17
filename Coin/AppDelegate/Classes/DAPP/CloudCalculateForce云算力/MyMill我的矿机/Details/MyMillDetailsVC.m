//
//  MyMillDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillDetailsVC.h"
#import "MyMillDetailsTableView.h"
@interface MyMillDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)MyMillDetailsTableView *tableView;

@end

@implementation MyMillDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"矿机运行详情";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[MyMillDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight ) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
