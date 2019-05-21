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
#import "SwitchPurseVC.h"
#import "TWWalletAccountClient.h"
#import "WalletSettingVC.h"
@interface TLWalletVC ()<RefreshDelegate>
@property (nonatomic , strong)NSArray *addressArray;
@property(nonatomic , strong) TWWalletAccountClient *client;
@property (nonatomic, strong) NSMutableArray *arr;

//@property (nonatomic, strong) AssetsHeadView *headerView;

@property (nonatomic , strong)MyAssetsHeadView *headView;
@property (nonatomic, strong) PlatformTableView *tableView;
@property (nonatomic, strong) CustomFMDBModel *fmdbModel;
@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*AssetsListModel;

//@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*currencys;
//
//@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*localCurrencys;
//
//@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*allCurrencys;
//
//@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*tempcurrencys;

@property (nonatomic, strong) NSMutableArray <RateModel *>*rates;

@property (nonatomic, strong) TLNetworking *helper;

@property (nonatomic,strong) NSMutableArray <BillModel *>*bills;

//@property (nonatomic, strong) UILabel *nameLable;

//@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic,strong) NSMutableArray <CoinModel *>*coins;

@property (nonatomic,strong) NSMutableArray <CountryModel *>*countrys;

@property (nonatomic, strong) TLNetworking *http;

//清除公告 更新UI
//@property (nonatomic, assign) BOOL isClear;
//
//@property (nonatomic, copy) NSString *IsLocalExsit;

@property (nonatomic, strong) UIView *titleView;

//@property (nonatomic, strong) UIButton *addButton;

//@property (nonatomic, strong) UIView *contentView;
//
//@property (nonatomic, assign) BOOL isBulid;
//
//@property (nonatomic, assign) BOOL isAddBack;

@end

@implementation TLWalletVC

-(void)viewDidAppear:(BOOL)animated
{
//    [self queryCenterTotalAmount];
}

