#import "TLWalletVC.h"
#import "CurrencyModel.h"
#import "FMDBMigrationManager.h"
#import "RechargeCoinVC.h"
#import "WithdrawalsCoinVC.h"
#import "BillVC.h"
#import "RateDescVC.h"
#import "ZMAuthVC.h"
#import <CDCommon/UIScrollView+TLAdd.h>
#import "PlatformTableView.h"
#import "WallAccountVC.h"
#import "AddAccoutMoneyVc.h"
#import "WalletLocalVc.h"
#import "RateModel.h"
#import "WallAccountVC.h"
#import "QRCodeVC.h"
#import "BuildWalletMineVC.h"
#import "CountryModel.h"
#import "WalletImportVC.h"
#import "HTMLStrVC.h"
#import "BuildSucessVC.h"
#import "BuildWalletMineVC.h"
#import "BTCMnemonic.h"
#import "BTCNetwork.h"
#import "BTCData.h"
#import "MnemonicUtil.h"
#import "BTCKeychain.h"
#import "BillModel.h"
#import "AssetsHeadView.h"
#import "MyAssetsHeadView.h"

@interface TLWalletVC ()<RefreshDelegate>

@property (nonatomic, strong) NSMutableArray *arr;

//@property (nonatomic, strong) AssetsHeadView *headerView;

@property (nonatomic , strong)MyAssetsHeadView *headView;
@property (nonatomic, strong) PlatformTableView *tableView;

@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*AssetsListModel;

@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*currencys;

@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*localCurrencys;

@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*allCurrencys;

@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*tempcurrencys;

@property (nonatomic, strong) NSMutableArray <RateModel *>*rates;

@property (nonatomic, strong) TLNetworking *helper;

@property (nonatomic,strong) NSMutableArray <BillModel *>*bills;

@property (nonatomic, strong) UILabel *nameLable;

//@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic,strong) NSMutableArray <CoinModel *>*coins;

@property (nonatomic,strong) NSMutableArray <CountryModel *>*countrys;

@property (nonatomic, strong) TLNetworking *http;

//清除公告 更新UI
@property (nonatomic, assign) BOOL isClear;

@property (nonatomic, copy) NSString *IsLocalExsit;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) BOOL isBulid;

@property (nonatomic, assign) BOOL isAddBack;

@end

@implementation TLWalletVC

-(void)viewDidAppear:(BOOL)animated
{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self queryCenterTotalAmount];
}

- (void)viewWillAppear:(BOOL)animated {
  
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(MyAssetsHeadView *)headView
{
    if (!_headView) {
        _headView = [[MyAssetsHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    }
    return _headView;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initTableView];
    //登录退出通知
    [self addNotification];
    //列表查询个人账户币种列表
    [self getMyCurrencyList];
}

- (void)initTableView {
    self.tableView = [[PlatformTableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.headView];
    self.tableView.tableHeaderView = self.headView;
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    WallAccountVC *accountVC= [[WallAccountVC alloc] init];
    accountVC.currency = self.AssetsListModel[index - 100];
    accountVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:accountVC animated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview setCurrencyModel:(CurrencyModel *)model setTitle:(NSString *)title
{
    if ([title isEqualToString:@"转出"]) {
        [self clickWithdrawWithCurrency:model];
    }
    else if ([title isEqualToString:@"转入"])
    {
        RechargeCoinVC *coinVC = [RechargeCoinVC new];
        coinVC.currency = model;
        coinVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:coinVC animated:YES];
    }else
    {
        WallAccountVC *accountVC= [[WallAccountVC alloc] init];
        accountVC.currency = model;
        accountVC.hidesBottomBarWhenPushed = YES;
        accountVC.title = model.currency;
        accountVC.billType = CurrentTypeAll;
        [self.navigationController pushViewController:accountVC animated:YES];
    }
}

- (void)clickWithdrawWithCurrency:(CurrencyModel *)currencyModel
{
    CoinWeakSelf;
    //    实名认证成功后，判断是否设置资金密码
    if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {
        TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
        vc.titleString = @"设置交易密码";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        return;
    }
    WithdrawalsCoinVC *coinVC = [WithdrawalsCoinVC new];
    coinVC.currency = currencyModel;
    coinVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:coinVC animated:YES];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userlogin) name:kUserLoginNotification object:nil];
}

#pragma mark -- 个人钱包列表网络请求
- (void)getMyCurrencyList {
    CoinWeakSelf;
    [self.tableView addRefreshAction:^{
        [CoinUtil refreshOpenCoinList:^{
            [weakSelf queryCenterTotalAmount];
        } failure:^{
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView beginRefreshing];
}

#pragma mark - Events
- (void)userlogin
{
    [self getMyCurrencyList];
}

//   个人钱包余额查询
- (void)queryCenterTotalAmount
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"802301";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        self.headView.dataDic = responseObject[@"data"];
        self.tableView.platforms = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
        [self.tableView reloadData];
        self.AssetsListModel = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
        [self.tableView endRefreshHeader];
    } failure:^(NSError *error) {
        [self.tableView endRefreshHeader];
    }];
}


@end
