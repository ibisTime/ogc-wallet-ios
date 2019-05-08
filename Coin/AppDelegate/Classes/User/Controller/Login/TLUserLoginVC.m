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

//@property (nonatomic,strong) NSMutableArray <CountryModel *>*countrys;

@property (nonatomic, copy) NSString *code;

//@property (nonatomic, strong) CountryModel *model;


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

    
    
    
    
    
//    [self.view theme_setBackgroundColorIdentifier:TableViewColor moduleName:@"homepage"];
    
    
//    [self loadData];

//    [self changeCodeLogin];
}



//- (void)configData{
//    NSString *money ;
//    //获取缓存的国家
//    NSData *data   =  [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseModel"];
//    //有缓存加载缓存国家
//    if (data) {
//        CountryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//
//        //如果国家编号不为空，说明是1.7.0之后缓存的，直接设置即可
//        if ([model.code isNotBlank]) {
//
//            NSString *url = [model.pic convertImageUrl];
//
//            [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//
//            self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[model.interCode substringFromIndex:2]];
//
//        }
//        //如果国家编号为空，说明是1.7.0之前缓存的，需要移除
//        else {
//
//            CountryModel *defaultCountry = [self.countrys objectAtIndex:0];
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:defaultCountry];
//            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"chooseModel"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            NSString *url = [defaultCountry.pic convertImageUrl];
//            [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//            self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[defaultCountry.interCode substringFromIndex:2]];
//            if ([defaultCountry.interSimpleCode isEqualToString:@"CN"] ||[defaultCountry.interSimpleCode isEqualToString:@"HK"] ||[model.interSimpleCode isEqualToString:@"TW"] || [defaultCountry.interSimpleCode isEqualToString:@"MO"]) {
//                [LangSwitcher changLangType:LangTypeSimple];
//                money = @"CNY";
//            }else if ([defaultCountry.interSimpleCode isEqualToString:@"KR"] || [defaultCountry.interSimpleCode isEqualToString:@"KO"] )
//            {
//                [LangSwitcher changLangType:LangTypeKorean];
//                money = @"KRW";
//            }else{
//
//                [LangSwitcher changLangType:LangTypeEnglish];
//                money = @"USD";
//
//            }
//        }
//
//    }
//    //没有缓存加载网络请求国家中的中国
//    else {
//
//        CountryModel *defaultCountry = [self.countrys objectAtIndex:0];
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:defaultCountry];
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"chooseModel"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//        NSString *url = [defaultCountry.pic convertImageUrl];
//        [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//        self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[defaultCountry.interCode substringFromIndex:2]];
//        if ([defaultCountry.interSimpleCode isEqualToString:@"CN"] ||[defaultCountry.interSimpleCode isEqualToString:@"HK"] ||[defaultCountry.interSimpleCode isEqualToString:@"TW"] || [defaultCountry.interSimpleCode isEqualToString:@"MO"]) {
//            [LangSwitcher changLangType:LangTypeSimple];
//            money = @"CNY";
//        }else if ([defaultCountry.interSimpleCode isEqualToString:@"KR"] || [defaultCountry.interSimpleCode isEqualToString:@"KO"] )
//        {
//            [LangSwitcher changLangType:LangTypeKorean];
//            money = @"KRW";
//        }else{
//            [LangSwitcher changLangType:LangTypeEnglish];
//            money = @"USD";
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:money forKey:KLocalMoney];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

//- (void)configData_bak{
//
//    BOOL isChoose =  [[NSUserDefaults standardUserDefaults] boolForKey:@"chooseCoutry"];
//
//    if (isChoose == YES) {
//
//        NSData *data   =  [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseModel"];
//        CountryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        if ([model.code isNotBlank]) {
//            NSString *url = [model.pic convertImageUrl];
//
//            [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//            self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[model.interCode substringFromIndex:2]];
//        }else {
//            for (CountryModel *country in self.countrys) {
//                if ([country.interCode isEqualToString:model.interCode]) {
//                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:country];
//                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"chooseModel"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    NSString *url = [country.pic convertImageUrl];
//
//                    [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//                    self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[country.interCode substringFromIndex:2]];
//                }
//            }
//        }
//
//    }else{
//
//            CountryModel *model = self.countrys[0];
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"chooseModel"];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"chooseCoutry"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            NSString *url = [model.pic convertImageUrl];
//
//            [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//            self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[model.interCode substringFromIndex:2]];
//
//
//
//    }
//}



