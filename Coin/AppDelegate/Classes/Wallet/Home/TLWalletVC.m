//
//  TLWalletVC.m
//  Coin
//
//  Created by  tianlei on 2017/11/06.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLWalletVC.h"
//#import "WalletHeaderView.h"
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
#import "TLFastvc.h"
#import "TLTransfromVC.h"
//#import "BuildLocalHomeView.h"
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
#import "WalletForwordVC.h"
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
}

- (void)viewWillAppear:(BOOL)animated {
  
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(MyAssetsHeadView *)headView
{
    if (!_headView) {
        _headView = [[MyAssetsHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 87 - 64 + kNavigationBarHeight - 10 + 180)];
    }
    return _headView;
}

//-(void)PageDisplayLoading
//{
//
//    TLDataBase *dataBase = [TLDataBase sharedManager];
//    NSString *word;
//    NSString *btcadd;
//    NSString *pwd;
//    //   获取一键划转币种列表
//    if ([dataBase.dataBase open]) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT Mnemonics,btcaddress,PwdKey  from THAUser where userId = '%@'",[TLUser user].userId];
//        //        [sql appendString:[TLUser user].userId];
//        FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//        while ([set next])
//        {
//            word = [set stringForColumn:@"Mnemonics"];
//            btcadd = [set stringForColumn:@"btcaddress"];
//            pwd = [set stringForColumn:@"PwdKey"];
//
//        }
//        [set close];
//    }
//    [dataBase.dataBase close];
//    //    [self queryTotalAmount];
//    if (word != nil && word.length > 0) {
//        BOOL isBuild = [[NSUserDefaults standardUserDefaults] boolForKey:KISBuild];
//        //判断是否是创建或者导入钱包之后返回的
//        if (isBuild == YES) {
//            //            获取本地数据库私钥币种列表
//            [self saveLocalWalletData];
//            //            判断是否更新
//            [self saveLocalWallet];
//            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:KISBuild];
//        }
//        //        [self getMyCeurrencyList];
//        //1.7.0版本升级适配
////        if (btcadd != nil && btcadd.length > 0 && pwd !=nil) {
////            return;
////        }
//
//        NSArray *words = [word componentsSeparatedByString:@" "];
//        //这里第一次进行BTC的私钥和地址创建 存到用户表里面 和币种表
//        BTCMnemonic *mnemonic =  [MnemonicUtil importMnemonic:words];
//        if ([AppConfig config].runEnv == 0) {
//            mnemonic.keychain.network = [BTCNetwork mainnet];
//
//        }else{
//            mnemonic.keychain.network = [BTCNetwork testnet];
//        }
//        NSLog(@"Seed=%@", BTCHexFromData(mnemonic.seed));
//        NSLog(@"Mnemonic=%@", mnemonic.words);
//        NSLog(@"btc_privateKey=%@", [MnemonicUtil getBtcPrivateKey:mnemonic]);
//        NSString *btc_private = [MnemonicUtil getBtcPrivateKey:mnemonic];
//
//        NSString *btc_address = [MnemonicUtil getBtcAddress:mnemonic];
//        //助记词存在 新增btc地址
//        TLDataBase *data = [TLDataBase sharedManager];
//        if ([data.dataBase open]) {
//
//            NSString *sql = [NSString stringWithFormat:@"UPDATE THAUser SET btcaddress = '%@',btcprivate = '%@' WHERE userId='%@'",btc_address,btc_private,[TLUser user].userId];
//            NSString *sql1 = [NSString stringWithFormat:@"UPDATE THALocal SET address = '%@' WHERE walletId = (SELECT walletId from THAUser where userId='%@') and symbol = '%@' ",btc_address,[TLUser user].userId,@"BTC"];
//            BOOL sucess = [data.dataBase executeUpdate:sql];
//            BOOL sucess1 = [data.dataBase executeUpdate:sql1];
//
//            NSLog(@"更新自选状态%d",sucess);
//            NSLog(@"更新自选状态%d",sucess1);
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KIS170];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//        [data.dataBase close];
//
//        if (pwd==nil ) {
//            TLDataBase *data = [TLDataBase sharedManager];
//            if ([data.dataBase open]) {
//
//                NSString *sql = [NSString stringWithFormat:@"UPDATE THAUser SET PwdKey = '%@' WHERE userId='%@'",@"888888",[TLUser user].userId];
//
//                BOOL sucess = [data.dataBase executeUpdate:sql];
//
//                NSLog(@"更新自选状态%d",sucess);
//
//            }
//            [data.dataBase close];
//
//        }
//
//    }else{
//
//
//        if (self.isBulid == YES) {
//            if (self.tableView.mj_header.isRefreshing) {
//                return;
//            }
//            //从私钥钱包子界面返回
//            [self switchWithTager:0];
//        }
//    }
//}
//
//-(void)addUSDT
//{
//    NSString *btcadd;
//
////    NSString *pwd;
//    //   获取一键划转币种列表
//    TLDataBase *dataBase = [TLDataBase sharedManager];
//    if ([dataBase.dataBase open]) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT Mnemonics,btcaddress,PwdKey  from THAUser where userId = '%@'",[TLUser user].userId];
//        //        [sql appendString:[TLUser user].userId];
//        FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//        while ([set next])
//        {
//            btcadd = [set stringForColumn:@"btcaddress"];
//        }
//        [set close];
//    }
//    [dataBase.dataBase close];
//
//    NSString *usdtadd;
//    if ([dataBase.dataBase open]) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT address  from THALocal where userId = '%@ and symbol = '%@''",[TLUser user].userId,@"USDT"];
//        //        [sql appendString:[TLUser user].userId];
//        FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//        while ([set next])
//        {
//            usdtadd = [set stringForColumn:@"address"];
//        }
//        [set close];
//    }
//    if ([TLUser isBlankString:usdtadd] == YES){
//        TLDataBase *data = [TLDataBase sharedManager];
//        if ([data.dataBase open]) {
//
//            NSString *sql2 = [NSString stringWithFormat:@"UPDATE THALocal SET address = '%@' WHERE walletId = (SELECT walletId from THAUser where userId='%@') and symbol = '%@' ",btcadd,[TLUser user].userId,@"USDT"];
//            BOOL sucess2 = [data.dataBase executeUpdate:sql2];
//            NSLog(@"%d",sucess2);
//        }
//        [data.dataBase close];
//    }
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.headView];
    
    [self initTableView];
    //登录退出通知
    [self addNotification];
    //列表查询个人账户币种列表
    [self getMyCurrencyList];
}

