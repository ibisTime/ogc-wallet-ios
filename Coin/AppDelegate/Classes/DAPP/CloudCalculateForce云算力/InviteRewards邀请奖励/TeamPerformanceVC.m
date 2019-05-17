//
//  TeamPerformanceVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TeamPerformanceVC.h"
#import "TeamPerFormanceTableView.h"
@interface TeamPerformanceVC ()
@property (nonatomic , strong)TeamPerFormanceTableView *tableView;
@end

@implementation TeamPerformanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[TeamPerFormanceTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - self.y) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    
}

@end
