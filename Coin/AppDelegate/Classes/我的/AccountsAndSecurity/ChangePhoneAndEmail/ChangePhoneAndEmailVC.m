//
//  ChangePhoneAndEmailVC.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/28.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "ChangePhoneAndEmailVC.h"

@interface ChangePhoneAndEmailVC ()

@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UITextField *pwdTf;
@property (nonatomic,strong) UITextField *rePwdTf;

@end

@implementation ChangePhoneAndEmailVC

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
    NSArray *array;
    if ([_titleString isEqualToString:@"修改手机号"]) {
        array = @[@"请输入手机号",@"请输入验证码",@"新手机号",@"请输入验证码"];
    }else
    {
        array = @[@"请输入邮箱",@"请输入验证码",@"输入新的邮箱",@"请输入验证码"];
    }
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
                if ([_titleString isEqualToString:@"修改手机号"]) {
                    textField.text = [TLUser user].mobile;
                    textField.enabled = YES;
                }else
                {
                    textField.text = [TLUser user].email;
                    textField.enabled = YES;
                }
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
                codeBtn.tag = 100;
                [self.view addSubview:codeBtn];
                
                textField.frame = CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30 - codeBtn.width - 10, 50);
                
            }
                break;
            case 2:
            {
                self.pwdTf = textField;
//                textField.secureTextEntry = YES;
            }
                break;
            case 3:
            {
                self.rePwdTf = textField;
                UIButton *codeBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"获取验证码" key:nil] titleColor:kTabbarColor backgroundColor:kClearColor titleFont:13];
                [codeBtn sizeToFit];
                codeBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - codeBtn.width - 30, textField.y + 10, codeBtn.width + 30, 30);
                kViewBorderRadius(codeBtn, 2, 1, kTabbarColor);
                [codeBtn addTarget:self action:@selector(sendCaptcha:) forControlEvents:(UIControlEventTouchUpInside)];
                [self.view addSubview:codeBtn];
                
                textField.frame = CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30 - codeBtn.width - 10, 50);
                
            }
                break;
                
            default:
                break;
        }
        
    }
    UIButton *changePwdBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确定" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16.0 cornerRadius:5];
    changePwdBtn.frame = CGRectMake(15, self.rePwdTf.yy + 66, SCREEN_WIDTH - 30, 48);
    [changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePwdBtn];
}



#pragma mark - Events
- (void)sendCaptcha:(UIButton *)sender {
    
    if ([_titleString isEqualToString:@"修改手机号"]) {
        
        if (sender.tag != 100) {
            if (![self.pwdTf.text isPhoneNum]) {
                [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
                return;
            }
        }
        
        TLNetworking *http = [TLNetworking new];
        
        http.showView = self.view;
        http.code = CAPTCHA_CODE;
        http.parameters[@"client"] = @"ios";
        http.parameters[@"bizType"] = @"805061";
        if (sender.tag == 100) {
            http.parameters[@"mobile"] = self.phoneTf.text;
        }else
        {
            http.parameters[@"mobile"] = self.pwdTf.text;
        }
        
        
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
            [[UserModel user] phoneCode:sender];
            //        [self.captchaView.captchaBtn begin];
            
        } failure:^(NSError *error) {
            
        }];
    }else
    {
        if (sender.tag != 100) {
            if (![self.pwdTf.text isPhoneNum]) {
                [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入邮箱" key:nil]];
                return;
            }
        }
        TLNetworking *http = [TLNetworking new];
        http.showView = self.view;
        http.code = @"630093";
        http.parameters[@"client"] = @"ios";
        if (sender.tag == 100) {
            http.parameters[@"email"] = self.phoneTf.text;
        }else
        {
            http.parameters[@"email"] = self.pwdTf.text;
        }
        http.parameters[@"bizType"] = @"805070";
        
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
            [[UserModel user] phoneCode:sender];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    
    
}
- (void)changePwd {
    
    if ([_titleString isEqualToString:@"修改手机号"]) {
        if ([self.phoneTf.text isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
            return;
        }
        if ([self.codeTf.text  isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
            return;
        }
        if ([self.pwdTf.text isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入新手机号" key:nil]];
            return;
        }
        if ([self.rePwdTf.text isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"输入的新手机号验证码" key:nil]];
            return;
        }
    }else
    {
        if ([self.phoneTf.text isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入邮箱" key:nil]];
            return;
        }
        if ([self.codeTf.text  isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
            return;
        }
        if ([self.pwdTf.text isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入新邮箱" key:nil]];
            return;
        }
        if ([self.rePwdTf.text isBlank]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"输入的新邮箱验证码" key:nil]];
            return;
        }
    }
    
    
    [self.view endEditing:YES];
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    
    if ([_titleString isEqualToString:@"修改手机号"]) {
        http.code = @"805061";
        http.parameters[@"oldMobile"] = self.phoneTf.text;
        http.parameters[@"oldSmsCaptcha"] = self.codeTf.text;
        http.parameters[@"newMobile"] = self.pwdTf.text;
        http.parameters[@"newSmsCaptcha"] = self.rePwdTf.text;
    }else
    {
        http.code = @"805070";
        http.parameters[@"oldEmail"] = self.phoneTf.text;
        http.parameters[@"oldSmsCaptcha"] = self.codeTf.text;
        http.parameters[@"newEmail"] = self.pwdTf.text;
        http.parameters[@"newSmsCaptcha"] = self.rePwdTf.text;
    }
    
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"kind"] = APP_KIND;
    [http postWithSuccess:^(id responseObject) {
        
        [self requesUserInfoWithResponseObject];
        
       
        
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
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"修改成功" key:nil]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {
        
    }];
}

@end
