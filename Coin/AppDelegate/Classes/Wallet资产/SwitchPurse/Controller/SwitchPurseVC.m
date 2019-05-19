//
//  SwitchPurseVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/6.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SwitchPurseVC.h"
#import "SwitchPurseTableView.h"
#import "SwitchPurseHeadView.h"
#import "BuildWalletMineVC.h"
#import "WalletImportVC.h"
#import "BTCMnemonic.h"
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
@interface SwitchPurseVC ()<RefreshDelegate>
@property (nonatomic , strong)SwitchPurseHeadView *headView;
@property (nonatomic , strong)SwitchPurseTableView *tableView;
@property (nonatomic , strong)NSArray *dataArray;
@end

@implementation SwitchPurseVC

-(SwitchPurseHeadView *)headView
{
    if (!_headView) {
        _headView = [[SwitchPurseHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        [_headView.SwitchPurse addTarget:self action:@selector(SwitchPurseClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headView;
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
        
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [self.tableView endRefreshHeader];
    }];
}

-(void)SwitchPurseClick
{
    NSNotification *notification =[NSNotification notificationWithName:@"SwitchThePurse" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
    [USERDEFAULTS setObject:@"" forKey:@"mnemonics"];
}

- (void)initTableView {
    self.tableView = [[SwitchPurseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    [self LoadData];
    [self queryCenterTotalAmount];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [CustomFMDB FMDBqueryMnemonics];
    [USERDEFAULTS setObject:array[indexPath.row][@"mnemonics"] forKey:@"mnemonics"];
    NSNotification *notification =[NSNotification notificationWithName:@"SwitchThePurse" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
 
    if (index == 100)
    {
        BuildWalletMineVC *vc = [BuildWalletMineVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        WalletImportVC *vc = [WalletImportVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)LoadData
{
    CustomFMDBModel *_fmdbModel;
    
    NSMutableArray *walletList = [NSMutableArray array];
    NSMutableArray *accountList = [NSMutableArray array];
    
    NSMutableArray <CoinModel *>*arr = [[CoinModel coin] getOpenCoinList];
    NSMutableArray *muArray;
    
    NSArray *array = [CustomFMDB FMDBqueryMnemonics];
    
    for (int i = 0; i < array.count; i ++) {
        muArray = [NSMutableArray array];
        _fmdbModel = [CustomFMDBModel mj_objectWithKeyValues:array[i]];
        
        
        for (int i = 0; i < arr.count; i++) {
            CoinModel *model = arr[i];
            if ([arr[i].symbol isEqualToString:@"ET"]) {
                
            }else
            {
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
                
                NSDictionary *coinDic = @{@"symbol":model.symbol,
                                          @"address":address,
                                          };
                [muArray addObject:coinDic];
                
            }
            
        }
        
        NSDictionary *walletListDic = @{@"walletId":_fmdbModel.walletName,
                                        @"accountList":muArray
                                        };
//        [muArray setValue:_fmdbModel.walletName forKey:@"walletId"];
//        [accountList addObjectsFromArray:muArray];
        

        
        [walletList addObject:walletListDic];
        
    }
    
    
    
    
//    self.addressArray = muArray;
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"802272";
    http.showView = self.view;
    http.parameters[@"walletList"] = walletList;
 
    [http postWithSuccess:^(id responseObject) {
        
        self.dataArray = responseObject[@"data"][@"walletList"];
        self.tableView.dataArray = self.dataArray;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self.tableView endRefreshHeader];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.topView theme_setBackgroundColorIdentifier:TableViewColor moduleName:ColorName];
    [self initTableView];
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
