//
//  PosMiningVC.m
//  Coin
//
//  Created by 蔡卓越 on 2018/3/29.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "PosMiningVC.h"
//V
#import "TLPlaceholderView.h"
#import "UIBarButtonItem+convience.h"
#import "TLMakeMoney.h"
#import "QuestionModel.h"
#import "TLtakeMoneyModel.h"
#import "TLMoneyDeailVC.h"
#import "CurrencyModel.h"
#import "PosMyInvestmentDetailsVC.h"
#import "MoneyAndTreasureHeadView.h"
@interface PosMiningVC ()<RefreshDelegate>
{
    UIButton *selectBtn;
    UIView *lineView;
}

//
@property (nonatomic, strong) TLPlaceholderView *placeholderView;

@property (nonatomic , strong)UIButton *RightButton;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*currencys;

@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic,strong) NSArray <TLtakeMoneyModel *>*Moneys;

@property (nonatomic, strong) TLMakeMoney *tableView;

@property (nonatomic, strong) MoneyAndTreasureHeadView *headView;

@property (nonatomic , strong)NSDictionary *dataDic;

@end

@implementation PosMiningVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

    [self getMyCurrencyList:@"BTC"];
//    [self totalAmount:@"BTC"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"LOADDATA" object:nil];
    [self navigativeView];

    MoneyAndTreasureHeadView *headView = [[MoneyAndTreasureHeadView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, 240 - 64 + kNavigationBarHeight)];
    self.headView = headView;
    [self.view addSubview:headView];
    
    NSArray *btnArray = @[@"BTC",@"USDT"];
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:16];
        btn.frame = CGRectMake(i % 2 * SCREEN_WIDTH/2, 240 - 64, SCREEN_WIDTH/2, 45);
        [btn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
        if (i == 0) {
            btn.selected = YES;
            selectBtn = btn;
        }
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:btn];
    }
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2/2 - 27.5, 240 - 64 + 45 - 3, 55, 3)];
    lineView.backgroundColor = kTabbarColor;
    kViewRadius(lineView, 1.5);
    [self.view addSubview:lineView];
}

-(void)BtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    selectBtn = sender;
    
    [UIView animateWithDuration:0.3 animations:^{
        lineView.frame = CGRectMake(SCREEN_WIDTH/2/2 - 27.5 + (sender.tag - 100)*SCREEN_WIDTH/2 , 240 - 64 + 45 - 3, 55, 3);
    }];
    
    if (selectBtn.tag == 100) {
        
        [self getMyCurrencyList:@"BTC"];
//        [self totalAmount:@"BTC"];
    }else
    {
        [self getMyCurrencyList:@"USDT"];
//        [self totalAmount:@"USDT"];
    }
}

-(void)navigativeView
{
    self.titleText.text = [LangSwitcher switchLang:@"币加宝" key:nil];
    self.titleText.font = Font(18);
    self.titleText.textColor = kWhiteColor;
    self.navigationItem.titleView = self.titleText;

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:[LangSwitcher switchLang:@"我的投资" key:nil] forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)myRecodeClick
{
    PosMyInvestmentDetailsVC *VC = [PosMyInvestmentDetailsVC new];
    VC.dataDic = self.dataDic;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];

}

#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    
    
    if (selectBtn.tag == 100) {
        [self getMyCurrencyList:@"BTC"];
//        [self totalAmount:@"BTC"];
    }else
    {
        [self getMyCurrencyList:@"USDT"];
//        [self totalAmount:@"USDT"];
    }
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LOADDATA" object:nil];
}

