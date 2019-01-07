//
//  TLMeSetting.m
//  Coin
//
//  Created by shaojianfei on 2018/8/8.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLMeSetting.h"
#import "IdAuthVC.h"
#import "ZMAuthVC.h"
#import "TLChangeMobileVC.h"
#import "TLUserForgetPwdVC.h"
#import "HTMLStrVC.h"
#import "TLTabBarController.h"
#import "EditVC.h"
#import "GoogleAuthVC.h"
#import "CloseGoogleAuthVC.h"
#import "ChangeLoginPwdVC.h"
#import "SettingGroup.h"
#import "SettingModel.h"
#import "SettingTableView.h"
#import "SettingCell.h"
#import "AppMacro.h"
#import "APICodeMacro.h"
#import "EditEmailVC.h"
#import "TLAlert.h"
#import "NSString+Check.h"
#import "TLProgressHUD.h"
#import "LangChooseVC.h"
#import "TLUserLoginVC.h"
#import "ZLGestureLockViewController.h"
#import "LocalSettingTableView.h"
#import "ChangeLocalMoneyVC.h"
#import "TLAboutUsVC.h"
#import "GengXinModel.h"
#import "SetUpTableView.h"

@interface TLMeSetting ()<RefreshDelegate>

//@property (nonatomic, strong) SettingTableView *tableView;
@property (nonatomic, strong) SetUpTableView *tableView;



@end

@implementation TLMeSetting


- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText.text = [LangSwitcher switchLang:@"设置" key:nil];
    self.titleText.textColor = kTextBlack;
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
}


