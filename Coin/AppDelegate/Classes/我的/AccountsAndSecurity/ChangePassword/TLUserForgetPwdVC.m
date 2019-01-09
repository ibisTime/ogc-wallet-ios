//
//  TLUserForgetPwdVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLUserForgetPwdVC.h"
#import "CaptchaView.h"
#import "NSString+Check.h"
#import "APICodeMacro.h"
#import "UIBarButtonItem+convience.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"
#import "CountryModel.h"
@interface TLUserForgetPwdVC ()

@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UITextField *pwdTf;
@property (nonatomic,strong) UITextField *rePwdTf;


@end

@implementation TLUserForgetPwdVC
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText.text = [LangSwitcher switchLang:_titleString key:nil];
    self.navigationItem.titleView = self.titleText;
    self.view.backgroundColor = kWhiteColor;
    [self initSubviews];
}


- (void)initSubviews {
    
    
    NSArray *array = @[@"请输入手机号",@"请输入验证码",@"请输入密码",@"请输入密码"];
    for (int i = 0 ; i < 4; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30, 50)];
        textField.placeholder = [LangSwitcher switchLang:array[i] key:nil];
        [textField setValue:FONT(16) forKeyPath:@"_placeholderLabel.font"];
        textField.font = FONT(16);
        //        self.pwdTf = textField;
        [self.view addSubview:textField];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, textField.yy, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
        
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        switch (i) {
            case 0:
            {
                self.phoneTf = textField;
            }
                break;
            case 1:
            {
                self.codeTf = textField;
                
                UIButton *codeBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"获取验证码" key:nil] titleColor:kTabbarColor backgroundColor:kClearColor titleFont:13];
                [codeBtn sizeToFit];
                codeBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - codeBtn.width - 30, textField.y + 10, codeBtn.width + 30, 30);
                kViewBorderRadius(codeBtn, 2, 1, kTabbarColor);
                [codeBtn addTarget:self action:@selector(sendCaptcha:) forControlEvents:(UIControlEventTouchUpInside)];
                [self.view addSubview:codeBtn];
                
                textField.frame = CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30 - codeBtn.width - 10, 50);
                
            }
                break;
            case 2:
            {
                self.pwdTf = textField;
                textField.secureTextEntry = YES;
                
            }
                break;
            case 3:
            {
                self.rePwdTf = textField;
                textField.secureTextEntry = YES;
                
            }
                break;
                
            default:
                break;
        }
        
    }
    UIButton *changePwdBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确 定" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16.0 cornerRadius:5];
    changePwdBtn.frame = CGRectMake(15, self.rePwdTf.yy + 66, SCREEN_WIDTH - 30, 48);
    [changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePwdBtn];
}



#pragma mark - Events
- (void)sendCaptcha:(UIButton *)sender {
    if (![self.phoneTf.text isPhoneNum]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = CAPTCHA_CODE;
    http.parameters[@"client"] = @"ios";
//    http.parameters[@"sessionId"] = sessionId;
    if ([self.titleString isEqualToString:@"修改登录密码"]) {
        http.parameters[@"bizType"] = USER_FIND_PWD_CODE;
    }
    if ([self.titleString isEqualToString:@"设置交易密码"]) {
        
        http.parameters[@"bizType"] = @"805066";
    }
    if ([self.titleString isEqualToString:@"修改交易密码"]) {
        
        http.parameters[@"bizType"] = @"805067";
    }
    
    
    
    http.parameters[@"mobile"] = self.phoneTf.text;
//    http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
        [[UserModel user] phoneCode:sender];
//        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)changePwd {
    if ([self.phoneTf.text isBlank]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        return;
    }
    if ([self.codeTf.text  isBlank]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        return;
    }
    if ([self.pwdTf.text isBlank]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入密码" key:nil]];
        return;
    }
    if (![self.pwdTf.text isEqualToString:self.rePwdTf.text]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"输入的密码不一致" key:nil]];
        return;
    }
    
    [self.view endEditing:YES];

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    if ([self.titleString isEqualToString:@"修改登录密码"]) {
        http.code = USER_FIND_PWD_CODE;
        http.parameters[@"mobile"] = self.phoneTf.text;
        http.parameters[@"smsCaptcha"] = self.codeTf.text;
        http.parameters[@"newLoginPwd"] = self.pwdTf.text;
    }
    if ([self.titleString isEqualToString:@"设置交易密码"]) {
        http.code = @"805066";
        
        http.parameters[@"userId"] =[TLUser user].userId;
//        http.parameters[@"mobile"] = self.phoneTf.text;
        http.parameters[@"smsCaptcha"] = self.codeTf.text;
        http.parameters[@"tradePwd"] = self.pwdTf.text;
    }
    
    if ([self.titleString isEqualToString:@"修改交易密码"]) {
        http.code = @"805067";
        
        http.parameters[@"userId"] =[TLUser user].userId;
        //        http.parameters[@"mobile"] = self.phoneTf.text;
        http.parameters[@"smsCaptcha"] = self.codeTf.text;
        http.parameters[@"newLoginPwd"] = self.pwdTf.text;
    }
    
    
    http.parameters[@"kind"] = APP_KIND;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"修改成功" key:nil]];
        [[TLUser user] updateUserInfo];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
