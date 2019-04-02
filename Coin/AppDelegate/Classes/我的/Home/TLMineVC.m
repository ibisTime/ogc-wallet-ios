//
//  TLMineVC.m
//  Coin
//
//  Created by  tianlei on 2017/11/06.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLMineVC.h"

#import "APICodeMacro.h"

#import "MineGroup.h"

#import "MineTableView.h"
#import "MineHeaderView.h"
#import "TLAboutUsVC.h"
#import "SettingVC.h"
#import "HTMLStrVC.h"

#import "TLImagePicker.h"
#import "TLUploadManager.h"

#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CDCommon/UIScrollView+TLAdd.h>

#import "MineCell.h"
#import "LangChooseVC.h"
#import "JoinMineVc.h"
#import "WalletSettingVC.h"
#import "TLUserLoginVC.h"
#import "ChangeLocalMoneyVC.h"
#import "TLChangeNikeName.h"
#import "BuildWalletMineVC.h"
#import "TLQusertionVC.h"
#import "TLinviteVC.h"
#import "TLMeSetting.h"
#import "NewHelpCentetVC.h"
#import "GoldenRiceBlessingVC.h"
#import "IntegralVC.h"
//我的收益
#import "MyIncomeVC.h"

#import "TLQrCodeVC.h"

#import "MyFriendViewController.h"
#import "MyBankCardVC.h"
#import "PrivateKeyWalletVC.h"


@interface TLMineVC ()<MineHeaderSeletedDelegate, UINavigationControllerDelegate,RefreshDelegate,ZDKHelpCenterConversationsUIDelegate,ZDKHelpCenterDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
//头部
@property (nonatomic, strong) MineHeaderView *headerView;
//
@property (nonatomic, strong) MineGroup *group;
//
@property (nonatomic, strong) MineTableView *tableView;

@property (nonatomic, strong) TLImagePicker *imagePicker;

@property (nonatomic , strong)NSArray *dataArray;



@end

@implementation TLMineVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self requesUserInfoWithResponseObject];
    [self LoadData];
    [self blessingLoadData];
}

//-(NSString *)base58OwnerAddress
//{
//    NSData *mdata = [self ownerAddress];
//    NSString *address = BTCBase58StringWithData(mdata);
//    //    NSLog(@"address is: %@",address);
//    //    NSData *d = BTCDataFromBase58(address);
//    //    [self printData:d name:@"reverse 58"];
//
//    return address;
//}
//
//-(NSString *)base58CheckOwnerAddress
//{
//    NSData *mdata = [self ownerAddress];
//
//    NSString *address = BTCBase58CheckStringWithData(mdata);
//    //    NSLog(@"base58 check address is: %@",address);
//    return address;
//}
//
//-(NSData *)ownerAddress
//{
//    if (_ownerAddress) {
//        return _ownerAddress;
//    }
//    const uint8_t *pubBytes = (const uint8_t *)[_publicKey bytes];
//    if (_publicKey.length == 65) {
//        //remove prefix
//        NSData *pubdata = [_publicKey subdataWithRange:NSMakeRange(1, 64)];
//        pubBytes = (const uint8_t *)[pubdata bytes];
//    }
//
//    uint8_t l_public[64];
//    memcpy(l_public, pubBytes, 64);
//
//    NSData *data = [NSData dataWithBytes:l_public length:64];
//    //    [self printData:data name:@"merge pubkey"];
//
//    NSData *sha256Data = [data KECCAK256Hash];
//    //    [self printData:sha256Data name:@"256 key"];
//
//    NSData *subData = [sha256Data subdataWithRange:NSMakeRange(sha256Data.length - 20, 20)];
//
//    NSMutableData *mdata = [[NSMutableData alloc]init];
//
//
//    //    uint8_t pre = 0xa0;
//
//    //on line
//    uint8_t pre = 0x41;
//
//    [mdata appendBytes:&pre length:1];
//
//    [mdata appendData:subData];
//    //    [self printData:mdata name:@" address data "];
//
//
////    NSData *hash0 = [mdata SHA256Hash];
////    //    [self printData:hash0 name:@" hash 0 "];
////    NSData *hash1 = [hash0 SHA256Hash];
////    //    [self printData:hash1 name:@" hash 1 "];
////
////    [mdata appendData:[hash1 subdataWithRange:NSMakeRange(0, 4)]];
//    //    [self printData:mdata name:@"address check sum"];
//    _ownerAddress = mdata;
//    return mdata;
//}





//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText.text = [LangSwitcher switchLang:@"我的" key:nil];
    self.titleText.font = FONT(18);
    self.navigationItem.titleView = self.titleText;
    //顶部视图
    [self initMineHeaderView];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initTableView];
    //初始化用户信息
    [[TLUser user] updateUserInfo];
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"PrivateKeyWalletCreat" object:nil];
}




