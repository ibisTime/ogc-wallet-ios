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
#import "BillModel.h"
@interface EggplantAccountVC ()<RefreshDelegate>
{
    NSDictionary *dataDic;
}

@property (nonatomic , strong)EggplantAccountTableView *tableView;

@property (nonatomic , strong)EggplantAccountHeadView *headView;


@property (nonatomic , strong)NSMutableArray <BillModel *>*bills;
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
    vc.symbol = @"H";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"氢气账户";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    [self LoadData];
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"FlashAgain" object:nil];
}




#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self LoadData];
    
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FlashAgain" object:nil];
}

- (void)initTableView {
    self.tableView = [[EggplantAccountTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}

-(void)LoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"802304";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"currency"] = @"H";
    [http postWithSuccess:^(id responseObject) {
        
        self.headView.amount = responseObject[@"data"][0][@"amount"];
        dataDic = responseObject[@"data"][0];
        [self requestBillList];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Data
- (void)requestBillList {
    
    //--//
    __weak typeof(self) weakSelf = self;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.tableView = self.tableView;
    
    helper.code = @"802320";
    helper.start = 1;
    helper.limit = 10;
    helper.parameters[@"type"] = @"0";
    helper.parameters[@"accountNumber"] = dataDic[@"accountNumber"];
    
    
    [helper modelClass:[BillModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.bills = objs;
            
            weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
    }];
    
    [self.tableView beginRefreshing];
    
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.bills = objs;
            
            weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
}

@end