- (void)viewWillAppear:(BOOL)animated {
  
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(MyAssetsHeadView *)headView
{
    if (!_headView) {
        _headView = [[MyAssetsHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        [_headView.SwitchPurse addTarget:self action:@selector(SwitchPurseClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_headView.backBtn addTarget:self action:@selector(backClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headView;
}



-(void)SwitchPurseClick
{
    SwitchPurseVC *vc = [SwitchPurseVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

//钱包工具
-(void)backClick
{
    if ([[USERDEFAULTS objectForKey:@"mnemonics"] isEqualToString:@""]) {
        
    }else
    {
        WalletSettingVC *vc =[WalletSettingVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    //登录退出通知
    [self addNotification];
    //列表查询个人账户币种列表
    [self getMyCurrencyList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"SwitchThePurse" object:nil];
    
}


- (void)InfoNotificationAction:(NSNotification *)notification
{
    [self getMyCurrencyList];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SwitchThePurse" object:nil];
}

- (void)initTableView {
    self.tableView = [[PlatformTableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([TLUser isBlankString:self.AssetsListModel[indexPath.row].symbol] == YES) {
        WallAccountVC *accountVC= [[WallAccountVC alloc] init];
        accountVC.currency = self.AssetsListModel[indexPath.row];
        accountVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:accountVC animated:YES];
    }else
    {
        WalletLocalVc *accountVC= [[WalletLocalVc alloc] init];
        accountVC.currency = self.AssetsListModel[indexPath.row];
        accountVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    
    
    
   
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
            if ([[USERDEFAULTS objectForKey:@"mnemonics"] isEqualToString:@""]) {
                [weakSelf queryCenterTotalAmount];
            }else
            {
                [weakSelf saveLocalWalletData];
            }
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


- (void)saveLocalWalletData{
    //    兼容2.0以下私钥数据库
    ////        ETH("0", "以太币"), BTC("1", "比特币"), WAN("2", "万维"), USDT("3", "泰达币")
    // 基于某条公链的token币
    //        , ETH_TOKEN("0T", "以太token币"), WAN_TOKEN("2T", "万维token币");
    //        if ([model.type isEqualToString:@"0"]) {
    //            if ([model.symbol isEqualToString:@"BTC"] || [model.symbol isEqualToString:@"USDT"]) {
    //                address = [MnemonicUtil getBtcAddress:mnemonic1];
    //            }
    //            if ([model.symbol isEqualToString:@"ETH"]) {
    //                address = [MnemonicUtil getAddressWithPrivateKey:prikey];
    //            }
    //            if ([model.symbol isEqualToString:@"WAN"]) {
    //                address = [MnemonicUtil getAddressWithPrivateKey:prikey];
    //            }
    //        }
    NSMutableArray <CoinModel *>*arr = [[CoinModel coin] getOpenCoinList];
    NSMutableArray *muArray = [NSMutableArray array];
    
    NSArray *array = [CustomFMDB FMDBqueryMnemonics];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"mnemonics"] isEqualToString:[USERDEFAULTS objectForKey:@"mnemonics"]]) {
            _fmdbModel = [CustomFMDBModel mj_objectWithKeyValues:array[i]];
        }
    }
    for (int i = 0; i < arr.count; i++) {
        if ([arr[i].symbol isEqualToString:@"ET"]) {
            
        }else
        {
            CoinModel *model = arr[i];
            NSArray *array = [_fmdbModel.mnemonics componentsSeparatedByString:@" "];
            BTCMnemonic *mnemonic1 =  [MnemonicUtil importMnemonic:array];
            if ([AppConfig config].runEnv == 0)
            {
                mnemonic1.keychain.network = [BTCNetwork mainnet];
            }else{
                mnemonic1.keychain.network = [BTCNetwork testnet];
            }
            NSString *prikey = [MnemonicUtil getPrivateKeyWithMnemonics:_fmdbModel.mnemonics];
            
            NSString *address;
            
            
            if ([model.type isEqualToString:@"0"] || [model.type isEqualToString:@"0T"])
            {
                address = [MnemonicUtil getAddressWithPrivateKey:prikey];
            }
            else if ([model.type isEqualToString:@"1"] || [model.type isEqualToString:@"3"])
            {
                address = [MnemonicUtil getBtcAddress:mnemonic1];
            }else if ([model.type isEqualToString:@"2"] || [model.type isEqualToString:@"2T"])
            {
                address = [MnemonicUtil getAddressWithPrivateKey:prikey];
            }else if ([model.type isEqualToString:@"4"])
            {
                TWWalletType type = TWWalletCold;
                NSDictionary *dic = [CustomFMDB FMDBqueryUseridMnemonicsPwdWalletName];
                NSString *prikey   =[MnemonicUtil getPrivateKeyWithMnemonics:dic[@"mnemonics"]];
                
                TWWalletAccountClient *client = [[TWWalletAccountClient alloc]initWithPriKeyStr:prikey type:type];
                [client store:dic[@"pwd"]];
                address = [client base58OwnerAddress];
            }
            [arr[i] setValue:address forKey:@"address"];
            NSDictionary *coinDic = @{@"symbol":model.symbol,
                                      @"address":address,
                                      };
            [muArray addObject:coinDic];
        }
        
    }
    self.addressArray = muArray;
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"802270";
    http.isLocal = YES;
    http.isUploadToken = NO;
    http.parameters[@"accountList"] = muArray;
    CoinWeakSelf;
    [http postWithSuccess:^(id responseObject) {
        self.headView.dataDic = responseObject[@"data"];
        self.tableView.platforms = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
        
        
        self.AssetsListModel = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
        [self.tableView reloadData];
        [self.tableView endRefreshHeader];
        
    } failure:^(NSError *error) {
        [weakSelf.tableView endRefreshHeader];
        
    }];
}

#pragma mark -- 个人钱包列表网络请求
//- (void)getMyCurrencyList {
//
//    CoinWeakSelf;
//    [self.tableView addRefreshAction:^{
//
//        [CoinUtil refreshOpenCoinList:^{
//
//            [weakSelf saveLocalWalletData];
//
//        } failure:^{
//            [weakSelf.tableView endRefreshHeader];
//        }];
//    }];
//    [self.tableView beginRefreshing];
//}


@end
