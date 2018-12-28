//
//  SettingVC.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/9.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "SettingVC.h"
#import "IdAuthVC.h"
#import "ZMAuthVC.h"
#import "TLChangeMobileVC.h"
#import "TLPwdRelatedVC.h"
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
#import "ChangePhoneAndEmailVC.h"

@interface SettingVC ()<RefreshDelegate>

@property (nonatomic, strong) SettingGroup *group;
@property (nonatomic, strong) UIButton *loginOutBtn;
//@property (nonatomic, strong) SettingTableView *tableView;
@property (nonatomic, strong) LocalSettingTableView *tableView;


//
@property (nonatomic, strong) SettingModel *realNameSettingModel;
@property (nonatomic, strong) SettingModel *emailSettingModel;
@property (nonatomic, strong) SettingModel *googleAuthSettingModel;

@end

@implementation SettingVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestUserInfo];

}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];


}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText.text = [LangSwitcher switchLang:@"账户与安全" key:nil];
    self.titleText.textColor = kTextBlack;
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
}

#pragma mark - Init

- (void)initTableView {
    


    self.tableView = [[LocalSettingTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    CoinWeakSelf;
    self.tableView.SwitchBlock = ^(NSInteger switchBlock) {
        if (switchBlock ==1) {
            ZLGestureLockViewController *vc = [[ZLGestureLockViewController alloc] initWithUnlockType:ZLUnlockTypeCreatePsw];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [ZLGestureLockViewController deleteGesturesPassword];

//            ZLGestureLockViewController *vc = [[ZLGestureLockViewController alloc] initWithUnlockType:ZLUnlockTypeCreatePsw];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        
    };
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    
    [footerView addSubview:self.loginOutBtn];
    
    self.tableView.tableFooterView = footerView;
    
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
            vc.titleString = @"修改交易密码";
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }
        
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ChangePhoneAndEmailVC *vc = [ChangePhoneAndEmailVC new];
            vc.titleString = @"修改邮箱";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            ChangePhoneAndEmailVC *vc = [ChangePhoneAndEmailVC new];
            vc.titleString = @"修改手机号";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2) {
            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
            vc.titleString = @"修改登录密码";
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}




#pragma mark- 退出登录

- (UIButton *)loginOutBtn {
    
    if (!_loginOutBtn) {
        
        _loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, kScreenWidth - 40, 50)];
        _loginOutBtn.backgroundColor = kClearColor;
        [_loginOutBtn setTitle:[LangSwitcher switchLang:@"退出登录" key:nil] forState:UIControlStateNormal];
        [_loginOutBtn setTitleColor:RGB(54, 73, 198) forState:UIControlStateNormal];
        _loginOutBtn.layer.cornerRadius = 5;
        _loginOutBtn.layer.borderWidth = 1;
        _loginOutBtn.layer.borderColor = RGB(54, 73, 198).CGColor;
        _loginOutBtn.clipsToBounds = YES;
        _loginOutBtn.titleLabel.font = FONT(15);
        [_loginOutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginOutBtn;
    
}

- (void)logout {
    
    //先退出腾讯云，才算退出成功
    //im 退出
//    [TLProgressHUD showWithStatus:nil];
//    [[IMAPlatform sharedInstance] logout:^{
//        [TLProgressHUD dismiss];
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];
//
//        TLTabBarController *tabbarVC = (TLTabBarController *)self.tabBarController;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            tabbarVC.selectedIndex = 2;
//            [self.navigationController popViewControllerAnimated:NO];
//
//        });
//        //
//    } fail:^(int code, NSString *msg) {
//
//        [TLAlert alertWithInfo:@"退出登录失败"];
//
//    }];
    [TLAlert alertWithTitle:[LangSwitcher switchLang:@"退出登录" key:nil] msg:[LangSwitcher switchLang:@"退出登录?" key:nil] confirmMsg:[LangSwitcher switchLang:@"确定" key:nil] cancleMsg:[LangSwitcher switchLang:@"取消" key:nil] maker:self cancle:^(UIAlertAction *action) {
        
        
    } confirm:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          
                TLUserLoginVC *loginVC= [TLUserLoginVC new];
                [self.navigationController pushViewController:loginVC animated:YES];
          
//            tabbarVC.selectedIndex = 0;
//            [self.navigationController popViewControllerAnimated:NO];
//            [self popoverPresentationController];
            
            
            
        });
    }];
   
}

- (void)setGoogleAuth {
    //
    NSString *title = [LangSwitcher switchLang:@"修改谷歌验证" key:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[LangSwitcher switchLang:@"谷歌验证" key:nil] message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *changeAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        GoogleAuthVC *authVC = [GoogleAuthVC new];
        
        [self.navigationController pushViewController:authVC animated:YES];
    }];
    
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:[LangSwitcher switchLang:@"关闭谷歌验证" key:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CloseGoogleAuthVC *closeVC = [CloseGoogleAuthVC new];
        
        [self.navigationController pushViewController:closeVC animated:YES];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[LangSwitcher switchLang:@"取消" key:nil] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alertController addAction:changeAction];
    [alertController addAction:closeAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

#pragma mark - Init
- (void)requestUserInfo {
    
    //获取用户信息
    TLNetworking *http = [TLNetworking new];
    
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
        NSDictionary *userInfo = responseObject[@"data"];
        
        //保存信息
        [[TLUser user] saveUserInfo:userInfo];
        [[TLUser user] setUserInfoWithDict:userInfo];
        
        [self reloadUserInfo];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark- 更新设置状态
- (void)reloadUserInfo {
    
    if ([TLUser user].realName && [TLUser user].realName.length) {
        //认证状态
        self.realNameSettingModel.subText = [LangSwitcher switchLang:@"已认证" key:nil];
        
    }
    
    //邮箱
    if ([TLUser user].email) {
        
        self.emailSettingModel.subText = [TLUser user].email;
        
    }
    
    //
    self.googleAuthSettingModel.subText = [TLUser user].isGoogleAuthOpen ? [LangSwitcher switchLang:@"已开启" key:nil]: [LangSwitcher switchLang:@"未开启" key:nil];

    // 只保留数据刷新
    [self.tableView reloadData];
    
}


@end
