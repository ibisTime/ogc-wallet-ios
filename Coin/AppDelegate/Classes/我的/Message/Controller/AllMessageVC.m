//
//  AllMessageVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AllMessageVC.h"
#import "MessageTableView.h"
#import "MessageDetailsVC.h"
@interface AllMessageVC ()<RefreshDelegate>
@property (nonatomic , strong)MessageTableView *tableView;
@end
@implementation AllMessageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailsVC *vc = [MessageDetailsVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
