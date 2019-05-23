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
#import "APICodeMacro.h"
#import "EditEmailVC.h"
#import "LangChooseVC.h"
#import "TLUserLoginVC.h"
#import "ZLGestureLockViewController.h"
#import "LocalSettingTableView.h"
#import "ChangePhoneAndEmailVC.h"
#import "ZQFaceAuthEngine.h"
#import "ZQOCRScanEngine.h"
#import "TLUploadManager.h"
#import "BindingEmailVC.h"
#import "MyBankCardVC.h"
@interface SettingVC ()<RefreshDelegate,ZQFaceAuthDelegate,ZQOcrScanDelegate>{
    NSString *str1;
    NSString *str2;
    NSString *str3;
}

@property (nonatomic, strong) SettingGroup *group;
@property (nonatomic, strong) UIButton *loginOutBtn;
//@property (nonatomic, strong) SettingTableView *tableView;
@property (nonatomic, strong) LocalSettingTableView *tableView;

@property (nonatomic, strong) SettingModel *realNameSettingModel;
@property (nonatomic, strong) SettingModel *emailSettingModel;
@property (nonatomic, strong) SettingModel *googleAuthSettingModel;

@end

@implementation SettingVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestUserInfo];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText.text = [LangSwitcher switchLang:@"账户与安全" key:nil];
    self.navigationItem.titleView = self.titleText;
    
    [self initTableView];
    [self LoadData];
}


