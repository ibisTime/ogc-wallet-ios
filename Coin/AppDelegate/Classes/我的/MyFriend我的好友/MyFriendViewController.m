//
//  MyFriendViewController.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/29.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "MyFriendViewController.h"
#import "MyFriendTableView.h"
#import "MyFriendModel.h"
@interface MyFriendViewController ()<RefreshDelegate>

@property (nonatomic , strong)NSMutableArray <MyFriendModel *>*models;

@property (nonatomic , strong)MyFriendTableView *tableView;

@end

@implementation MyFriendViewController

-(MyFriendTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MyFriendTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.showsHorizontalScrollIndicator = YES;

        self.tableView.refreshDelegate = self;
        self.tableView.defaultNoDataImage = kImage(@"暂无好友");
        self.tableView.defaultNoDataText = [LangSwitcher switchLang:@"暂无好友" key:nil];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"我的好友" key:nil];
    self.navigationItem.titleView = self.titleText;
    [self.view addSubview:self.tableView];
    [self LoadData];
}

-(void)LoadData
{
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.code = @"805122";
    helper.parameters[@"userId"] = [TLUser user].userId;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[MyFriendModel class]];
    
    
    CoinWeakSelf;
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            //去除没有的币种
            weakSelf.models = objs;
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView beginRefreshing];
    [self.tableView addLoadMoreAction:^{
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            if (weakSelf.tl_placeholderView.superview != nil) {
                [weakSelf removePlaceholderView];
            }
            weakSelf.models = objs;
            weakSelf.tableView.models = objs;
            //        weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
}


@end
