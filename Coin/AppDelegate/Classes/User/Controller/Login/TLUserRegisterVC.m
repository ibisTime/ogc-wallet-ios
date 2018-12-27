//
//  TLUserRegisterVC.m
//  YS_iOS
//
//  Created by 蔡卓越 on 2017/6/8.
//  Copyright © 2017年 cuilukai. All rights reserved.
//

#import "TLUserRegisterVC.h"
//#import "SGScanningQRCodeVC.h"
#import <MSAuthSDK/MSAuthVCFactory.h>
#import <Photos/Photos.h>
#import "TLNavigationController.h"
#import "HTMLStrVC.h"
#import "UIBarButtonItem+convience.h"
#import <CoreLocation/CoreLocation.h>

#import "CaptchaView.h"
#import "APICodeMacro.h"
#import "NSString+Check.h"
#import "ChooseCountryVc.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"

#import <UMMobClick/MobClick.h>

#import "TLTabBarController.h"
#import <SecurityGuardSDK/JAQ/SecurityVerification.h>
#import <MSAuthSDK/MSAuthVCFactory.h>
#import <MSAuthSDK/MSAuthSDK.h>
#import <SecurityGuardSDK/JAQ/SecurityVerification.h>


@interface TLUserRegisterVC ()<CLLocationManagerDelegate,MSAuthProtocol>

@property (nonatomic,strong) CaptchaView *captchaView;
//昵称
@property (nonatomic, strong) TLTextField *nickNameTF;
@property (nonatomic, strong) TLTextField *referTF;


@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UITextField *pwdTf;
@property (nonatomic,strong) UITextField *rePwdTf;


//@property (nonatomic,strong) CLLocationManager *sysLocationManager;
//
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;
//同意按钮
//@property (nonatomic, strong) UIButton *checkBtn;

//@property (nonatomic, strong) UIScrollView *contentScrollView;
//
//@property (nonatomic ,strong) UILabel *titlePhpne;
//@property (nonatomic ,strong) UILabel *PhoneCode;
@property (nonatomic ,strong) UIImageView *accessoryImageView;
@property (nonatomic ,strong) UIImageView *pic;
@property (nonatomic,strong) NSMutableArray <CountryModel *>*countrys;

@end

@implementation TLUserRegisterVC
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    [self navigationTransparentClearColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//}
//
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    //取消按钮
//    [UIBarButtonItem addLeftItemWithImageName:kCancelIcon frame:CGRectMake(-20, 0, 40, 60) vc:self action:@selector(back)];
//    self.navigationController.navigationBar.hidden = NO;
//    self.title = [LangSwitcher switchLang:@"注册" key:nil];
    self.view.backgroundColor = kWhiteColor;
    [self setUpUI];
//    [self loadData];


}




//- (void)configData{
//
//    BOOL isChoose =  [[NSUserDefaults standardUserDefaults] boolForKey:@"chooseCoutry"];
//
//    if (isChoose == YES) {
//
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
//        CountryModel *model = self.countrys[0];
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"chooseModel"];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"chooseCoutry"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSString *url = [model.pic convertImageUrl];
//
//        [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//        self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[model.interCode substringFromIndex:2]];
//
//
//
//    }
//}

//- (void)back {
//    [self.view endEditing:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
//}


#pragma mark - Events