- (void)initTableView {
    self.tableView = [[PlatformTableView alloc] initWithFrame:CGRectMake(0, self.headView.yy - 5, kScreenWidth, kScreenHeight- kNavigationBarHeight - self.headView.yy + 5) style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    WallAccountVC *accountVC= [[WallAccountVC alloc] init];
    accountVC.currency = self.AssetsListModel[index - 100];
    accountVC.hidesBottomBarWhenPushed = YES;
//    accountVC.title = model.currency;
//    accountVC.billType = CurrentTypeAll;
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







- (void)clickWithdrawWithCurrency:(CurrencyModel *)currencyModel {
    CoinWeakSelf;
    //    实名认证成功后，判断是否设置资金密码
    if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {
        
        TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
        vc.titleString = @"设置交易密码";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        return ;
        
    }
    WithdrawalsCoinVC *coinVC = [WithdrawalsCoinVC new];
    coinVC.currency = currencyModel;
    coinVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:coinVC animated:YES];
}



//#pragma mark -- 点击加号按钮
//- (void)addCurrent{
//
//    AddAccoutMoneyVc *monyVc = [[AddAccoutMoneyVc alloc] init];
//    monyVc.PersonalWallet = 100;
//    [self.navigationController pushViewController:monyVc animated:YES];
//}




- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userlogin) name:kUserLoginNotification object:nil];
}

