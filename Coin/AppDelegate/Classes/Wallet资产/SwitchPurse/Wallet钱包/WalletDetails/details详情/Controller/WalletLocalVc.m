
//  WalletLocalVc.m
//  Coin
//
//  Created by shaojianfei on 2018/6/11.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WalletLocalVc.h"
#import "RechargeCoinVC.h"
#import "ZMAuthVC.h"
#import "WallAccountHeadView.h"
#import "WithdrawalsCoinVC.h"
#import "Masonry.h"
#import "TLUser.h"
#import "BillModel.h"
#import "NSString+Check.h"
#import "FilterView.h"
#import "UIBarButtonItem+convience.h"
#import "WalletLocalBillTableView.h"
#import "LocalBillDetailVC.h"
#import "TLBillBTCVC.h"
#import "USDTRecordModel.h"
#import "WalletForwordVC.h"
@interface WalletLocalVc ()<RefreshDelegate>
{
    NSInteger start;
}
@property (nonatomic, strong) WalletLocalBillTableView *tableView;
@property (nonatomic,assign) NSInteger start;
@property (nonatomic,strong) NSMutableArray <BillModel *>*bills;
@property (nonatomic,strong) NSMutableArray <USDTRecordModel *>*ustds;
@property (nonatomic,strong) NSMutableArray *trxArray;
@property (nonatomic, strong) TLPageDataHelper *helper;
//筛选
@property (nonatomic, strong) FilterView *filterPicker;
//暂无推荐历史
@property (nonatomic, strong) UIView *placeHolderView;

@property (nonatomic , strong) WallAccountHeadView *headView;

@property (nonatomic , strong) UIView *bottomViw;
//充币
@property (nonatomic, strong) UIButton *rechargeBtn;
//提币
@property (nonatomic, strong) UIButton *withdrawalsBtn;
//账单
@property (nonatomic, strong) UIButton *billBtn;
@property (nonatomic , strong) UIScrollView *contentScrollView;
@end

@implementation WalletLocalVc
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self navigationTransparentClearColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationwhiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initHeadView];
    [self initTableView];
    [self initBottonView];
    [self addPlaceholderView];

    //获取账单
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang: [NSString stringWithFormat:@"%@",self.currency.symbol] key:nil];
    self.navigationItem.titleView = self.titleText;
    if ([self.currency.symbol isEqualToString:@"BTC"]) {
        [self requestBtcList];

    }
    else if ([self.currency.symbol isEqualToString:@"USDT"])
    {
        [self requestUSDTList];
    }
    else if([self.currency.symbol isEqualToString:@"TRX"])
    {
        [self requestTRXList];
    }else
    {
        [self requestLXTList];
    }
    self.titleText.text = self.currency.symbol;

    self.navigationItem.titleView = self.titleText;
}

