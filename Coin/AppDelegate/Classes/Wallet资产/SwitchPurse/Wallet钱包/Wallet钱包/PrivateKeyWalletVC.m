//
//  PrivateKeyWalletVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/3/20.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PrivateKeyWalletVC.h"
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
#import "AssetsHeadView.h"
#import "MyAssetsHeadView.h"
#import "WalletSettingVC.h"
#import "PrivateKeyWalletTableView.h"
#import "WalletLocalVc.h"
#import "BTCBase58.h"
#import "SecureData.h"
#import "sha3.h"
#import "ccMemory.h"
#import "NSData+Hashing.h"
#import "TWWalletAccountClient.h"
#import "TWHexConvert.h"
@interface PrivateKeyWalletVC ()<RefreshDelegate>
{
    NSData *_publicKey;
    NSData *_ownerAddress;
}
@property (nonatomic , strong)MyAssetsHeadView *headView;
@property (nonatomic, strong) PrivateKeyWalletTableView *tableView;
@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*AssetsListModel;
@property (nonatomic, strong) CustomFMDBModel *fmdbModel;
@property (nonatomic , strong)NSArray *addressArray;
@property(nonatomic , strong) TWWalletAccountClient *client;
@end

@implementation PrivateKeyWalletVC

-(void)viewWillAppear:(BOOL)animated
{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(MyAssetsHeadView *)headView
{
    if (!_headView) {
        _headView = [[MyAssetsHeadView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, 87 - 64 + kNavigationBarHeight - 10 + 180)];
        _headView.nameLable.text = @"金米钱包";
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.headView];
    [self initTableView];
    self.RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.RightButton.titleLabel.font = FONT(16);
    
    [self.RightButton theme_setTitleIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    [self.RightButton setTitle:@"钱包工具" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(RightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    //列表查询个人账户币种列表
    [self getMyCurrencyList];
}

-(void)RightButtonClick
{
    WalletSettingVC *vc = [WalletSettingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initTableView {
    self.tableView = [[PrivateKeyWalletTableView alloc] initWithFrame:CGRectMake(0, self.headView.yy - 5, kScreenWidth, kScreenHeight - kNavigationBarHeight - self.headView.yy + 5) style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    WalletLocalVc *accountVC= [[WalletLocalVc alloc] init];
    accountVC.currency = self.AssetsListModel[index - 100];
    accountVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:accountVC animated:YES];
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
    NSMutableArray *arr = [[CoinModel coin] getOpenCoinList];
    NSMutableArray *muArray = [NSMutableArray array];
    
    
    
    _fmdbModel = [CustomFMDBModel mj_objectWithKeyValues:[CustomFMDB FMDBqueryUseridMnemonicsPwdWalletName]];
    
    for (int i = 0; i < arr.count; i++) {
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
                //    TWWalletAccountClient *client = [[TWWalletAccountClient alloc] initWithGenKey:YES type:type];
                TWWalletAccountClient *client = [[TWWalletAccountClient alloc]initWithPriKeyStr:prikey type:type];
                [client store:dic[@"pwd"]];
                
                //    [client store:password];
                
                //    NSString *str = [self base58CheckOwnerAddress];
                address = [client base58OwnerAddress];
            }
            [arr[i] setValue:address forKey:@"address"];
            NSDictionary *coinDic = @{@"symbol":model.symbol,
                                      @"address":address,
                                      };
            [muArray addObject:coinDic];
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
        
        [self.tableView reloadData];
        self.AssetsListModel = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
        
        [self.tableView endRefreshHeader];
        
    } failure:^(NSError *error) {
        [weakSelf.tableView endRefreshHeader];
        
    }];
}

#pragma mark -- 个人钱包列表网络请求
- (void)getMyCurrencyList {
    
    CoinWeakSelf;
    [self.tableView addRefreshAction:^{
        
        [CoinUtil refreshOpenCoinList:^{
            
            [weakSelf saveLocalWalletData];
            
        } failure:^{
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView beginRefreshing];
}


#pragma mark - Events



//   个人钱包余额查询
//- (void)queryCenterTotalAmount {
//
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"802301";
//    http.parameters[@"userId"] = [TLUser user].userId;
//    http.parameters[@"token"] = [TLUser user].token;
//
//    [http postWithSuccess:^(id responseObject) {
//
//        self.headView.dataDic = responseObject[@"data"];
//        self.tableView.platforms = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
//        [self.tableView reloadData];
//        self.AssetsListModel = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
//        [self.tableView endRefreshHeader];
//    } failure:^(NSError *error) {
//
//        [self.tableView endRefreshHeader];
//    }];
//}


@end