- (void)setUpUI {
    

    
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(25, 45 , SCREEN_WIDTH - 50, 24) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(24) textColor:kTextColor];
    nameLabel.text= [LangSwitcher switchLang:@"注册" key:nil];
    [self.view addSubview:nameLabel];
    
    
    UIButton *phoneRegister = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"手机注册" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:18];
    phoneRegister.frame = CGRectMake(25, nameLabel.yy + 35, 0, 18);
    [phoneRegister sizeToFit];
    [self.view addSubview:phoneRegister];
    
    
    UIButton *emailRegister = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"邮箱注册" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:18];
    emailRegister.frame = CGRectMake(phoneRegister.xx + 35, nameLabel.yy + 35, 0, 18);
    [emailRegister sizeToFit];
    [self.view addSubview:emailRegister];
    
    
    NSArray *array = @[@"请输入手机号",@"请输入验证码",@"请输入密码",@"请输入密码"];
    
    for (int i = 0 ; i < 4; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(30, emailRegister.yy + 40 + i% 4 * 60, SCREEN_WIDTH - 60, 50)];
        textField.placeholder = [LangSwitcher switchLang:array[i] key:nil];
        [textField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        textField.font = FONT(14);
//        self.pwdTf = textField;
        [self.view addSubview:textField];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, textField.yy, SCREEN_WIDTH - 60, 1)];
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
                
                textField.frame = CGRectMake(30, emailRegister.yy + 40 + i% 4 * 60, SCREEN_WIDTH - 60 - codeBtn.width - 5 , 50);
                
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
    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(15, self.rePwdTf.yy + 15, SCREEN_WIDTH, 20)];
    [self.view addSubview:footView];
    
    UIButton *gardenBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    [gardenBtn setImage:kImage(@"Combined Shape2") forState:(UIControlStateNormal)];
    [gardenBtn setImage:kImage(@"Oval Copy2") forState:(UIControlStateSelected)];
    gardenBtn.frame = CGRectMake(15, 0, 20, 20);
    [gardenBtn addTarget:self action:@selector(gardenBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    gardenBtn.tag = 504;
    gardenBtn.selected = YES;
    [footView addSubview:gardenBtn];
    
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 50, 20)];
    titleLbl.font = FONT(12);
    titleLbl.textColor = kHexColor(@"#999999");
    NSString *str1 = [LangSwitcher switchLang:@"我已阅读并接受" key:nil];
    NSString *str2 = [LangSwitcher switchLang:@"《橙Wallet注册协议》" key:nil];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    [attriStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(str1.length, str2.length)];
    titleLbl.attributedText = attriStr;
    [footView addSubview:titleLbl];
    
    
    UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    titleBtn.frame = titleLbl.frame;
    [footView addSubview:titleBtn];
    titleBtn.tag = 503;
    [titleBtn addTarget:self action:@selector(addAndreductionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *regBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"注册" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:17.0 cornerRadius:5];
    regBtn.frame = CGRectMake(25, footView.yy + 32, SCREEN_WIDTH - 50, 45);
    [regBtn addTarget:self action:@selector(goReg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    
    

}

-(void)gardenBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

-(void)addAndreductionButton:(UIButton *)sender
{
    
}

- (void)next
{
    [self.pwdTf resignFirstResponder];
    [self.rePwdTf becomeFirstResponder];
    
}
- (void)next1
{
    [self.rePwdTf resignFirstResponder];
    [self goReg];
}

//- (void)chooseCountry{
//
//    //选择国家 设置区号
//    CoinWeakSelf;
//    ChooseCountryVc *countryVc = [ChooseCountryVc new];
////     countryVc.interCode = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
//    countryVc.selectCountry = ^(CountryModel *model) {
//        //更新国家 区号
//        [self.pic sd_setImageWithURL:[NSURL URLWithString:[model.pic convertImageUrl]]];
//
//        weakSelf.titlePhpne.text = model.chineseName;
//        weakSelf.PhoneCode.text = [NSString stringWithFormat:@"+%@",[model.interCode substringFromIndex:2]];
//    } ;
//    [self presentViewController:countryVc animated:YES completion:nil];
//}


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
    http.parameters[@"bizType"] = USER_REG_CODE;
    http.parameters[@"mobile"] = self.phoneTf.text;
//    http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
        
//        [self.captchaView.captchaBtn begin];
        
        
        [[UserModel user] phoneCode:sender];
        
        
        
    } failure:^(NSError *error) {
        
        [TLAlert alertWithError:[LangSwitcher switchLang:@"发送失败,请检查手机号" key:nil]];
        
    }];
    
    
//    LangType type = [LangSwitcher currentLangType];
//    NSString *lang;
//    if (type == LangTypeSimple || type == LangTypeTraditional) {
//        lang = @"zh_CN";
//    }else if (type == LangTypeKorean)
//    {
//        lang = @"nil";
//
//
//    }else{
//        lang = @"en";
//
//    }
//    UIViewController *vc = [MSAuthVCFactory simapleVerifyWithType:(MSAuthTypeSlide) language:lang Delegate:self authCode:@"0335" appKey:nil];
//    [self.navigationController pushViewController:vc animated:YES];

}

-(void)verifyDidFinishedWithResult:(t_verify_reuslt)code Error:(NSError *)error SessionId:(NSString *)sessionId
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            NSLog(@"验证失败 %@", error);
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证失败" key:nil]];
        } else {
            NSLog(@"验证通过 %@", sessionId);
            TLNetworking *http = [TLNetworking new];
            http.showView = self.view;
            http.code = CAPTCHA_CODE;
            http.parameters[@"client"] = @"ios";
            http.parameters[@"sessionId"] = sessionId;
            http.parameters[@"bizType"] = USER_REG_CODE;
            http.parameters[@"mobile"] = self.phoneTf.text;
//            http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
            http.parameters[@"sessionId"] = sessionId;
            
            [http postWithSuccess:^(id responseObject) {
                
                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
                
                [self.captchaView.captchaBtn begin];
                
            } failure:^(NSError *error) {
                
                [TLAlert alertWithError:[LangSwitcher switchLang:@"发送失败,请检查手机号" key:nil]];
                
            }];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        //将sessionid传到经过app服务器做二次验证
    });
}