//更新数据库
//- (void)saveLocalWallet{
//    NSString *totalcount;
//    TLDataBase *data = [TLDataBase sharedManager];
//    if ([data.dataBase open]) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT next from THALocal lo, THAUser th where lo.walletId = th.walletId  and th.userId = '%@'",[TLUser user].userId];
//        FMResultSet *set = [data.dataBase executeQuery:sql];
//        while ([set next]) {
//
//            totalcount = [set stringForColumn:@"next"];
//     }
//        [set close];
//    }
//    [data.dataBase close];
//    if ([totalcount integerValue] == self.coins.count) {
//        //判断是否新加并且删除了币种
//        NSMutableArray *symbolArr = [NSMutableArray array];
//        NSString *totalcount;
//        TLDataBase *data = [TLDataBase sharedManager];
//
//        if ([data.dataBase open]) {
//
//            NSString *sql = [NSString stringWithFormat:@"SELECT symbol from THALocal lo, THAUser th where lo.walletId = th.walletId  and th.userId = '%@'",[TLUser user].userId];
//            FMResultSet *set = [data.dataBase executeQuery:sql];
//            while ([set next]) {
//
//                totalcount = [set stringForColumn:@"symbol"];
//                [symbolArr addObject:totalcount];
//            }
//            [set close];
//        }
//        [data.dataBase close];
//
//        for (int i = 0; i < self.coins.count; i++) {
//
////            for (NSString *symbol in symbolArr) {
//                if ([symbolArr containsObject:self.coins[i].symbol]) {
//
//                }else{
//                    //存在不同的币种 更新本地币种表
//                    TLDataBase *db = [TLDataBase sharedManager];
//
//                    if ([db.dataBase open]) {
//                        NSString *Sql2 =[NSString stringWithFormat:@"delete from THALocal WHERE walletId = (SELECT walletId from THAUser where userId='%@')",[TLUser user].userId];
//
//                        BOOL sucess2  = [db.dataBase executeUpdate:Sql2];
//                        NSLog(@"更新自选表%d",sucess2);
//                    }
//                    [db.dataBase close];
//
//
//                    for (int i = 0; i < self.coins.count; i++) {
//
//                        CoinModel *model = self.coins[i];
//                        TLDataBase *dateBase = [TLDataBase sharedManager];
//                        if ([dateBase.dataBase open]) {
//
//                            BOOL sucess = [dateBase.dataBase executeUpdate:@"INSERT INTO  THALocal(walletId,symbol,type,status,cname,unit,pic1,withdrawFeeString,withfrawFee,orderNo,ename,icon,pic2,pic3,address,IsSelect,next) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.walletId,model.symbol,model.type,model.status,model.cname,model.unit,model.pic1,model.withdrawFeeString,model.withfrawFee,model.orderNo,model.ename,model.icon,model.pic2,model.pic3,model.address,[NSNumber numberWithBool:YES],[NSString stringWithFormat:@"%ld",self.coins.count]];
//
//                            NSLog(@"插入币种表%d",sucess);
//                        }
//                        [dateBase.dataBase close];
//                    }
//
//
//                }
////            }
//
//        }
//        [self queryTotalAllAmount];
//        return;
//    }else {
//
//        TLDataBase *db = [TLDataBase sharedManager];
//
//        if ([db.dataBase open]) {
//            NSString *Sql2 =[NSString stringWithFormat:@"delete from THALocal WHERE walletId = (SELECT walletId from THAUser where userId='%@')",[TLUser user].userId];
//
//            BOOL sucess2  = [db.dataBase executeUpdate:Sql2];
//            NSLog(@"更新自选表%d",sucess2);
//        }
//        [db.dataBase close];
//
//    for (int i = 0; i < self.coins.count; i++) {
//
//        CoinModel *model = self.coins[i];
//        TLDataBase *dateBase = [TLDataBase sharedManager];
//        if ([dateBase.dataBase open]) {
//
//            BOOL sucess = [dateBase.dataBase executeUpdate:@"INSERT INTO  THALocal(walletId,symbol,type,status,cname,unit,pic1,withdrawFeeString,withfrawFee,orderNo,ename,icon,pic2,pic3,address,IsSelect,next) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.walletId,model.symbol,model.type,model.status,model.cname,model.unit,model.pic1,model.withdrawFeeString,model.withfrawFee,model.orderNo,model.ename,model.icon,model.pic2,model.pic3,model.address,[NSNumber numberWithBool:YES],[NSString stringWithFormat:@"%ld",self.coins.count]];
//
//            NSLog(@"插入币种表%d",sucess);
//        }
//        [dateBase.dataBase close];
//    }
//
//    //插入币种表
//    [self queryTotalAllAmount];
//     }
//}

