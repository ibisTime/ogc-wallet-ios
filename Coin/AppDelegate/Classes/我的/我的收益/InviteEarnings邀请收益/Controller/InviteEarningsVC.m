//
//  InviteEarningsVC.m
//  Coin
//
//  Created by QinBao Zheng on 2018/10/9.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "InviteEarningsVC.h"
#import "InviteEarningsTableView.h"
#import "InviteEarningsModel.h"
@interface InviteEarningsVC ()<RefreshDelegate>



@property (nonatomic , strong)NSMutableArray <InviteEarningsModel *>*model;

@property (nonatomic , strong)InviteEarningsTableView *tableView;
@property (nonatomic , strong)NSMutableArray *dataArray;
@end

@implementation InviteEarningsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
//    UILabel *titleText = [[UILabel alloc] init];
//    titleText.textAlignment = NSTextAlignmentCenter;
//    titleText.backgroundColor = [UIColor clearColor];
//    titleText.textColor=kTextColor;
//    [titleText setFont:[UIFont systemFontOfSize:17.0]];
    [self.titleText setText:[LangSwitcher switchLang:@"邀请收益" key:nil]];
    self.navigationItem.titleView = self.titleText;

    
    [self LoadData];


}

-(void)LoadData
{
    CoinWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];

    helper.code = @"625802";
    helper.parameters[@"userId"] = [TLUser user].userId;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[InviteEarningsModel class]];
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.tableView.array = [NSMutableArray array];
//            weakSelf.dataArray = [NSMutableArray array];

//            [weakSelf.dataArray addObjectsFromArray:array];
            weakSelf.tableView.array = [InviteEarningsVC filterMaxItemsArray:objs filterKey:@"workDate"];
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {

        }];
    }];
    [self.tableView beginRefreshing];

    [self.tableView addLoadMoreAction:^{
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {

            if (weakSelf.tl_placeholderView.superview != nil) {

                [weakSelf removePlaceholderView];
            }

            weakSelf.tableView.array = [InviteEarningsVC filterMaxItemsArray:objs filterKey:@"workDate"];
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {

            [weakSelf addPlaceholderView];
        }];
    }];

    [self.tableView endRefreshingWithNoMoreData_tl];
}

+ (NSMutableArray *)filterMaxItemsArray:(NSArray *)array filterKey:(NSString *)key {
    NSMutableArray *origArray = [NSMutableArray arrayWithArray:array];
    NSMutableArray *filerArray = [NSMutableArray array];

    while (origArray.count > 0) {
        id obj = origArray.firstObject;
        NSPredicate *predic = nil;

        id value = [obj valueForKey:key];
        predic = [NSPredicate predicateWithFormat:@"self.%@ == %@",key,value];

        NSArray *pArray = [origArray filteredArrayUsingPredicate:predic];
        [filerArray addObject:pArray];
        [origArray removeObjectsInArray:pArray];
    }
    return filerArray;
}

- (void)initTableView {
    self.tableView = [[InviteEarningsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    
    self.tableView.defaultNoDataImage = kImage(@"暂无订单");
    self.tableView.defaultNoDataText = [LangSwitcher switchLang:@"暂无明细" key:nil];
    [self.view addSubview:self.tableView];
}



@end