-(void)requestTRXList
{
    
    
    CoinWeakSelf;
    [self.tableView addRefreshAction:^{
        weakSelf.trxArray = [NSMutableArray array];
        weakSelf.start = 0;
        [weakSelf loadData];
    }];
    
    [self.tableView beginRefreshing];
    
    [self.tableView addLoadMoreAction:^{
        
        weakSelf.start ++;
        [weakSelf loadData];
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
    
}

-(void)loadData
{
    
    NSDictionary *dic = @{@"address":self.currency.address,
                          @"start":@(_start),
                          @"limit":@"10"
                          };
    [TLNetworking GET:@"https://apilist.tronscan.org/api/transaction" parameters:dic success:^(NSString *msg, id data) {
        
        
        [self.trxArray addObjectsFromArray:data[@"data"]];
        
        self.tableView.billModel = self.currency;
        self.tableView.trxs = [BillModel mj_objectArrayWithKeyValuesArray:self.trxArray];
        [self.tableView reloadData];
        self.bills = [BillModel mj_objectArrayWithKeyValuesArray:self.trxArray];
        [self.tableView endRefreshHeader];
        [self.tableView endRefreshFooter];
    } abnormality:^{
        [self.tableView endRefreshHeader];
        [self.tableView endRefreshFooter];
    } failure:^(NSError *error) {
        [self.tableView endRefreshHeader];
        [self.tableView endRefreshFooter];
        [TLAlert alertWithInfo:@"当前网络不给力，请稍后再试或切换网络"];
    }];
    
}

-(void)requestUSDTList
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    self.helper = helper;
    helper.code = @"802221";
    helper.start = 0;
    helper.limit = 10;
    helper.parameters[@"symbol"] = self.currency.symbol;
//    helper.parameters[@"address"] = @"1x6YnuBVeeE65dQRZztRWgUPwyBjHCA5g";
    helper.parameters[@"address"] = self.currency.address;
    [helper modelClass:[USDTRecordModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count == 0) {
                [weakSelf addPlaceholderView];
                
            }
            
            weakSelf.ustds = objs;
            
            weakSelf.tableView.billModel = weakSelf.currency;
            
            weakSelf.tableView.ustds = objs;
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
            weakSelf.tableView.billModel = weakSelf.currency;
            weakSelf.tableView.ustds = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
    
}

- (void)requestLXTList
{
    __weak typeof(self) weakSelf = self;


    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];

    helper.tableView = self.tableView;
    self.helper = helper;

    helper.code = @"802308";
    helper.start = 0;
    helper.limit = 10;
    helper.parameters[@"symbol"] = self.currency.symbol;
    helper.parameters[@"address"] = self.currency.address;
    CoinModel *coin = [CoinUtil getCoinModel:self.currency.symbol];

    helper.parameters[@"contractAddress"] = coin.contractAddress;
    //0 刚生成待回调，1 已回调待对账，2 对账通过, 3 对账不通过待调账,4 已调账,9,无需对账
    //pageDataHelper.parameters[@"status"] = [ZHUser user].token;

    [helper modelClass:[BillModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //            if (weakSelf.tl_placeholderView.superview != nil) {
            //
            //                [weakSelf removePlaceholderView];
            //            }
            if (objs.count == 0) {
                [weakSelf addPlaceholderView];

            }

            weakSelf.bills = objs;

            weakSelf.tableView.billModel = weakSelf.currency;

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
            weakSelf.tableView.billModel = weakSelf.currency;
            weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {

            [weakSelf addPlaceholderView];

        }];

    }];

    [self.tableView endRefreshingWithNoMoreData_tl];

}

