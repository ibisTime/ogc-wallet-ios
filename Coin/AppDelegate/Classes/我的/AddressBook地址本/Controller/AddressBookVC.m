//
//  AddressBookVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AddressBookVC.h"
#import "AddressBookTableView.h"
#import "AddAddressVC.h"
#import "AddressModel.h"
@interface AddressBookVC ()<RefreshDelegate>



@property (nonatomic , strong)AddressBookTableView *tableView;
@property (nonatomic , strong)NSMutableArray <AddressModel *>*models;
@end
@implementation AddressBookVC



-(AddressBookTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[AddressBookTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.showsHorizontalScrollIndicator = YES;
        self.tableView.refreshDelegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"地址本" key:nil];
    self.navigationItem.titleView = self.titleText;
    [self.view addSubview:self.tableView];
    
    [self.RightButton theme_setTitleIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    [self.RightButton setTitle:@"添加" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(RightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    
    [self LoadData];
}

-(void)RightButtonClick
{
    AddAddressVC *vc = [AddAddressVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.code = @"802015";
    helper.parameters[@"userId"] = [TLUser user].userId;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[AddressModel class]];
    
    
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
