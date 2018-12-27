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
#import "ChooseCountryVc.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extension.h"
#import "CountryModel.h"
@interface TLUserForgetPwdVC ()<MSAuthProtocol>

@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UITextField *pwdTf;
@property (nonatomic,strong) UITextField *rePwdTf;


//@property (nonatomic, strong) CaptchaView *captchaView;
//@property (nonatomic ,strong) UILabel *titlePhpne;
//@property (nonatomic ,strong) UILabel *PhoneCode;
//@property (nonatomic ,strong) UIImageView *accessoryImageView;
//@property (nonatomic ,strong) UIImageView *pic;

@property (nonatomic,strong) NSMutableArray <CountryModel *>*countrys;

@end

@implementation TLUserForgetPwdVC
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([TLUser user].loginPwdFlag == 1) {
//        self.title = [LangSwitcher switchLang:@"修改登录密码" key:nil];
//
//    }else{
//        self.title = [LangSwitcher switchLang:@"设置登录密码" key:nil];
//
//    }
    self.titleText.text = [LangSwitcher switchLang:@"修改登录密码" key:nil];
    self.navigationItem.titleView = self.titleText;
    self.view.backgroundColor = kWhiteColor;
    
    [self initSubviews];
//    [self loadData];
//    [self configData];
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

//- (void)loadData{
//    
//    
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
////        [self.tableView reloadData];
//        //        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"data"]];
//        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"RealNameAuthResult" object:str];
//        
//    } failure:^(NSError *error) {
//        
//        
//    }];
//    
//    
//    
//}

- (void)initSubviews {
    
    
    
//    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 45 , SCREEN_WIDTH - 30, 24) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(24) textColor:kTextColor];
//    nameLabel.text= [LangSwitcher switchLang:@"注册" key:nil];
//    [self.view addSubview:nameLabel];
    
    
//    UIButton *phoneRegister = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"手机注册" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:18];
//    phoneRegister.frame = CGRectMake(25, nameLabel.yy + 35, 0, 18);
//    [phoneRegister sizeToFit];
//    [self.view addSubview:phoneRegister];
//
//
//    UIButton *emailRegister = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"邮箱注册" key:nil] titleColor:kTextColor backgroundColor:kClearColor titleFont:18];
//    emailRegister.frame = CGRectMake(phoneRegister.xx + 35, nameLabel.yy + 35, 0, 18);
//    [emailRegister sizeToFit];
//    [self.view addSubview:emailRegister];
    
    
    NSArray *array = @[@"请输入手机号",@"请输入验证码",@"请输入密码",@"请输入密码"];
    
    for (int i = 0 ; i < 4; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 45 + i% 4 * 60, SCREEN_WIDTH - 30, 50)];
        textField.placeholder = [LangSwitcher switchLang:array[i] key:nil];
        [textField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        textField.font = FONT(14);
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
                
                textField.frame = CGRectMake(15, 45 + i% 4 * 60, SCREEN_WIDTH - 30, 50);
                
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
    
    
    
    
    
    
    UIButton *changePwdBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确 定" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:17.0 cornerRadius:5];
    changePwdBtn.frame = CGRectMake(25, self.rePwdTf.yy + 60, SCREEN_WIDTH - 50, 45);
    [changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePwdBtn];
    
    
    
}


//- (void)chooseCountry
//{
//
//    //选择国家 设置区号
//    CoinWeakSelf;
//    ChooseCountryVc *countryVc = [ChooseCountryVc new];
//    countryVc.selectCountry = ^(CountryModel *model) {
//        //更新国家 区号
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
    http.parameters[@"bizType"] = USER_FIND_PWD_CODE;
    http.parameters[@"mobile"] = self.phoneTf.text;
//    http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
        [[UserModel user] phoneCode:sender];
//        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
        
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

//-(void)verifyDidFinishedWithResult:(t_verify_reuslt)code Error:(NSError *)error SessionId:(NSString *)sessionId{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (error) {
//            NSLog(@"验证失败 %@", error);
//            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证失败" key:nil]];
//        } else {
//
//
//
//            TLNetworking *http = [TLNetworking new];
//            http.showView = self.view;
//            http.code = CAPTCHA_CODE;
//            http.parameters[@"client"] = @"ios";
//            http.parameters[@"sessionId"] = sessionId;
//            http.parameters[@"bizType"] = USER_FIND_PWD_CODE;
//            http.parameters[@"mobile"] = self.phoneTf.text;
//            http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
//
//            [http postWithSuccess:^(id responseObject) {
//
//                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];
//
//                [self.captchaView.captchaBtn begin];
//
//            } failure:^(NSError *error) {
//
//
//            }];
//
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//        //将sessionid传到经过app服务器做二次验证
//    });
//}

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
    http.code = USER_FIND_PWD_CODE;
    http.parameters[@"mobile"] = self.phoneTf.text;
    http.parameters[@"smsCaptcha"] = self.codeTf.text;
    http.parameters[@"newLoginPwd"] = self.pwdTf.text;
    http.parameters[@"kind"] = APP_KIND;
//    http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
//    NSData *data   =  [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseModel"];
//    CountryModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    if ([model.code isNotBlank]) {
//        http.parameters[@"countryCode"] = model.code;
//    }else{
//
//        http.parameters[@"countryCode"] = self.countrys[0].code;
//
//    }
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"修改成功" key:nil]];
        [[TLUser user] updateUserInfo];
        
        //保存用户账号和密码
//        [[TLUser user] saveUserName:self.phoneTf.text pwd:self.pwdTf.text];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {

    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
