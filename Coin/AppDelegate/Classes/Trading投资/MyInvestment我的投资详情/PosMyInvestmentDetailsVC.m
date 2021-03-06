//
//  PosMyInvestmentDetailsVC.m
//  Coin
//
//  Created by QinBao Zheng on 2018/9/26.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "PosMyInvestmentDetailsVC.h"
#import "PosMyInvestmentDetailsTableView.h"
#import "PosMyInvestmentModel.h"
#import "PosMyInvestmentHeadView.h"
#import "AccumulatedEarningsVC.h"
#import "FinancialDetailsVC.h"
@interface PosMyInvestmentDetailsVC ()<RefreshDelegate,PosMyInvestmentDelegate>
{
    PosMyInvestmentHeadView *headView;
}

@property (nonatomic , strong)PosMyInvestmentDetailsTableView *tableView;

@property (nonatomic , strong)NSMutableArray <PosMyInvestmentModel *>*model;

@end

@implementation PosMyInvestmentDetailsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self navigationSetDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;


}
//
//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self navigationwhiteColor];
//    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.titleText.text = [LangSwitcher switchLang:@"我的投资详情" key:nil];
    self.titleText.textColor = kWhiteColor;
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    [self LoadData:@[@"0",@"1",@"2"]];
    
}

- (void)initTableView {
    self.tableView = [[PosMyInvestmentDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;


    headView = [[PosMyInvestmentHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
    headView.backgroundColor = kTabbarColor;
    headView.dataDic = self.dataDic;
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    [self.view addSubview:self.tableView];

    

}

-(void)PosMyInvestmentButton:(NSInteger)tag
{
    if (tag == 0) {
        AccumulatedEarningsVC *vc = [AccumulatedEarningsVC new];
        vc.symbol = @"BTC";
        [self.navigationController pushViewController:vc animated:YES];
        
    }else
    {
        AccumulatedEarningsVC *vc = [AccumulatedEarningsVC new];
        vc.symbol = @"USDT";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)totalAmount
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"625527";
    http.showView = self.view;
    http.parameters[@"userId"]  = [TLUser user].userId;

    [http postWithSuccess:^(id responseObject) {

        headView.dataDic = responseObject[@"data"];
        [self.tableView reloadData];

    } failure:^(NSError *error) {

    }];
}

//- (void)click:(UITapGestureRecognizer *)gesture{
//
////    NSLog(@"====%d",gesture.view.tag);//label的tag
//    AccumulatedEarningsVC *vc = [AccumulatedEarningsVC new];
//
//    [self.navigationController pushViewController:vc animated:YES];
//}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancialDetailsVC *vc = [FinancialDetailsVC new];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index setArray:(NSArray *)array
{
//    [self.tableView endRefreshHeader];
    [TLProgressHUD show];
    [self LoadData:array];
}

//-(void)SelectLoadData:(NSArray *)array
//{
//    CoinWeakSelf;
//    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    helper.code = @"625525";
//    helper.showView = self.view;
//    helper.parameters[@"userId"] = [TLUser user].userId;
//    if (array.count > 0) {
//        helper.parameters[@"statusList"] = [array componentsJoinedByString:@","];
//    }
//    helper.isCurrency = YES;
//    helper.tableView = self.tableView;
//    [helper modelClass:[PosMyInvestmentModel class]];
//    [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//        NSMutableArray <PosMyInvestmentModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//        [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            PosMyInvestmentModel *model = (PosMyInvestmentModel *)obj;
//            [shouldDisplayCoins addObject:model];
//        }];
//        //            weakSelf.model = shouldDisplayCoins;
//        //            weakSelf.tableView.model = shouldDisplayCoins;
//        //            [weakSelf.tableView reloadData_tl];
//
//        weakSelf.model = shouldDisplayCoins;
////        [weakSelf.tableView.model removeAllObjects];
////        [weakSelf.tableView reloadData];
//        weakSelf.tableView.model = shouldDisplayCoins;
//        //        weakSelf.tableView.bills = objs;
//        [weakSelf.tableView reloadData_tl];
//        [TLProgressHUD dismiss];
//    } failure:^(NSError *error) {
//
//    }];
//    helper.parameters[@"userId"] = [TLUser user].userId;
//    if (array.count > 0) {
//        helper.parameters[@"status"] = [array componentsJoinedByString:@","];
//    }
//    [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
//        NSLog(@" ==== %@",objs);
//        NSMutableArray <PosMyInvestmentModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//        [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            PosMyInvestmentModel *model = (PosMyInvestmentModel *)obj;
//            [shouldDisplayCoins addObject:model];
//        }];
//        weakSelf.model = shouldDisplayCoins;
//
//        weakSelf.tableView.model = shouldDisplayCoins;
//        //        weakSelf.tableView.bills = objs;
//        [weakSelf.tableView reloadData_tl];
//
//    } failure:^(NSError *error) {
//    }];
//}

-(void)LoadData:(NSArray *)array
{
    CoinWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"625526";
    helper.parameters[@"userId"] = [TLUser user].userId;
    if (array.count > 0) {
        helper.parameters[@"statusList"] = array;
    }
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[PosMyInvestmentModel class]];

    [self.tableView addRefreshAction:^{
        
        [weakSelf totalAmount];
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <PosMyInvestmentModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                PosMyInvestmentModel *model = (PosMyInvestmentModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];

            weakSelf.model = shouldDisplayCoins;
            [weakSelf.tableView.model removeAllObjects];
            [weakSelf.tableView reloadData];
            weakSelf.tableView.model = shouldDisplayCoins;
            //        weakSelf.tableView.bills = objs;
            [TLProgressHUD dismiss];
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {

        }];
    }];
    [self.tableView addLoadMoreAction:^{

        helper.parameters[@"userId"] = [TLUser user].userId;
        if (array.count > 0) {
            helper.parameters[@"statusList"] = [array componentsJoinedByString:@","];
        }
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <PosMyInvestmentModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                PosMyInvestmentModel *model = (PosMyInvestmentModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.model = shouldDisplayCoins;

            weakSelf.tableView.model = shouldDisplayCoins;
            //        weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}

@end