-(void)LoadData
{
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"630508";
    http.parameters[@"status"] = @"1";
    http.parameters[@"parentCode"] = @"DH201810120023250401000";
    //    DH201810120023250401000
    [http postWithSuccess:^(id responseObject) {
        
        //        NSArray *array = responseObject[@"data"];
        
        NSArray *array = responseObject[@"data"];
        NSMutableArray *dataArray = [NSMutableArray array];
        NSMutableArray *array1 = [NSMutableArray array];
        NSMutableArray *array2 = [NSMutableArray array];
        NSMutableArray *array3 = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            if ([array[i][@"name"] isEqualToString:@"交易密码"] || [array[i][@"name"] isEqualToString:@"手势密码"]) {
                [array1 addObject:array[i]];
            }
            if ([array[i][@"name"] isEqualToString:@"身份认证"] || [array[i][@"name"] isEqualToString:@"绑定邮箱"]|| [array[i][@"name"] isEqualToString:@"绑定手机号码"]|| [array[i][@"name"] isEqualToString:@"我的收款账号"]) {
                [array2 addObject:array[i]];
            }
            if ([array[i][@"name"] isEqualToString:@"修改邮箱"] || [array[i][@"name"] isEqualToString:@"修改手机号码"] || [array[i][@"name"] isEqualToString:@"修改登录密码"]) {
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
        
        
//        self.tableView.dataArray =  responseObject[@"data"];
//        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
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
    if (indexPath.row == 0) {
        if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {
            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
            vc.titleString = @"设置交易密码";
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
            vc.titleString = @"修改交易密码";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.row == 2) {
        MyBankCardVC *vc = [[MyBankCardVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3) {
        if ([TLUser isBlankString:[TLUser user].idNo] == YES)
        {
            ZQOCRScanEngine *engine = [[ZQOCRScanEngine alloc] init];
            engine.delegate = self;
            engine.appKey = @"nJXnQp568zYcnBdPQxC7TANqakUUCjRZqZK8TrwGt7";
            engine.secretKey = @"887DE27B914988C9CF7B2DEE15E3EDF8";
            [engine startOcrScanIdCardInViewController:self];
        }
    }
//    if (indexPath.row == 3) {
//        
//    }
    if (indexPath.row == 4) {
        TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
        vc.titleString = @"修改登录密码";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 5) {
        if ([TLUser isBlankString:[TLUser user].email] == YES) {
            BindingEmailVC *vc = [BindingEmailVC new];
            vc.titleStr = @"绑定邮箱";
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            ChangePhoneAndEmailVC *vc = [ChangePhoneAndEmailVC new];
            vc.titleString = @"修改邮箱";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.row == 6) {
        if ([TLUser isBlankString:[TLUser user].mobile] == YES)
        {
            BindingEmailVC *vc = [BindingEmailVC new];
            vc.titleStr = @"绑定手机号";
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            ChangePhoneAndEmailVC *vc = [ChangePhoneAndEmailVC new];
            vc.titleString = @"修改手机号";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

//-(void)refreshTableView:(TLTableView *)refreshTableview setCurrencyModel:(CurrencyModel *)model setTitle:(NSString *)title{
//    if ([title isEqualToString:@"交易密码"]) {
//        if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {
//            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
//            vc.titleString = @"设置交易密码";
//            [self.navigationController pushViewController:vc animated:YES];
//        }else
//        {
//            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
//            vc.titleString = @"修改交易密码";
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
//    if ([title isEqualToString:@"手势密码"]) {
//
//    }
//    if ([title isEqualToString:@"身份认证"]) {
//        if ([TLUser isBlankString:[TLUser user].idNo] == YES)
//        {
//            ZQOCRScanEngine *engine = [[ZQOCRScanEngine alloc] init];
//            engine.delegate = self;
//            engine.appKey = @"nJXnQp568zYcnBdPQxC7TANqakUUCjRZqZK8TrwGt7";
//            engine.secretKey = @"887DE27B914988C9CF7B2DEE15E3EDF8";
//            [engine startOcrScanIdCardInViewController:self];
//        }
//
//    }
//    if ([title isEqualToString:@"绑定邮箱"]) {
//        if ([TLUser isBlankString:[TLUser user].email] == YES) {
//            BindingEmailVC *vc = [BindingEmailVC new];
//            vc.titleStr = @"绑定邮箱";
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
//    if ([title isEqualToString:@"绑定手机号码"]) {
//        if ([TLUser isBlankString:[TLUser user].mobile] == YES)
//        {
//            BindingEmailVC *vc = [BindingEmailVC new];
//            vc.titleStr = @"绑定手机号";
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
//    if ([title isEqualToString:@"我的收款账号"]) {
//        MyBankCardVC *vc = [[MyBankCardVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if ([title isEqualToString:@"修改邮箱"]) {
//        if ([TLUser isBlankString:[TLUser user].email] == YES) {
//            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"未绑定邮箱,请前去绑定" key:nil]];
//            return;
//        }
//        ChangePhoneAndEmailVC *vc = [ChangePhoneAndEmailVC new];
//        vc.titleString = @"修改邮箱";
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if ([title isEqualToString:@"修改手机号码"]) {
//        if ([TLUser isBlankString:[TLUser user].mobile] == YES) {
//            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"未绑定手机号,请前去绑定" key:nil]];
//            return;
//        }
//        ChangePhoneAndEmailVC *vc = [ChangePhoneAndEmailVC new];
//        vc.titleString = @"修改手机号";
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    if ([title isEqualToString:@"修改登录密码"]) {
//        TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
//        vc.titleString = @"修改登录密码";
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}




- (void)faceAuthFinishedWithResult:(NSInteger)result userInfo:(id)userInfo
{
    NSLog(@"Swift authFinish");
}

- (void)idCardOcrScanFinishedWithResult:(ZQFaceAuthResult)result userInfo:(id)userInfo
{
    NSLog(@"OC OCR Finish");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = @"即将进入活体识别";
    
    UIImage *frontcard = [userInfo objectForKey:@"frontcard"];
    UIImage *portrait = [userInfo objectForKey:@"portrait"];
    UIImage *backcard = [userInfo objectForKey:@"backcard"];
    if(result  == ZQFaceAuthResult_Done && frontcard != nil && portrait != nil && backcard !=nil)
    {
        NSData *imgData = UIImageJPEGRepresentation(frontcard, 0.6);
        NSData *imgData1 = UIImageJPEGRepresentation(backcard, 0.6);
        //进行上传
        [TLProgressHUD show];
        TLUploadManager *manager = [TLUploadManager manager];
        
        manager.imgData = imgData;
        manager.image = frontcard;
        [manager getTokenShowView:self.view succes:^(NSString *key) {
            
            str1 = key;
            //            [weakSelf changeHeadIconWithKey:key imgData:imgData];
            [TLProgressHUD show];
            TLUploadManager *manager1 = [TLUploadManager manager];
            
            manager1.imgData = imgData1;
            manager1.image = backcard;
            [manager1 getTokenShowView:self.view succes:^(NSString *key) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
                str2 = key;
                ZQFaceAuthEngine * engine = [[ZQFaceAuthEngine alloc]init];
                engine.delegate = self;
                engine.appKey = @"nJXnQp568zYcnBdPQxC7TANqakUUCjRZqZK8TrwGt7";
                engine.secretKey = @"887DE27B914988C9CF7B2DEE15E3EDF8";
                [engine startFaceAuthInViewController:self];
                //            [weakSelf changeHeadIconWithKey:key imgData:imgData];
                
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            }];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        }];
    }else
    {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
    
}

#pragma mark - ZQFaceAuthDelegate
- (void)faceAuthFinishedWithResult:(ZQFaceAuthResult)result UserInfo:(id)userInfo{
    
    UIImage * livingPhoto = [userInfo objectForKey:@"livingPhoto"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = @"正在认证中";
    if(result  == ZQFaceAuthResult_Done && livingPhoto !=nil){
        [TLProgressHUD show];
        TLUploadManager *manager = [TLUploadManager manager];
        NSData *imgData = UIImageJPEGRepresentation(livingPhoto, 0.6);
        manager.imgData = imgData;
        manager.image = livingPhoto;
        [manager getTokenShowView:self.view succes:^(NSString *key) {
            str3 = key;
            
            TLNetworking *http = [TLNetworking new];
//            http.showView = self.view;
            http.code = @"805197";
            http.parameters[@"userId"] = [TLUser user].userId;
            http.parameters[@"frontImage"] = str1;
            http.parameters[@"backImage"] = str2;
            http.parameters[@"faceImage"] = str3;
            //
            [http postWithSuccess:^(id responseObject) {
                [TLAlert alertWithMsg:[LangSwitcher switchLang:@"实名认证成功" key:nil]];
                [self requesUserInfoWithResponseObject];
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            }];
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        }];
    }else
    {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

- (void)requesUserInfoWithResponseObject {
    
    //1.获取用户信息
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary *userInfo = responseObject[@"data"];
        //保存用户信息
        [[TLUser user] saveUserInfo:userInfo];
        //初始化用户信息
        [[TLUser user] setUserInfoWithDict:userInfo];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark- 退出登录

- (UIButton *)loginOutBtn {
    
    if (!_loginOutBtn) {
        
        _loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, kScreenWidth - 40, 50)];
        _loginOutBtn.backgroundColor = kClearColor;
        [_loginOutBtn setTitle:[LangSwitcher switchLang:@"退出登录" key:nil] forState:UIControlStateNormal];
        [_loginOutBtn setTitleColor:kHexColor(@"#77A4FF") forState:UIControlStateNormal];
        _loginOutBtn.layer.cornerRadius = 5;
        _loginOutBtn.layer.borderWidth = 1;
        _loginOutBtn.layer.borderColor = kHexColor(@"#77A4FF").CGColor;
        _loginOutBtn.clipsToBounds = YES;
        _loginOutBtn.titleLabel.font = FONT(16);
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