- (void)requestBtcList
{
    //--//
    __weak typeof(self) weakSelf = self;
//
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.tableView = self.tableView;
    self.helper = helper;
    
    helper.code = @"802224";
    helper.start = 0;
    helper.limit = 10;
    helper.parameters[@"address"] = self.currency.address;
    
//    helper.parameters[@"symbol"] = self.currency.symbol;
    [helper modelClass:[BillModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count == 0) {
                [weakSelf addPlaceholderView];
            }
           
            weakSelf.bills = objs;
            
            weakSelf.tableView.billModel = weakSelf.currency;
            
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
            weakSelf.tableView.billModel = weakSelf.currency;
            weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
    
    
}



- (void)initTableView {
    
    self.tableView = [[WalletLocalBillTableView alloc]
                      initWithFrame:CGRectMake(0, self.headView.yy , kScreenWidth, SCREEN_HEIGHT - self.headView.yy - kNavigationBarHeight - 80)
                      style:UITableViewStyleGrouped];
    
    self.tableView.placeHolderView = self.placeHolderView;

    self.tableView.refreshDelegate = self;
    self.tableView.billModel = self.currency;
    self.tableView.defaultNoDataImage = kImage(@"暂无订单");
    self.tableView.defaultNoDataText = [LangSwitcher switchLang:@"暂无明细" key:nil];
//    self.tableView.sectionHeaderHeight = 22;
    [self.view addSubview:self.tableView];
    
}

//- (void)addFilterItem

#pragma mark - Events
//- (void)clickFilter:(UIButton *)sender {
//
//    [self.filterPicker show];
//
//}

#pragma mark - Data
- (void)requestBillList {
    
    //--//
    __weak typeof(self) weakSelf = self;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.tableView = self.tableView;
    self.helper = helper;
    
    helper.code = @"802271";
    helper.start = 1;
    helper.limit = 10;
    helper.parameters[@"symbol"] = self.currency.symbol;
    helper.parameters[@"address"] = self.currency.address;
    [helper modelClass:[BillModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
//            if (weakSelf.tl_placeholderView.superview != nil) {
//                
//                [weakSelf removePlaceholderView];
//            }
            if (objs.count == 0) {
                [weakSelf addPlaceholderView];

            }
            weakSelf.bills = objs;
            weakSelf.tableView.billModel = weakSelf.currency;

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
            weakSelf.tableView.billModel = weakSelf.currency;
            weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
}

- (void)initHeadView
{
    WallAccountHeadView *headView = [[WallAccountHeadView alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight, kScreenWidth, 84 - 64 + kNavigationBarHeight - 10 + 110)];
    self.headView = headView;
    [self.view addSubview:headView];
    self.headView.ISLocal = YES;
    if (self.currency) {
        headView.currency  = self.currency;
    }
    
}

- (void)initBottonView
{
    UIView *bottomView  = [[UIView alloc] init];
    self.bottomViw = bottomView;
    //    bottomView.backgroundColor = [UIColor redColor];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 80 - kNavigationBarHeight, SCREEN_WIDTH, 80);
    [self.view addSubview:bottomView];
    
    [bottomView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    //底部操作按钮
    
    NSArray *textArr = @[
                         [LangSwitcher switchLang:@"收款" key:nil],
                         [LangSwitcher switchLang:@"转账" key:nil]
                         ];
    NSArray *imgArr = @[@"转入", @"转出"];
    
    
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithTitle:textArr[i] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12.0];
        [btn addTarget:self action:@selector(btnClickCurreny:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 45)/2 + 15) , 15, SCREEN_WIDTH/2 - 45/2, 50);
        [btn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(imgArr[i]) forState:UIControlStateNormal];
        }];
        kViewRadius(btn, 4);
        if (i == 0) {
            [btn setBackgroundColor:kHexColor(@"#77A4FF") forState:(UIControlStateNormal)];
            
        }else
        {
            [btn setBackgroundColor:kHexColor(@"#F4AC71") forState:(UIControlStateNormal)];
        }
        
        btn.tag = 201806+i;
        [bottomView addSubview:btn];
    }
}

- (void)btnClickCurreny: (UIButton *)btn
{
    NSInteger tag = btn.tag-201806;
    RechargeCoinVC *coinVC = [RechargeCoinVC new];
    
    switch (tag) {
        case 0:
            coinVC.currency = self.currency;
            [self.navigationController pushViewController:coinVC animated:YES];
            break;
        case 1:
            [self clickWithdrawWithCurrency:self.currency];

            break;
            
        default:
            break;
    }
    
}

- (void)clickWithdrawWithCurrency:(CurrencyModel *)currencyModel {

    WalletForwordVC *coinVC = [WalletForwordVC new];
    coinVC.currency = currencyModel;
    [self.navigationController pushViewController:coinVC animated:YES];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if ([self.currency.symbol isEqualToString:@"BTC"]) {
        TLBillBTCVC *vc = [TLBillBTCVC  new];
        vc.bill = self.bills[indexPath.row];
        vc.currentModel = self.currency;
        vc.address = self.currency.address;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        LocalBillDetailVC *detailVc  =  [LocalBillDetailVC new];
        if ([self.currency.symbol isEqualToString:@"USDT"]) {
            detailVc.usdtModel = self.ustds[indexPath.row];
        }else
        {
            detailVc.bill = self.bills[indexPath.row];
        }
        detailVc.currentModel = self.currency;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}


@end