//- (void)verifyDidFinishedWithError:(NSError *)error SessionId:(NSString *)sessionId {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (error) {
//            NSLog(@"验证失败 %@", error);
//        } else {
//            NSLog(@"验证通过 %@", sessionId);
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//        //将sessionid传到经过app服务器做二次验证
//    });
//}

//- (void)loadData{
//    TLNetworking *net = [TLNetworking new];
//    net.showView = self.view;
//    net.code = @"801120";
//    net.isLocal = YES;
//    net.ISparametArray = YES;
//    net.parameters[@"status"] = @"1";
//    [net postWithSuccess:^(id responseObject) {
//
//        NSLog(@"%@",responseObject);
//
//        self.countrys = [CountryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//
//        for (int i = 0; i < self.countrys.count; i++) {
//
//            CountryModel *model = self.countrys[i];
//            NSString *code =[TLUser user].interCode;
//            if (code == model.interCode) {
//                NSString *url = [model.pic convertImageUrl];
//                [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
//                self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[model.interCode substringFromIndex:2]];
//            }
//        }
//
//        [self configData];
//
//    } failure:^(NSError *error) {
//
//        [self configData];
//
//    }];
//
//
//
//}
- (void)goReg {
    
//    if (![self.nickNameTF.text valid]) {
//
//        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请设置你的昵称" key:nil]];
//
//        return ;
//    }
    
    if (![self.phoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        
        return;
    }
    
    if (!self.codeTf.text) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        
        return;
    }
    
    if ((!self.pwdTf.text )) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入密码" key:nil]];
        return;
    }
    
    if (![self.pwdTf.text isEqualToString:self.rePwdTf.text]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"输入的密码不一致" key:nil]];
        return;
        
    }
    
//    if (!self.checkBtn.selected) {
//
//        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请同意《注册协议》" key:nil]];
//        return ;
//    }

    [self.view endEditing:YES];

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_REG_CODE;
    http.parameters[@"mobile"] = self.phoneTf.text;
//    NSData *data   =  [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseModel"];
//    CountryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    if ([model.code isNotBlank]) {
//        http.parameters[@"countryCode"] = model.code;
//    }else{
//        http.parameters[@"countryCode"] = self.countrys[0].code;
//
//        }
    

    http.parameters[@"loginPwd"] = self.pwdTf.text;
//    http.parameters[@"isRegHx"] = @"0";
    http.parameters[@"smsCaptcha"] = self.codeTf.text;
    http.parameters[@"kind"] = APP_KIND;
    http.parameters[@"client"] = @"ios";

//    if ([self.referTF.text valid]) {
//
//        http.parameters[@"userReferee"] = self.referTF.text;
//        http.parameters[@"userRefereeKind"] = APP_KIND;
//
//    }
    
    [http postWithSuccess:^(id responseObject) {
        
        [self.view endEditing:YES];
        
        NSString *token = responseObject[@"data"][@"token"];
        NSString *userId = responseObject[@"data"][@"userId"];
        [MobClick profileSignInWithPUID:userId];
        //保存用户账号和密码
//        [[TLUser user] saveUserName:self.phoneTf.text pwd:self.pwdTf.text];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            //获取用户信息
            TLNetworking *http = [TLNetworking new];
            http.showView = self.view;
            http.code = USER_INFO;
            http.parameters[@"userId"] = userId;
            http.parameters[@"token"] = token;
            [http postWithSuccess:^(id responseObject) {
                
                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"注册成功" key:nil]];
                NSDictionary *userInfo = responseObject[@"data"];
                [TLUser user].userId = userId;
                [TLUser user].token = token;
                
                //保存信息
                [[TLUser user] saveUserInfo:userInfo];
                [[TLUser user] setUserInfoWithDict:userInfo];
                
                TLTabBarController *ta = [[TLTabBarController alloc] init];
                
                [UIApplication sharedApplication].keyWindow.rootViewController = ta;
                //dismiss 掉
//                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                

            } failure:^(NSError *error) {
                
            }];
            
//        });
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)clickSelect:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}

- (void)readProtocal {
    
    HTMLStrVC *htmlVC = [[HTMLStrVC alloc] init];
    
    htmlVC.type = HTMLTypeRegProtocol;
    
    [self.navigationController pushViewController:htmlVC animated:YES];
    
}
@end