#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    
    NSDictionary *walletDic = [CustomFMDB FMDBqueryUseridMnemonicsPwdWalletName];
    if ([TLUser isBlankString:walletDic[@"mnemonics"]] == NO) {
        PrivateKeyWalletVC *vc = [[PrivateKeyWalletVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
        BuildWalletMineVC *vc = [[BuildWalletMineVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PrivateKeyWalletCreat" object:nil];
}

-(void)refreshTableView:(TLTableView *)refreshTableview setCurrencyModel:(CurrencyModel *)model setTitle:(NSString *)title
{
    if ([title isEqualToString:@"账户与安全"]) {
        SettingVC *settingVC = [SettingVC new];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }else
    if ([title isEqualToString:@"我的好友"]) {
        MyFriendViewController *vc = [MyFriendViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    if ([title isEqualToString:@"邀请有礼"]) {
        TLQrCodeVC *vc = [TLQrCodeVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    if ([title isEqualToString:@"加入社群"]) {
        JoinMineVc *vc = [[JoinMineVc alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    if ([title isEqualToString:@"帮助中心"]) {
        [ZDKZendesk initializeWithAppId: @"3006217d048e0c25c210e014be2cc72bdfad90c96709835f"
                               clientId: @"mobile_sdk_client_e92fbb186a7406874c6b"
                             zendeskUrl: @"https://moorebit.zendesk.com"];
        
        id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:nil email:nil];
        [[ZDKZendesk instance] setIdentity:userIdentity];
        [ZDKCoreLogger setEnabled:YES];
        [ZDKSupport initializeWithZendesk:[ZDKZendesk instance]];
        LangType type = [LangSwitcher currentLangType];
        NSString *lan;
        if (type == LangTypeSimple || type == LangTypeTraditional) {
            lan = @"zh-cn";
        }else if (type == LangTypeKorean)
        {
            lan = @"ko";
        }else{
            lan = @"en-us";
        }
        [ZDKSupport instance].helpCenterLocaleOverride = lan;
        [ZDKLocalization localizedStringWithKey:lan];
        ZDKHelpCenterUiConfiguration *hcConfig  =  [ZDKHelpCenterUiConfiguration  new];
        [ZDKTheme  currentTheme].primaryColor  = [UIColor redColor];
        UIViewController<ZDKHelpCenterDelegate>*helpCenter  =  [ ZDKHelpCenterUi  buildHelpCenterOverviewWithConfigs :@[hcConfig]];
        
        self.navigationController.navigationBar.translucent = YES;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationItem.backBarButtonItem = item;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:16]}];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        helpCenter.uiDelegate = self;
        helpCenter.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:helpCenter animated:YES];
    }else
    if ([title isEqualToString:@"设置"]) {
        TLMeSetting *vc = [[TLMeSetting alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([title isEqualToString:@"金米钱包"])
    {
        NSDictionary *walletDic = [CustomFMDB FMDBqueryUseridMnemonicsPwdWalletName];
        if ([TLUser isBlankString:walletDic[@"mnemonics"]] == NO) {
            PrivateKeyWalletVC *vc = [[PrivateKeyWalletVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            
            BuildWalletMineVC *vc = [[BuildWalletMineVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else
        if ([title isEqualToString:@"金米福分"]) {
            GoldenRiceBlessingVC *vc = [[GoldenRiceBlessingVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.blessing = self.tableView.blessing;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
    {
        [TLAlert alertWithInfo:@"敬请期待"];
    }
}

-(void)blessingLoadData
{
//    TLNetworking *http = [TLNetworking new];
//    //    http.showView = self.view;
//    http.code = @"805913";
//    http.parameters[@"userId"] = [TLUser user].userId;
////    http.parameters[@"parentCode"] = @"DH201810120023250400000";
//    //    DH201810120023250401000
//    [http postWithSuccess:^(id responseObject) {
//        self.tableView.blessing = [responseObject[@"data"][@"regAcount"] integerValue];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
}

-(void)LoadData
{
    TLNetworking *http = [TLNetworking new];
//    http.showView = self.view;
    http.code = @"630508";
    http.parameters[@"status"] = @"1";
    http.parameters[@"parentCode"] = @"DH201810120023250400000";
//    DH201810120023250401000
    [http postWithSuccess:^(id responseObject) {
        
        NSArray *array = responseObject[@"data"];
        NSMutableArray *dataArray = [NSMutableArray array];
        NSMutableArray *array1 = [NSMutableArray array];
        NSMutableArray *array2 = [NSMutableArray array];
        NSMutableArray *array3 = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            if ([array[i][@"name"] isEqualToString:@"账户与安全"] || [array[i][@"name"] isEqualToString:@"金米钱包"]) {
                [array1 addObject:array[i]];
            }
            if ([array[i][@"name"] isEqualToString:@"我的好友"] || [array[i][@"name"] isEqualToString:@"邀请有礼"] || [array[i][@"name"] isEqualToString:@"金米福分"]) {
                [array2 addObject:array[i]];
            }
            if ([array[i][@"name"] isEqualToString:@"加入社群"] || [array[i][@"name"] isEqualToString:@"帮助中心"] || [array[i][@"name"] isEqualToString:@"设置"]) {
                [array3 addObject:array[i]];
            }
        }
        
        if (array1.count>0) {
            [dataArray addObject:array1];
        }
        if (array2.count>0) {
            [dataArray addObject:array2];
        }
        if (array3.count>0) {
            [dataArray addObject:array3];
        }
        
        self.tableView.dataArray =  dataArray;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)requesUserInfoWithResponseObject {
    
    //1.获取用户信息
    if ([TLUser user].isLogin == NO) {
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary *userInfo = responseObject[@"data"];
        //保存用户信息
        [[TLUser user] saveUserInfo:userInfo];
        //初始化用户信息
        [[TLUser user] setUserInfoWithDict:userInfo];
        [self changeInfo];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark- overly-delegate
#pragma mark - Init
- (void)initMineHeaderView
{
    MineHeaderView *mineHeaderView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 135 + kNavigationBarHeight)];
    mineHeaderView.delegate = self;
    self.headerView = mineHeaderView;
}

- (void)initTableView
{
    self.tableView = [[MineTableView alloc] initWithFrame:CGRectMake(0, 175 - 64 + kNavigationBarHeight, kScreenWidth, kScreenHeight - (175 - 64 + kNavigationBarHeight) - kTabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.mineGroup = self.group;
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.headerView];

    self.view.backgroundColor = kClearColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
}

- (TLImagePicker *)imagePicker {
    if (!_imagePicker) {
        CoinWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];
            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                [weakSelf changeHeadIconWithKey:key imgData:imgData];
            } failure:^(NSError *error) {
            }];
        };
    }
    return _imagePicker;
}

-(ZDKContactUsVisibility)active {
    return ZDKContactUsVisibilityArticleListOnly;
}

- (ZDKNavBarConversationsUIType) navBarConversationsUIType
{
    return ZDKNavBarConversationsUITypeLocalizedLabel;
}

//#pragma mark - Events
- (void)loginOut
{
    [[TLUser user] loginOut];
    [self.headerView.photoBtn setImage:kImage(@"头像") forState:UIControlStateNormal];
    self.headerView.nameLbl.text = nil;
    self.headerView.mobileLbl.text = nil;
}

- (void)changeInfo {
    
    [[TLUser user] changLoginTime];
    //
    if ([TLUser user].photo)
    {
        [self.headerView.photoBtn sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].photo convertImageUrl]] forState:UIControlStateNormal];
    }
    else
    {
        [self.headerView.photoBtn setImage:kImage(@"头像") forState:UIControlStateNormal];
    }
    self.headerView.nameLbl.text = [TLUser user].nickname;
    NSRange rang = NSMakeRange(3, 4);
    
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeNickName)];
    [self.headerView.nameLbl addGestureRecognizer:ta];
    
    if ([TLUser isBlankString:[TLUser user].mobile] == YES) {
        if ([TLUser user].email.length>10) {
            self.headerView.mobileLbl.text =[[TLUser user].email stringByReplacingCharactersInRange:rang withString:@"****"];
        }else
        {
            self.headerView.mobileLbl.text = [TLUser user].email;
        }
        
    }else
    {
        self.headerView.mobileLbl.text = [[TLUser user].mobile stringByReplacingCharactersInRange:rang withString:@"****"];
    }
    
    self.headerView.levelBtn.hidden = [[TLUser user].level isEqualToString:kLevelOrdinaryTraders] ? YES : NO;
    [self.headerView.mobileLbl sizeToFit];
    
    [self.headerView.integralBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView.mobileLbl.mas_right).offset(20);
        make.right.equalTo(self.headerView.mas_right).offset(-20);
        make.top.equalTo(@(kHeight(75)));
        make.height.equalTo(@14);
    }];
    [self.headerView.integralBtn addTarget:self action:@selector(integralBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}
//信用积分
-(void)integralBtnClick
{
    IntegralVC *vc = [IntegralVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeNickName
{
    //修改昵称
    TLChangeNikeName *name = [TLChangeNikeName new];
    if ([TLUser user].isLogin == YES) {
        name.text = [TLUser user].nickname;
        name.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:name animated:YES];
    }
}

- (void)changeHeadIcon {
    if (![TLUser user].isLogin) {
        TLUserLoginVC *loginVC= [TLUserLoginVC new];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        loginVC.loginSuccess = ^{
            
        };
        return;
    }
    [self.imagePicker picker];
}

- (void)changeHeadIconWithKey:(NSString *)key imgData:(NSData *)imgData {
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_CHANGE_USER_PHOTO;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"photo"] = key;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"修改头像成功" key:nil]];
        [TLUser user].photo = key;
        [self requesUserInfoWithResponseObject];
        [[TLUser user] updateUserInfoWithNotification:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - MineHeaderSeletedDelegate
- (void)didSelectedWithType:(MineHeaderSeletedType)type {
    switch (type) {
        case MineHeaderSeletedTypePhoto:
        {
            [self changeHeadIcon];
        }break;
        default:
            break;
    }
}

@end
