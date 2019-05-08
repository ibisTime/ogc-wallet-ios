//
//  ZHShopListVC.m
//  ZHCustomer
//
//  Created by  tianlei on 2016/12/23.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLCoinWithdrawOrderVC.h"

//#import "ZHShopCell.h"
#import "TLPageDataHelper.h"
#import "TLUIHeader.h"
#import "TLTableView.h"
#import "TLCoinWithdrawModel.h"
#import "TLCoinWithdrawOrderCell.h"

@interface TLCoinWithdrawOrderVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) TLTableView *orderTableView;
//公告view
@property (nonatomic,strong) NSMutableArray <TLCoinWithdrawModel *>*orders;
@property (nonatomic,assign) BOOL isFirst;

@property (nonatomic , strong)NSArray *dataArray;
@end

@implementation TLCoinWithdrawOrderVC





- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.isFirst) {
        self.isFirst = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.orderTableView beginRefreshing];
            
        });
        
        
    }
}

- (void)viewDidLayoutSubviews {
    
    self.orderTableView.frame = self.view.bounds;
    
}

-(void)ckey
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    
    if ([_titleString isEqualToString:[LangSwitcher switchLang:@"收款订单" key:nil]]) {
         http.parameters[@"parentKey"] = @"charge_status";
    }else
    {
         http.parameters[@"parentKey"] = @"withdraw_status";
    }
   
    
    [http postWithSuccess:^(id responseObject) {
        //        [self LoadData];
        self.dataArray = responseObject[@"data"];
        [self.orderTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.isFirst  = YES;
    self.titleText.text = self.titleString;
    self.navigationItem.titleView = self.titleText;
    TLTableView *tableView = [TLTableView tableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                    delegate:self dataSource:self];
    [self.view addSubview:tableView];
    self.orderTableView = tableView;
    self.orderTableView.allowsSelection = NO;
    self.orderTableView.defaultNoDataImage = kImage(@"暂无订单");
    
    self.orderTableView.defaultNoDataText = [LangSwitcher switchLang:@"暂无明细" key:nil];

    
//    [self ckey];
    
    //
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    if ([_titleString isEqualToString:[LangSwitcher switchLang:@"收款订单" key:nil]]) {
        helper.code = @"802345";
        
    }else
    {
        helper.code = @"802355";
//        helper.parameters[@"applyUser"] = [TLUser user].userId;
    }
    
    helper.parameters[@"accountNumber"] = self.currency.accountNumber;
//
    helper.parameters[@"token"] = [TLUser user].token;
    
    helper.tableView = self.orderTableView;
    [helper modelClass:[TLCoinWithdrawModel class]];
    
    //
    __weak typeof(self) weakSelf = self;
    [self.orderTableView addRefreshAction:^{
        [weakSelf ckey];
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            
            weakSelf.orders = objs;
            [weakSelf.orderTableView reloadData_tl];
            
            
        } failure:^(NSError *error) {
            
            
        }];
        
    }];
    
    [self.orderTableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            
            weakSelf.orders = objs;
            [weakSelf.orderTableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            
        }];
        
    }];
    
//    [self.orderTableView endRefreshingWithNoMoreData_tl];
    
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    [];
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

#pragma mark- dasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orders.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    static NSString *cellId = @"TLCoinWithdrawOrderCell";
    TLCoinWithdrawOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {

        cell = [[TLCoinWithdrawOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

    }
    cell.backgroundColor = kWhiteColor;
    cell.titleString = self.titleString;
    if (self.dataArray.count > 0) {
        cell.dataArray = self.dataArray;
    }
    cell.withdrawModel = self.orders[indexPath.row];
    
    return cell;
}

@end

