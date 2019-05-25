//
//  BindingEmailVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/8.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BindingEmailVC.h"

@interface BindingEmailVC ()
@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;



@end

@implementation BindingEmailVC






- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText.text = [LangSwitcher switchLang:self.titleStr key:nil];
    self.navigationItem.titleView = self.titleText;

    [self initSubviews];
}


- (void)initSubviews {
    
    
    
    NSArray *array = @[@"请输入邮箱",@"请输入验证码"];
    if ([self.titleStr isEqualToString:@"绑定邮箱"]) {
        array = @[@"请输入邮箱",@"请输入验证码"];
    }else
    {
        array = @[@"请输入手机号",@"请输入验证码"];
    }
    for (int i = 0 ; i < 2; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 20 + i% 2 * 60, SCREEN_WIDTH - 30, 50)];
        textField.placeholder = [LangSwitcher switchLang:array[i] key:nil];
        [textField setValue:FONT(16) forKeyPath:@"_placeholderLabel.font"];
        textField.font = FONT(16);
        textField.textColor = kHexColor([TLUser TextFieldTextColor]);
        [textField setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
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
                textField.keyboardType = UIKeyboardTypeNumberPad;
                
            }
                break;
            
                
            default:
                break;
        }
        
    }
    UIButton *changePwdBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确定" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16.0 cornerRadius:5];
    changePwdBtn.frame = CGRectMake(15, self.codeTf.yy + 66, SCREEN_WIDTH - 30, 48);
    [changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePwdBtn];
}



#pragma mark - Events
- (void)sendCaptcha:(UIButton *)sender {
    
    
    if ([self.titleStr isEqualToString:@"绑定邮箱"]) {
        if (![self.phoneTf.text isPhoneNum]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入邮箱" key:nil]];
            return;
        }
        TLNetworking *http = [TLNetworking new];
        http.showView = self.view;
        http.code = @"630093";
        http.parameters[@"client"] = @"ios";
        http.parameters[@"email"] = self.phoneTf.text;
        http.parameters[@"bizType"] = @"805086";
        
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
            [[UserModel user] phoneCode:sender];
            //        [self.captchaView.captchaBtn begin];
            
        } failure:^(NSError *error) {
            
        }];
    }else
    {
        if (![self.phoneTf.text isPhoneNum]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
            return;
        }
        
        TLNetworking *http = [TLNetworking new];
        http.showView = self.view;
        http.code = CAPTCHA_CODE;
        http.parameters[@"mobile"] = self.phoneTf.text;
        http.parameters[@"bizType"] = @"805060";
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
            [[UserModel user] phoneCode:sender];
            //        [self.captchaView.captchaBtn begin];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    
    
}
- (void)changePwd {
    
    if ([self.phoneTf.text isBlank]) {
        if ([self.titleStr isEqualToString:@"绑定邮箱"]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入邮箱" key:nil]];
            return;
        }else
        {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
            return;
        }
        
    }
    if ([self.codeTf.text  isBlank]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        return;
    }
    
    
    [self.view endEditing:YES];
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    if ([self.titleStr isEqualToString:@"绑定邮箱"]) {
        http.code = @"805086";
        http.parameters[@"email"] = self.phoneTf.text;
        http.parameters[@"captcha"] = self.codeTf.text;
    }else
    {
        http.code = @"805060";
        http.parameters[@"mobile"] = self.phoneTf.text;
        http.parameters[@"isSendSms"] = @"1";
        http.parameters[@"smsCaptcha"] = self.codeTf.text;
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
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"绑定成功" key:nil]];
        [[TLUser user] updateUserInfo];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {
        
    }];
}

@end
