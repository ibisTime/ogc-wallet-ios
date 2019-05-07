//
//  BindMobileVC.m
//  CityBBS
//
//  Created by 蔡卓越 on 2017/5/24.
//  Copyright © 2017年  caizhuoyue. All rights reserved.
//

#import "BindMobileVC.h"
#import "TLCaptchaView.h"

#import "APICodeMacro.h"
#import "NSString+Check.h"

@interface BindMobileVC ()<MSAuthProtocol>

@property (nonatomic,strong) TLTextField *phoneTf;
@property (nonatomic,strong) TLCaptchaView *captchaView;

@end

@implementation BindMobileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"绑定手机号" key:nil];
    
    [self initSubviews];
}

- (void)initSubviews {

    CGFloat leftW = 90;

    CGFloat leftMargin = 10;
    
    //手机号
    TLTextField *phoneTf = [[TLTextField alloc] initWithFrame:CGRectMake(leftMargin, 20, kScreenWidth - 2*leftMargin, 45)
                                                    leftTitle:[LangSwitcher switchLang:@"手机号" key:nil]
                                                   titleWidth:leftW
                                                  placeholder:[LangSwitcher switchLang:@"请输入手机号" key:nil]];
    phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:phoneTf];
    self.phoneTf = phoneTf;
    
    //验证码
    TLCaptchaView *captchaView = [[TLCaptchaView alloc] initWithFrame:CGRectMake(phoneTf.x, phoneTf.yy + 1, phoneTf.width, phoneTf.height)];
    [self.view addSubview:captchaView];
    self.captchaView = captchaView;
    [captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    
    //确认按钮
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"绑定" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:14.0];
    
    confirmBtn.frame = CGRectMake(20, captchaView.yy + 30, kScreenWidth - 40, 44);
    
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setTrade:(UIButton *)btn {
    
    TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
    vc.titleString = @"修改交易密码";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)sendCaptcha {
    
    if (![self.phoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        
        return;
    }
    

    
    LangType type = [LangSwitcher currentLangType];
    NSString *lang;
    if (type == LangTypeSimple || type == LangTypeTraditional) {
        lang = @"zh_CN";
    }else if (type == LangTypeKorean)
    {
        lang = @"nil";


    }else{
        lang = @"en";

    }
    UIViewController *vc = [MSAuthVCFactory simapleVerifyWithType:(MSAuthTypeSlide) language:lang Delegate:self authCode:@"0335" appKey:nil];
    [self.navigationController pushViewController:vc animated:YES];

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
            http.parameters[@"bizType"] = @"805151";
            http.parameters[@"mobile"] = self.phoneTf.text;
            http.parameters[@"client"] = @"ios";
            http.parameters[@"sessionId"] = sessionId;
            [http postWithSuccess:^(id responseObject) {

                [TLAlert alertWithSucces:[LangSwitcher switchLang:@"验证码已发送,请注意查收" key:nil]];

                [self.captchaView.captchaBtn begin];

            } failure:^(NSError *error) {

            }];


        }
        [self.navigationController popViewControllerAnimated:YES];
        //将sessionid传到经过app服务器做二次验证
    });
}


- (void)confirm {
    
    if (![self.phoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的手机号" key:nil]];
        return;
    }
    
    if (![self.captchaView.captchaTf.text valid] ) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的验证码" key:nil]];
        return;
    }
    
    _bindMobileBlock(self.phoneTf.text, self.captchaView.captchaTf.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