#pragma mark -- 个人钱包列表网络请求
- (void)getMyCurrencyList {
    
    CoinWeakSelf;
    
//    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    if (![TLUser user].isLogin) {
//        return;
//    }
//    helper.code = @"802504";
//    helper.parameters[@"userId"] = [TLUser user].userId;
//    helper.parameters[@"token"] = [TLUser user].token;
//    helper.isList = YES;
//    helper.isCurrency = YES;
//    helper.tableView = self.tableView;
//    [helper modelClass:[CurrencyModel class]];
    [self.tableView addRefreshAction:^{
        
        [CoinUtil refreshOpenCoinList:^{
        
            //    获取公告列表
//            [weakSelf requestRateList];
            //    获取本地存储私钥钱包
//            [weakSelf saveLocalWalletData];
            //   监测是否需要更新新币种
//            [weakSelf saveLocalWallet];
            //   个人钱包余额查询
            [weakSelf queryCenterTotalAmount];
            //   获取私钥钱包
//            [weakSelf queryTotalAllAmount];
            
//            [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//
//                //去除没有的币种
//                NSMutableArray <CurrencyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//                [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    CurrencyModel *currencyModel = (CurrencyModel *)obj;
//                    [shouldDisplayCoins addObject:currencyModel];
//                    //查询总资产
//                }];
////                if (self.switchTager == 1) {
////                    weakSelf.tableView.platforms = shouldDisplayCoins;
////                }
//
//                weakSelf.tableView.platforms = shouldDisplayCoins;
//                weakSelf.AssetsListModel = shouldDisplayCoins;
//                [weakSelf.tableView reloadData_tl];
//
//            } failure:^(NSError *error) {
//
//                [weakSelf.tableView endRefreshingWithNoMoreData_tl];
//
//            }];
        } failure:^{
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView beginRefreshing];
}


//- (void)saveLocalWalletData{
////    if (self.coins.count > 0) {
////        return;
////    }
//    NSMutableArray *arr = [[CoinModel coin] getOpenCoinList];
//    NSMutableArray *temp = arr.mutableCopy;
//    TLDataBase *db = [TLDataBase sharedManager];
//    for (int i = 0; i < temp.count; i++) {
//        NSString *symbol;
//
//        CoinModel *model = temp[i];
////        symbol = model.symbol;
////
//        if ([model.type isEqualToString:@"0"]) {
//            if ([model.symbol isEqualToString:@"BTC"] || [model.symbol isEqualToString:@"USDT"]) {
//                symbol = @"btc";
//            }
//            if ([model.symbol isEqualToString:@"ETH"]) {
//                symbol = @"eth";
//            }
//            if ([model.symbol isEqualToString:@"WAN"]) {
//                symbol = @"wan";
//            }
//        }else if ([model.type isEqualToString:@"1"])
//        {
//
//            symbol = @"eth";
//        }
//        else
//        {
//            symbol = @"wan";
//        }
//
//    if ([db.dataBase open]) {
//
//        NSString *sql = [NSString stringWithFormat:@"SELECT %@address,walletId from THAUser where userId = '%@'",symbol,[TLUser user].userId];
//        FMResultSet *set =  [db.dataBase executeQuery:sql];
//
//        while ([set next]) {
//        CoinModel *coin  = arr[i];
//        coin.address = [set stringForColumn:[NSString stringWithFormat:@"%@address",symbol]];
//        coin.walletId = [NSString stringWithFormat:@"%d",[set intForColumn:@"walletId"]];
//        }
//        [set close];
//    }
//    [db.dataBase close];
//    }
//    self.coins = arr;
//}

//- (void)loadSum{
//    if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
//        self.headerView.cnyAmountLbl.text = [NSString stringWithFormat:@"￥ %.2f",[self.headerView.LocalMoney.text doubleValue] + [self.headerView.privateMoney.text doubleValue]] ;
//    }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
//    {
//  self.headerView.cnyAmountLbl.text = [NSString stringWithFormat:@"₩ %.2f",[self.headerView.LocalMoney.text doubleValue] + [self.headerView.privateMoney.text doubleValue]] ;
//
//    }
//    else{
//  self.headerView.cnyAmountLbl.text = [NSString stringWithFormat:@"¥ %.2f",[self.headerView.LocalMoney.text doubleValue] + [self.headerView.privateMoney.text doubleValue]] ;
//
//    }
//    [self.headerView setNeedsDisplay];
//
//}

#pragma mark - Events

- (void)userlogin
{
    [self getMyCurrencyList];
}


//   个人钱包余额查询
- (void)queryCenterTotalAmount {
    
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

//获取公告列表
//- (void)requestRateList {
//
//    CoinWeakSelf;
//    TLPageDataHelper *help = [[TLPageDataHelper alloc] init];
//    help.parameters[@"channelType"] = @4;
//    help.parameters[@"toSystemCode"] = [AppConfig config].systemCode;
//    help.parameters[@"fromSystemCode"] = [AppConfig config].systemCode;
//        help.parameters[@"start"] = @"1";
//    help.parameters[@"status"] = @"1";
//    help.parameters[@"limit"] = @"10";
//    help.code = @"804040";
//    help.isUploadToken = NO;
//    [help modelClass:[RateModel class]];
//    [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
//        if (objs.count == 0) {
////            [weakSelf.headerView tapClick:nil];
//        }
//        weakSelf.rates = objs;
//        if (objs.count > 0) {
////            weakSelf.headerView.usdRate = weakSelf.rates[0].smsTitle;
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}


@end
