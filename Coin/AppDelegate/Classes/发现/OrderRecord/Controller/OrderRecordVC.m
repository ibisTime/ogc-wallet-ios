//
//  OrderRecordVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "OrderRecordVC.h"
#import "OrderRecordTableView.h"
#import "PayTreasureVC.h"
#import "BnakCardVC.h"
#import "PayFailureVC.h"
#import "OrderRecordModel.h"
#import "SellDetalisVC.h"
@interface OrderRecordVC ()<RefreshDelegate>
{
    NSArray *dataArray;
}
@property (nonatomic , strong)OrderRecordTableView *tableView;

@property (nonatomic , strong)NSMutableArray <OrderRecordModel *>*models;

@end

@implementation OrderRecordVC

- (OrderRecordTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[OrderRecordTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight) style:UITableViewStylePlain];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = [LangSwitcher switchLang:@"订单记录" key:nil];
    self.titleText.font = FONT(18);
    self.navigationItem.titleView = self.titleText;
    [self ckey];
    [self LoadData];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InvestmentLoadData" object:nil];
}


- (void)InfoNotificationAction:(NSNotification *)notification
{
    [self LoadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InvestmentLoadData" object:nil];
}

-(void)LoadData
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    helper.code = @"625287";
    helper.parameters[@"userId"] = [TLUser user].userId;
    [helper modelClass:[OrderRecordModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.models = objs;
            
            weakSelf.tableView.models = objs;
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
            
            weakSelf.models = objs;
            
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
}

-(void)ckey
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    
    http.parameters[@"parentKey"] = @"accept_order_status";
    
    [http postWithSuccess:^(id responseObject) {
//        [self LoadData];
        self.tableView.dataArray = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderRecordModel *model = self.models[indexPath.row];
    if ([model.status isEqualToString:@"0"]) {
        if ([model.type isEqualToString:@"0"]) {
            if ([model.receiveType isEqualToString:@"1"]) {
                PayTreasureVC *vc = [PayTreasureVC new];
                vc.models = model;
                
                [self.navigationController pushViewController:vc animated:YES];
            }else
            {
                BnakCardVC *vc = [BnakCardVC new];
                vc.models = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else
        {
            SellDetalisVC *vc = [SellDetalisVC new];
            vc.models = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else
    {
        PayFailureVC *vc = [PayFailureVC new];
        vc.models = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