//总收益
-(void)totalAmount:(NSString *)symbol{
    
    self.headView.symbol = symbol;
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"625529";
    http.showView = self.view;
    http.parameters[@"symbol"] = symbol;
    http.parameters[@"userId"]  = [TLUser user].userId;
    
    [http postWithSuccess:^(id responseObject) {

        self.dataDic = responseObject[@"data"];
        self.headView.dataDic = responseObject[@"data"];
        [self.tableView reloadData];

    } failure:^(NSError *error) {

    }];
    
    
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"625527";
    http1.showView = self.view;
    http1.parameters[@"userId"]  = [TLUser user].userId;
    
    [http1 postWithSuccess:^(id responseObject) {
        
        self.headView.dataDic1 = responseObject[@"data"];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}

- (void)getMyCurrencyList:(NSString *)symbol {

    CoinWeakSelf;

    
    [CoinUtil refreshOpenCoinList:^{
        
        TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
        
        helper.code = @"625510";
        helper.parameters[@"userId"] = [TLUser user].userId;
        helper.parameters[@"status"] = @"appDisplay";
        helper.parameters[@"symbol"] = symbol;
        helper.isCurrency = YES;
        helper.tableView = self.tableView;
        [helper modelClass:[TLtakeMoneyModel class]];
        
        
        
        [self.tableView addRefreshAction:^{
            //        [weakSelf totalAmount];
            if (selectBtn.tag == 100) {
                
                [weakSelf totalAmount:@"BTC"];
            }else
            {
                
                [weakSelf totalAmount:@"USDT"];
            }
            //        [self totalAmount:@"BTC"];
            [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
                //去除没有的币种
                weakSelf.Moneys = objs;
                weakSelf.tableView.Moneys = objs;
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
                
                
                weakSelf.Moneys = objs;
                weakSelf.tableView.Moneys = objs;
                //        weakSelf.tableView.bills = objs;
                [weakSelf.tableView reloadData_tl];
                
            } failure:^(NSError *error) {
                
                [weakSelf addPlaceholderView];
                
            }];
        }];
        
        [self.tableView endRefreshingWithNoMoreData_tl];
        
        
    } failure:^{
        
    }];
    
    
    

}

//-(void)getMyCurrencyList
//{
//    CoinWeakSelf;
//    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    helper.code = @"625510";
//    helper.parameters[@"userId"] = [TLUser user].userId;
//    helper.parameters[@"status"] = @"appDisplay";
//
//
//    helper.isCurrency = YES;
//    helper.tableView = self.tableView;
//    [helper modelClass:[TLtakeMoneyModel class]];
//
//    [self.tableView addRefreshAction:^{
//        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//            NSMutableArray <TLtakeMoneyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                TLtakeMoneyModel *model = (TLtakeMoneyModel *)obj;
//                [shouldDisplayCoins addObject:model];
//            }];
////            weakSelf.model = shouldDisplayCoins;
////            weakSelf.tableView.model = shouldDisplayCoins;
////            [weakSelf.tableView reloadData_tl];
//
//            weakSelf.Moneys = shouldDisplayCoins;
//            [weakSelf.tableView.Moneys removeAllObjects];
//            [weakSelf.tableView reloadData];
//            weakSelf.tableView.Moneys = shouldDisplayCoins;
//            //        weakSelf.tableView.bills = objs;
//            [weakSelf.tableView reloadData_tl];
//        } failure:^(NSError *error) {
//
//        }];
//    }];
//    [self.tableView addLoadMoreAction:^{
//
//        helper.parameters[@"userId"] = [TLUser user].userId;
//        helper.parameters[@"status"] = @"appDisplay";
//        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
//            NSLog(@" ==== %@",objs);
//            NSMutableArray <TLtakeMoneyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                TLtakeMoneyModel *model = (TLtakeMoneyModel *)obj;
//                [shouldDisplayCoins addObject:model];
//            }];
//            weakSelf.Moneys = shouldDisplayCoins;
//
//            weakSelf.tableView.Moneys = shouldDisplayCoins;
//            //        weakSelf.tableView.bills = objs;
//            [weakSelf.tableView reloadData_tl];
//
//        } failure:^(NSError *error) {
//        }];
//    }];
//    [self.tableView beginRefreshing];
//}








- (TLMakeMoney *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[TLMakeMoney alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight + 240 - 64 + kNavigationBarHeight + 45, SCREEN_WIDTH, SCREEN_HEIGHT - (240 - 64 + kNavigationBarHeight - 45) - kTabBarHeight - kNavigationBarHeight) style:UITableViewStylePlain];

        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
//        [self.view addSubview:_tableView];
    }
    return _tableView;
}




-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLMoneyDeailVC *money = [TLMoneyDeailVC new];
        money.moneyModel = self.Moneys[indexPath.row];
        money.currencys = self.currencys;
        money.hidesBottomBarWhenPushed = YES;
//        money.title = [LangSwitcher switchLang:@"理财产品详情" key:nil];
        [self.navigationController pushViewController:money animated:YES];
    }
    
}

@end