- (void)setUpUI {
    
    
//    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 60,  kStatusBarHeight + 25, 120, 60)];
//    logoView.contentMode = UIViewContentModeScaleToFill;
//    [self.view addSubview:logoView];
//    logoView.image = kImage(@"邀请-logo");
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 170 - 64 + kNavigationBarHeight - 35, SCREEN_WIDTH - 30, 360)];
    backView.backgroundColor = kWhiteColor;
    backView.layer.cornerRadius=10;
    backView.layer.shadowOpacity = 0.22;// 阴影透明度
    backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    backView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self.view addSubview:backView];
    
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, SCREEN_WIDTH - 30 - 70, 35)];
    promptLabel.textColor = kTextColor;
    promptLabel.font = HGboldfont(27);
//    UILabel *promptLabel = [UILabel labelWithFrame:CGRectMake(20, 45, SCREEN_WIDTH - 30 - 70, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(27) textColor:kTextColor];
    promptLabel.text = [LangSwitcher switchLang:@"欢迎回来" key:nil];
    [backView addSubview:promptLabel];
    
    UITextField *phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 70, 50)];
    phoneTextField.placeholder = [LangSwitcher switchLang:@"请输入账号" key:nil];
    [phoneTextField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    phoneTextField.font = FONT(14);
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTf = phoneTextField;

    [backView addSubview:phoneTextField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH - 70, 1)];
    lineView.backgroundColor = kLineColor;
    [backView addSubview:lineView];
    
    
    UITextField *passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 160, SCREEN_WIDTH - 70, 50)];
    passWordTextField.placeholder = [LangSwitcher switchLang:@"请输入密码（6~16个字符或字母组成）" key:nil];
    [passWordTextField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
    passWordTextField.font = FONT(14);
    self.pwdTf = passWordTextField;
    [backView addSubview:passWordTextField];
    passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordTextField.secureTextEntry = YES;
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH - 70, 1)];
    lineView1.backgroundColor = kLineColor;
    [backView addSubview:lineView1];
    
    
    UIButton *loginBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"登录" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:17.0 cornerRadius:5];
    loginBtn.frame = CGRectMake(15, passWordTextField.yy + 35, SCREEN_WIDTH - 60, 45);
    [loginBtn addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:loginBtn];
    
    
    UIButton *registeredBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"立即注册" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:14.0];
    registeredBtn.frame = CGRectMake(20, loginBtn.yy + 20, (SCREEN_WIDTH - 80)/2, 20);
    registeredBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registeredBtn addTarget:self action:@selector(goReg:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:registeredBtn];
    
    
    
    UIButton *forgetPwdBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"忘记密码" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:14.0];
    forgetPwdBtn.frame = CGRectMake(registeredBtn.xx, loginBtn.yy + 20, (SCREEN_WIDTH - 80)/2, 20);
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:forgetPwdBtn];
}

//HTMLTypeRegProtocol

