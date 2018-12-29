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

#import "IntegralVC.h"
//我的收益
#import "MyIncomeVC.h"

#import "TLQrCodeVC.h"

#import "MyFriendViewController.h"

@interface TLMineVC ()<MineHeaderSeletedDelegate, UINavigationControllerDelegate,RefreshDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
//头部
@property (nonatomic, strong) MineHeaderView *headerView;
//
@property (nonatomic, strong) MineGroup *group;
//
@property (nonatomic, strong) MineTableView *tableView;

@property (nonatomic, strong) TLImagePicker *imagePicker;


@end

@implementation TLMineVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self requesUserInfoWithResponseObject];
}

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
//    [self addNotification];
    
    
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
//        self.tableView.earnings Str = [NSString stringWithFormat:@"≈%.2f",[responseObject[@"data"][@"incomeTotal"] floatValue]];
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

//-(ZDKContactUsVisibility)active
//{
//    return ZDKContactUsVisibilityArticleListOnly;
//}
//
//- (ZDKNavBarConversationsUIType) navBarConversationsUIType
//{
//    return ZDKNavBarConversationsUITypeLocalizedLabel;
//}

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
    switch (index) {
        case 0:
        {
            SettingVC *settingVC = [SettingVC new];
            settingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
        }
            break;
        case 1:
        {
            MyFriendViewController *vc = [MyFriendViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            TLQrCodeVC *vc = [TLQrCodeVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            JoinMineVc *vc = [[JoinMineVc alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
//            [ZDKZendesk initializeWithAppId: @"71d2ca9aba0cccc12deebfbdd352fbae8c53cd8999dd10bc"
//                                   clientId: @"mobile_sdk_client_7af3526c83d0c1999bc3"
//                                 zendeskUrl: @"https://thachainhelp.zendesk.com"];
//
//            id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:nil email:nil];
//            [[ZDKZendesk instance] setIdentity:userIdentity];
//
//            [ZDKCoreLogger setEnabled:YES];
//            [ZDKSupport initializeWithZendesk:[ZDKZendesk instance]];
//            LangType type = [LangSwitcher currentLangType];
//            NSString *lan;
//            if (type == LangTypeSimple || type == LangTypeTraditional) {
//                lan = @"zh-cn";
//            }else if (type == LangTypeKorean)
//            {
//                lan = @"ko";
//            }else{
//                lan = @"en-us";
//            }
//            [ZDKSupport instance].helpCenterLocaleOverride = lan;
//            [ZDKLocalization localizedStringWithKey:lan];
//            ZDKHelpCenterUiConfiguration *hcConfig = [ZDKHelpCenterUiConfiguration new];
//            [ZDKTheme  currentTheme].primaryColor = [UIColor redColor];
//            UIViewController<ZDKHelpCenterDelegate>*helpCenter  =  [ ZDKHelpCenterUi buildHelpCenterOverviewWithConfigs :@[hcConfig]];
//            self.navigationController.navigationBar.translucent = YES;
//            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//            self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//            self.navigationItem.backBarButtonItem = item;
//            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
//                                                                              NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:16]}];
//            helpCenter.uiDelegate = self;
//            [self.navigationController pushViewController:helpCenter animated:YES];
        }
            break;
        case 5:
        {
            TLMeSetting *vc = [[TLMeSetting alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
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

//- (void)addNotification
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInfo) name:kUserLoginNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInfo) name:kUserInfoChange object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut) name:kUserLoginOutNotification object:nil];
//}

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
    self.headerView.nameLbl.text = [TLUser user].mobile;
    NSRange rang = NSMakeRange(3, 4);
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeNickName)];
    [self.headerView.nameLbl addGestureRecognizer:ta];
    
    self.headerView.mobileLbl.text = [NSString stringWithFormat:@"%@", [TLUser user].mobile];
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
        return ;
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
