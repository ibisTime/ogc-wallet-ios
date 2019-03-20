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
@interface PrivateKeyWalletVC ()<RefreshDelegate>

@property (nonatomic , strong)MyAssetsHeadView *headView;
@property (nonatomic, strong) PlatformTableView *tableView;
@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*AssetsListModel;

@end

@implementation PrivateKeyWalletVC

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self queryCenterTotalAmount];
    [self navigationTransparentClearColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self navigationwhiteColor];
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
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.headView];
    
    [self initTableView];

    
//    self.RightButton.frame = CGRectMake(SCREEN_WIDTH - 100,  - 44, 85, 44);
    self.RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.RightButton.titleLabel.font = FONT(16);
    [self.RightButton setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
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
    self.tableView = [[PlatformTableView alloc] initWithFrame:CGRectMake(0, self.headView.yy - 5, kScreenWidth, kScreenHeight - kNavigationBarHeight - self.headView.yy + 5) style:UITableViewStyleGrouped];
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
    [self.navigationController pushViewController:accountVC animated:YES];
}



- (void)clickWithdrawWithCurrency:(CurrencyModel *)currencyModel {
    CoinWeakSelf;
    //    实名认证成功后，判断是否设置资金密码
//    WithdrawalsCoinVC *coinVC = [WithdrawalsCoinVC new];
//    coinVC.currency = currencyModel;
//    coinVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:coinVC animated:YES];
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


@end
