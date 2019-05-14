//
//  FlashAgainstVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FlashAgainstVC.h"
#import "FlashAgainstHeaderView.h"
#import "FlashAgainstTableView.h"
@interface FlashAgainstVC ()<RefreshDelegate>

@property (nonatomic , strong)FlashAgainstTableView *tableView;

@property (nonatomic , strong)FlashAgainstHeaderView *headView;

@end

@implementation FlashAgainstVC

-(FlashAgainstHeaderView *)headView
{
    if (!_headView) {
        _headView = [[FlashAgainstHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 402)];
        [_headView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = @"闪兑";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[FlashAgainstTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.tableView theme_setBackgroundColorIdentifier:@"headerViewColor" moduleName:ColorName];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
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