- (void)initTableView {
    
    
    
    self.tableView = [[SetUpTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        LangChooseVC *vc = [LangChooseVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        ChangeLocalMoneyVC *vc = [ChangeLocalMoneyVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        TLAboutUsVC *vc = [TLAboutUsVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



#pragma mark- 退出登录


//- (void)logout {
//
//    //先退出腾讯云，才算退出成功
//    //im 退出
//    //    [TLProgressHUD showWithStatus:nil];
//    //    [[IMAPlatform sharedInstance] logout:^{
//    //        [TLProgressHUD dismiss];
//    //
//    //        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];
//    //
//    //        TLTabBarController *tabbarVC = (TLTabBarController *)self.tabBarController;
//    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    //
//    //            tabbarVC.selectedIndex = 2;
//    //            [self.navigationController popViewControllerAnimated:NO];
//    //
//    //        });
//    //        //
//    //    } fail:^(int code, NSString *msg) {
//    //
//    //        [TLAlert alertWithInfo:@"退出登录失败"];
//    //
//    //    }];
//    [TLAlert alertWithTitle:[LangSwitcher switchLang:@"退出登录" key:nil] msg:[LangSwitcher switchLang:@"退出登录?" key:nil] confirmMsg:[LangSwitcher switchLang:@"确定" key:nil] cancleMsg:[LangSwitcher switchLang:@"取消" key:nil] maker:self cancle:^(UIAlertAction *action) {
//
//
//    } confirm:^(UIAlertAction *action) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            TLUserLoginVC *loginVC= [TLUserLoginVC new];
//            [self.navigationController pushViewController:loginVC animated:YES];
//
//            //            tabbarVC.selectedIndex = 0;
//            //            [self.navigationController popViewControllerAnimated:NO];
//            //            [self popoverPresentationController];
//
//
//
//        });
//    }];
//
//}

//- (void)setGoogleAuth {
//    //
//    NSString *title = [LangSwitcher switchLang:@"修改谷歌验证" key:nil];
//
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[LangSwitcher switchLang:@"谷歌验证" key:nil] message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction *changeAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        GoogleAuthVC *authVC = [GoogleAuthVC new];
//
//        [self.navigationController pushViewController:authVC animated:YES];
//    }];
//
//    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:[LangSwitcher switchLang:@"关闭谷歌验证" key:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        CloseGoogleAuthVC *closeVC = [CloseGoogleAuthVC new];
//
//        [self.navigationController pushViewController:closeVC animated:YES];
//    }];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[LangSwitcher switchLang:@"取消" key:nil] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//
//    }];
//
//    [alertController addAction:changeAction];
//    [alertController addAction:closeAction];
//    [alertController addAction:cancelAction];
//
//    [self presentViewController:alertController animated:YES completion:nil];
//
//
//}

#pragma mark - Init
//- (void)requestUserInfo {
//
//    //获取用户信息
//    TLNetworking *http = [TLNetworking new];
//
//    http.code = USER_INFO;
//    http.parameters[@"userId"] = [TLUser user].userId;
//    [http postWithSuccess:^(id responseObject) {
//
//        NSDictionary *userInfo = responseObject[@"data"];
//
//        //保存信息
//        [[TLUser user] saveUserInfo:userInfo];
//        [[TLUser user] setUserInfoWithDict:userInfo];
//
//        [self reloadUserInfo];
//
//    } failure:^(NSError *error) {
//
//    }];
//}

#pragma mark- 更新设置状态
//- (void)reloadUserInfo {
//
//    if ([TLUser user].realName && [TLUser user].realName.length) {
//        //认证状态
//        self.realNameSettingModel.subText = [LangSwitcher switchLang:@"已认证" key:nil];
//
//    }
//
//    //邮箱
//    if ([TLUser user].email) {
//
//        self.emailSettingModel.subText = [TLUser user].email;
//
//    }
//
//    //
//    self.googleAuthSettingModel.subText = [TLUser user].isGoogleAuthOpen ? [LangSwitcher switchLang:@"已开启" key:nil]: [LangSwitcher switchLang:@"未开启" key:nil];
//
//    // 只保留数据刷新
//    [self.tableView reloadData];
//
//}



- (NSString *)version {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
}

- (NSString *)current {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
}

//#pragma mark - Config
//- (void)configUpdate {
//
//    //1:iOS 2:安卓
//    TLNetworking *http = [[TLNetworking alloc] init];
//    http.showView = self.view;
//    http.code = @"660918";
//    http.parameters[@"type"] = @"ios-c";
//
//    [http postWithSuccess:^(id responseObject) {
//
//        GengXinModel *update = [GengXinModel mj_objectWithKeyValues:responseObject[@"data"]];
//        [self removePlaceholderView];
//        //获取当前版本号
//        NSString *currentVersion = [self version];
//
//
//        if ([currentVersion integerValue] < [update.version integerValue]) {
//
//            if ([update.forceUpdate isEqualToString:@"0"]) {
//
//                //不强制
//                [TLAlert alertWithTitle:[LangSwitcher switchLang:@"更新提示" key:nil] msg:update.note confirmMsg:[LangSwitcher switchLang:@"立即升级" key:nil] cancleMsg:[LangSwitcher switchLang:@"稍后提醒" key:nil] cancle:^(UIAlertAction *action) {
//
//                    return ;
//
////                    [self setRootVC];
//
//                } confirm:^(UIAlertAction *action) {
//
//                    //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[update.xiaZaiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
//                    [self goBcoinWeb:update.downloadUrl];
//                }];
//
//            } else {
//
//                //强制
//                [TLAlert alertWithTitle:[LangSwitcher switchLang:@"更新提醒" key:nil] message:update.note confirmMsg:[LangSwitcher switchLang:@"立即升级" key:nil] confirmAction:^{
//
//                    //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[update.xiaZaiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
//                    [self goBcoinWeb:update.downloadUrl];
//
//                    return ;
//
//
//                }];
//            }
//        } else {
//
////            [TLAlert alertWithMsg:@"当前已是最新版本"];
//            TLAboutUsVC *aboutVc = [[TLAboutUsVC alloc] init];
//            [self.navigationController pushViewController:aboutVc animated:YES];
////
//
//        }
//
//    } failure:^(NSError *error) {
//
//        [self addPlaceholderView];
//    }];
//
//}

//- (void)goBcoinWeb:(NSString *)var {
//
//    NSString *urlStr = [var stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    [[UIApplication sharedApplication] openURL:url];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