-(void)forgetPwdBtnClick:(UIButton *)btn
{
//    NSString *path = [NSBundle mainBundle].bundlePath;
//    path = [path stringByAppendingPathComponent:@"Theme"];
//    path = [path stringByAppendingPathComponent:@"Theme/Theme1"];
//    [MTThemeManager.manager setThemePath:path];
    TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
    vc.titleString = @"修改登录密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goReg:(UIButton *)btn {
//    NSString *path = [NSBundle mainBundle].bundlePath;
//    path = [path stringByAppendingPathComponent:@"Theme"];
//    path = [path stringByAppendingPathComponent:@"Theme/Theme2"];
//    [MTThemeManager.manager setThemePath:path];
    TLUserRegisterVC *registerVC = [[TLUserRegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

//- (void)sendCaptcha
//{
//    if (![self.phoneTf.text isPhoneNum]) {
//        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
//        return;
//    }
//    LangType type = [LangSwitcher currentLangType];
//    NSString *lang;
//    if (type == LangTypeSimple || type == LangTypeTraditional) {
//        lang = @"zh_CN";
//    }
//    else if (type == LangTypeKorean)
//    {
//        lang = @"ko";
//    }
//    else
//    {
//        lang = @"en";
//    }
//    UIViewController *vc = [MSAuthVCFactory simapleVerifyWithType:(MSAuthTypeSlide) language:lang Delegate:self authCode:@"0335" appKey:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//
//-(void)registeredBtn
//{
//    
//}
//
//-(void)verifyDidFinishedWithResult:(t_verify_reuslt)code Error:(NSError *)error SessionId:(NSString *)sessionId
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (error) {
//            NSLog(@"验证失败 %@", error);
//            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证失败" key:nil]];
//        } else {
//            NSLog(@"验证通过 %@", sessionId);
//            //发送验证码
////            [SVProgressHUD show];
//            TLNetworking *http = [TLNetworking new];
//            http.showView = self.view;
//            http.code = CAPTCHA_CODE;
//            http.parameters[@"client"] = @"ios";
//            http.parameters[@"sessionId"] = sessionId;
//            http.parameters[@"bizType"] = @"805044";
//            http.parameters[@"mobile"] = self.phoneTf.text;
//            http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];;
//            http.parameters[@"sessionId"] = sessionId;
//
//            [http postWithSuccess:^(id responseObject) {
//
//                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
//
//                [self.captchaView.captchaBtn begin];
////                MBProgressHUD hi
////                [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//            } failure:^(NSError *error) {
//
////                [MBProgressHUD hideHUDForView:self.view animated:YES];
//            }];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//        //将sessionid传到经过app服务器做二次验证
//    });
//}




//- (void)changeCodeLogin
//{
//    self.forgetPwdBtn.selected = !self.forgetPwdBtn.selected;
//
//    self.forgetLab.hidden = !self.forgetLab.hidden;
//    self.codeButton.hidden = !self.codeButton.hidden;
//    self.pwdTf.hidden = !self.pwdTf.hidden;
//    self.captchaView.hidden = !self.captchaView.hidden;
//}

//- (void)setUpNotification {
//
//    //登录成功之后，给予回调
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:kUserLoginNotification object:nil];
//
//}

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

//登录成功
//- (void)login {
//
//
//    // apple delegate
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//    if (self.loginSuccess) {
//
//        self.loginSuccess();
//    }
//
//}



- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self goLogin];
    
    return YES;
    
}


- (void)findPwd {
    
//    TLUserFindPwdVC *vc = [[TLUserFindPwdVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
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
//    if (!self.PhoneCode.text) {
//        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请选择国家" key:nil]];
//
//        return;
//    }
    
//    if ([self.captchaView.captchaTf.text isBlank] &&self.captchaView.hidden == NO) {
//
//        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入验证码" key:nil]];
//        return;
//    }
//    [self.view endEditing:YES];

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
//    if (self.captchaView.hidden == NO) {
//        //验证码登录
//        http.code = @"805044";
//
//    http.parameters[@"mobile"] = self.phoneTf.text;
//    NSData *data   =  [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseModel"];
//    CountryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        if ([model.code isNotBlank]) {
//            http.parameters[@"countryCode"] = model.code;
//
//        }else{
//
//            http.parameters[@"countryCode"] =  self.countrys[0].code;
//
//        }
//
//    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
//
//
//    }else{
    
//        NSData *data   =  [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseModel"];
//        CountryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//
//        http.code = USER_LOGIN_CODE;
//        if ([model.code isNotBlank]) {
//
//                http.parameters[@"countryCode"] = model.code;
//            }else {
//                http.parameters[@"countryCode"] =  self.countrys[0].code;
//
//            }
    http.code = USER_LOGIN_CODE;
    http.parameters[@"loginName"] = self.phoneTf.text;
    http.parameters[@"loginPwd"] = self.pwdTf.text;
    http.parameters[@"kind"] = APP_KIND;
//    }
    http.parameters[@"client"] = @"ios";

    
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject[@"data"][@"userId"]);
        [self requesUserInfoWithResponseObject:responseObject];
        [MobClick profileSignInWithPUID:responseObject[@"data"][@"userId"]];
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)requesUserInfoWithResponseObject:(id)responseObject {
    
    NSString *token = responseObject[@"data"][@"token"];
    NSString *userId = responseObject[@"data"][@"userId"];
    
    //保存用户账号和密码
//    [[TLUser user] saveUserName:self.phoneTf.text pwd:self.pwdTf.text];
    
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
        
        TLUpdateVC *tab   = [[TLUpdateVC alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
//        [self.navigationController popToRootViewControllerAnimated:YES];
        
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
