//
//  TLUserLoginVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLUserLoginVC.h"

#import "BindMobileVC.h"
#import "TLUserRegisterVC.h"
#import "TLUserForgetPwdVC.h"
#import "APICodeMacro.h"
#import "AppMacro.h"
#import "NSString+Check.h"
#import "UIBarButtonItem+convience.h"
#import "UILabel+Extension.h"
#import "CurrencyModel.h"
#import "AccountTf.h"
#import "TLTabBarController.h"
#import "TLCaptchaView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"
#import <UMMobClick/MobClick.h>
#import <SecurityGuardSDK/JAQ/SecurityVerification.h>
#import <MSAuthSDK/MSAuthVCFactory.h>
#import <MSAuthSDK/MSAuthSDK.h>
#import <SecurityGuardSDK/JAQ/SecurityVerification.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "AppConfig.h"
#import "TLUserForgetPwdVC.h"
//腾讯云
//#import "ChatManager.h"   czy
//#import "IMModel.h"
//#import <ImSDK/TIMManager.h>
#import "ChooseWalletVC.h"
@interface TLUserLoginVC ()<UITextFieldDelegate,MSAuthProtocol>

@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *pwdTf;

@property (nonatomic, copy) NSString *verifyCode;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic ,strong) UIImageView *accessoryImageView;
@property (nonatomic ,strong) UILabel *titlePhpne;
@property (nonatomic ,strong) UILabel *PhoneCode;
@property (nonatomic ,strong) UIButton *forgetPwdBtn;
@property (nonatomic ,strong) UILabel *forgetLab;
@property (nonatomic ,strong) UIButton *codeButton;
@property (nonatomic ,strong) TLCaptchaView *captchaView;
@property (nonatomic ,strong)  UIImageView *pic;

@property (nonatomic, copy) NSString *code;

@end

@implementation TLUserLoginVC

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setUpUI];

}


- (void)setUpUI {
    
    
//    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 60,  kStatusBarHeight + 25, 120, 60)];
//    logoView.contentMode = UIViewContentModeScaleToFill;
//    [self.view addSubview:logoView];
//    logoView.image = kImage(@"邀请-logo");
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 170 - 64 + kNavigationBarHeight - 35, SCREEN_WIDTH - 30, 360)];
    [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
    backView.layer.cornerRadius=10;
    backView.layer.shadowOpacity = 0.22;// 阴影透明度
    backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    backView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self.view addSubview:backView];
    
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, SCREEN_WIDTH - 30 - 70, 35)];
    [promptLabel theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
    promptLabel.font = HGboldfont(27);
    promptLabel.text = [LangSwitcher switchLang:@"欢迎回来" key:nil];
    [backView addSubview:promptLabel];
    
    UITextField *phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 70, 50)];
    phoneTextField.placeholder = [LangSwitcher switchLang:@"请输入账号" key:nil];
    [phoneTextField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    phoneTextField.font = FONT(14);
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.textColor = kHexColor([TLUser TextFieldTextColor]);
    [phoneTextField setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
    self.phoneTf = phoneTextField;

    [backView addSubview:phoneTextField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH - 70, 1)];
    [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [backView addSubview:lineView];
    
    
    UITextField *passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 160, SCREEN_WIDTH - 70, 50)];
    passWordTextField.placeholder = [LangSwitcher switchLang:@"请输入密码（6~16个字符或字母组成）" key:nil];
    [passWordTextField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    passWordTextField.font = FONT(14);
    passWordTextField.textColor = kHexColor([TLUser TextFieldTextColor]);
    [passWordTextField setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
    self.pwdTf = passWordTextField;
    [backView addSubview:passWordTextField];
    passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordTextField.secureTextEntry = YES;
    
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH - 70, 1)];
    [lineView1 theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [backView addSubview:lineView1];
    
    
    UIButton *loginBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"登录" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:17.0 cornerRadius:5];
    loginBtn.frame = CGRectMake(15, passWordTextField.yy + 35, SCREEN_WIDTH - 60, 45);
    [loginBtn addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:loginBtn];
    
    
    UIButton *registeredBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"立即注册" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:14.0];
    registeredBtn.frame = CGRectMake(20, loginBtn.yy + 20, (SCREEN_WIDTH - 80)/2, 20);
    registeredBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registeredBtn addTarget:self action:@selector(goReg:) forControlEvents:UIControlEventTouchUpInside];
    [registeredBtn theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    [backView addSubview:registeredBtn];
    
    
    
    UIButton *forgetPwdBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"忘记密码" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:14.0];
    forgetPwdBtn.frame = CGRectMake(registeredBtn.xx, loginBtn.yy + 20, (SCREEN_WIDTH - 80)/2, 20);
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdBtn theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    [backView addSubview:forgetPwdBtn];
}

-(void)forgetPwdBtnClick:(UIButton *)btn
{

    TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
    vc.titleString = @"修改登录密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goReg:(UIButton *)btn {

    TLUserRegisterVC *registerVC = [[TLUserRegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}



#pragma mark - Events



- (void)back {
    
    if (self.NeedLogin == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self.view endEditing:YES];
 
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self goLogin];
    
    return YES;
    
}


- (void)findPwd {
    
}





- (void)goLogin {
    
    if ([self.phoneTf.text isBlank] ) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        
        return;
    }
    
    if ([self.pwdTf.text isBlank] && self.pwdTf.hidden == NO) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入密码" key:nil]];
        return;
    }


    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;

    http.code = USER_LOGIN_CODE;
    http.parameters[@"loginName"] = self.phoneTf.text;
    http.parameters[@"loginPwd"] = self.pwdTf.text;
    http.parameters[@"kind"] = APP_KIND;
//    }
    http.parameters[@"client"] = @"ios";

    
    [http postWithSuccess:^(id responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
        NSLog(@"%@",responseObject[@"data"][@"userId"]);
        [self requesUserInfoWithResponseObject:responseObject];
        [MobClick profileSignInWithPUID:responseObject[@"data"][@"userId"]];
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)requesUserInfoWithResponseObject:(id)responseObject {
    
    NSString *token = responseObject[@"data"][@"token"];
    NSString *userId = responseObject[@"data"][@"userId"];
    
    //1.获取用户信息
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_INFO;
    http.parameters[@"userId"] = userId;
    http.parameters[@"token"] = token;
    [http postWithSuccess:^(id responseObject) {
        
        
        
        NSDictionary *userInfo = responseObject[@"data"];
        
        [TLUser user].userId = userId;
        [TLUser user].token = token;
        
        //保存用户信息
        [[TLUser user] saveUserInfo:userInfo];
        //初始化用户信息
        [[TLUser user] setUserInfoWithDict:userInfo];
        //
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (self.loginSuccess) {
            
            self.loginSuccess();
        }
        
        if ([TLUser isBlankString:[USERDEFAULTS objectForKey:@"firstEnter"]] == YES ) {
            ChooseWalletVC *tab   = [[ChooseWalletVC alloc] init];
            [self.navigationController pushViewController:tab animated:YES];
//            [UIApplication sharedApplication].keyWindow.rootViewController = tab;
            [USERDEFAULTS setObject:@"否" forKey:@"firstEnter"];
            [USERDEFAULTS setObject:@"" forKey:@"mnemonics"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
        }else
        {
            TLUpdateVC *tab   = [[TLUpdateVC alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tab;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

//
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     [self logSet:tags], alias];
    
    NSLog(@"TagsAlias回调:%@", callbackString);
}

- (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}




@end
