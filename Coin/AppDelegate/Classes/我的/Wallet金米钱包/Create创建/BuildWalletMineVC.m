//
//  BuildWalletMineVC.m
//  Coin
//
//  Created by shaojianfei on 2018/6/8.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "BuildWalletMineVC.h"

#import "WalletImportVC.h"
#import "HTMLStrVC.h"
#import "TLTextField.h"
#import "CaptchaView.h"
#import "BuildSucessVC.h"
#import "NSString+Check.h"
@interface BuildWalletMineVC ()

@property (nonatomic ,strong) UIImageView *iconImage;

@property (nonatomic ,strong) UIImageView *nameLable;

@property (nonatomic ,strong) UIButton *buildButton;

@property (nonatomic ,strong) UIButton *importButton;

@property (nonatomic ,strong) UIButton *introduceButton;
@property (nonatomic ,copy) NSString *h5String;
@property (nonatomic,strong) TLTextField *phoneTf;

@property (nonatomic,strong) TLTextField *pwdTf;

@property (nonatomic,strong) TLTextField *rePwdTf;

@property (nonatomic, strong) CaptchaView *captchaView;

@property (nonatomic,strong) TLTextField *nameTf;

@property (nonatomic,strong) TLTextField *introduceTf;

@property (nonatomic,copy)NSString *isSelect;

@end

@implementation BuildWalletMineVC

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self navigationSetDefault];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationwhiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.title =  [LangSwitcher switchLang:@"创建钱包" key:nil];
    self.titleText.text = [LangSwitcher switchLang:@"创建钱包" key:nil];
    self.titleText.textColor = kWhiteColor;
    self.navigationItem.titleView = self.titleText;
    [self initViews];
    self.navigationController.navigationBar.titleTextAttributes=
  @{NSForegroundColorAttributeName:kWhiteColor
    ,
    NSFontAttributeName:[UIFont systemFontOfSize:16]};

}

- (void)initViews
{
    
    self.view.backgroundColor = kHexColor(@"#ffffff");

    UIView *topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    topView.backgroundColor = kTabbarColor;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);

        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(kHeight(66)));
    }];
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = kWhiteColor;
    [self.view addSubview:whiteView];
   
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top);
        
        make.height.equalTo(@(kHeight(400)));
    }];
    whiteView.layer.cornerRadius = 4;
    whiteView.clipsToBounds = YES;
    
    UILabel *topLable = [UILabel labelWithBackgroundColor:[UIColor colorWithRed:243/255.0 green:244/255.0 blue:247/255.0 alpha:1.0] textColor:kTextColor font:11];
    topLable.numberOfLines = 0;
    topLable.text = [LangSwitcher switchLang:@"注意！金米钱包不存储用户密码，无法提供找回或重置功能，密码必须要自己备份好。密码用于加密保护私钥，强度也非常重要。" key:nil];
    [whiteView addSubview:topLable];
    [topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).offset(15);
        make.right.equalTo(whiteView.mas_right).offset(-15);
        make.top.equalTo(whiteView.mas_top).offset(24);
        make.height.equalTo(@44);

        
    }];
    
    CGFloat margin = 15;
    CGFloat w = kScreenWidth - 2*margin;
    CGFloat h = ACCOUNT_HEIGHT;
    
    CGFloat btnMargin = 15;
    
    
//    UILabel *pwdLab = [UILabel labelWithTitle:[LangSwitcher switchLang:@"密码" key:nil] frame:CGRectMake(20, 90, w, 22)];
//    pwdLab.font = [UIFont systemFontOfSize:14];
//    pwdLab.textAlignment = NSTextAlignmentLeft;
//    pwdLab.textColor = kTextColor;
//    [self.view addSubview:pwdLab];
    
    
    TLTextField *nameTf = [[TLTextField alloc] initWithFrame:CGRectMake(margin, 90 + 10, w, h) leftTitle:[LangSwitcher switchLang:@"" key:nil] titleWidth:20 placeholder:[LangSwitcher switchLang:@"钱包名称" key:nil]];
//    nameTf.secureTextEntry = YES;
    nameTf.returnKeyType = UIReturnKeyNext;
    [nameTf addTarget:self action:@selector(next) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:nameTf];
    self.nameTf = nameTf;
    UIView *phone1 = [[UIView alloc] init];
    [self.view addSubview:phone1];
    phone1.backgroundColor = kLineColor;
    phone1.frame = CGRectMake(margin*2,90+51, w-30, 1);

    TLTextField *pwdTf = [[TLTextField alloc] initWithFrame:CGRectMake(margin, nameTf.yy + 10, w, h) leftTitle:[LangSwitcher switchLang:@"" key:nil] titleWidth:20 placeholder:[LangSwitcher switchLang:@"请输入密码" key:nil]];
//    pwdTf.keyboardType = UIKeyboardTypePhonePad;
    pwdTf.secureTextEntry = YES;
    pwdTf.returnKeyType = UIReturnKeyNext;
    [pwdTf addTarget:self action:@selector(next1) forControlEvents:UIControlEventEditingDidEndOnExit];
//    pwdTf.maxCount = 6;
    [self.view addSubview:pwdTf];
    self.pwdTf = pwdTf;
    UIView *phone3 = [[UIView alloc] init];
    [self.view addSubview:phone3];
    phone3.backgroundColor = kLineColor;
    phone3.frame = CGRectMake(margin*2, pwdTf.yy, w-30, 1);

    TLTextField *rePwdTf = [[TLTextField alloc] initWithFrame:CGRectMake(margin, pwdTf.yy + 1, w, h) leftTitle:[LangSwitcher switchLang:@"" key:nil] titleWidth:20 placeholder:[LangSwitcher switchLang:@"确认密码" key:nil]];
    rePwdTf.returnKeyType = UIReturnKeyNext;
    [rePwdTf addTarget:self action:@selector(next2) forControlEvents:UIControlEventEditingDidEndOnExit];
    rePwdTf.secureTextEntry = YES;
//    rePwdTf.keyboardType = UIKeyboardTypePhonePad;
//    rePwdTf.maxCount = 6;
    [self.view addSubview:rePwdTf];
    self.rePwdTf = rePwdTf;
    UIView *phone4 = [[UIView alloc] init];
    [self.view addSubview:phone4];
    phone4.backgroundColor = kLineColor;
    phone4.frame = CGRectMake(margin*2, rePwdTf.yy, w-30, 1);
    

    
    self.introduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:self.introduceButton];
//        NSString *text3 =  [LangSwitcher switchLang:@"我已阅读并同意服务及隐私条款" key:nil];

        [self.introduceButton setImage:kImage(@"Combined Shape2") forState:UIControlStateNormal];
        [self.introduceButton setImage:kImage(@"Oval Copy2") forState:UIControlStateSelected];
        _isSelect = @"1";
//        [self.introduceButton setTitle:text3 forState:UIControlStateNormal];
    [self.introduceButton addTarget:self action:@selector(html5Pri:) forControlEvents:UIControlEventTouchUpInside];

    self.introduceButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.introduceButton setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];
        [self.introduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rePwdTf.mas_bottom).offset(15);
            make.left.equalTo(whiteView.mas_left).offset(15);
            make.width.equalTo(@(30));
            make.height.equalTo(@30);
    
        }];
    UIButton *button = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"我已阅读并同意服务及隐私条款" key:nil] titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:12];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(html5Wallet) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rePwdTf.mas_bottom).offset(15);
        make.left.equalTo(self.introduceButton.mas_right).offset(0);
        make.width.equalTo(@(SCREEN_WIDTH - 60));
        make.height.equalTo(@30);
        
    }];
    
    self.buildButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text =  [LangSwitcher switchLang:@"创建钱包" key:nil];
//     = NSLocalizedString(@"创建钱包", nil);
    
    [self.buildButton setTitle:text forState:UIControlStateNormal];
    self.buildButton.titleLabel.font = [UIFont systemFontOfSize:16];

    [self.buildButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.buildButton addTarget:self action:@selector(buildWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.buildButton setBackgroundColor:kAppCustomMainColor forState:UIControlStateNormal];
    [self.view addSubview:self.buildButton];
    [self.buildButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kHeight(400)));
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.height.equalTo(@50);
        
    }];
    
    
    self.importButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text2 =  [LangSwitcher switchLang:@"导入钱包" key:nil];

//    NSString *text2 = NSLocalizedString(@"导入钱包", nil);
    [self.importButton setTitle:text2 forState:UIControlStateNormal];
    self.importButton.titleLabel.font = [UIFont systemFontOfSize:16];

    [self.importButton setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];
    [self.importButton addTarget:self action:@selector(importWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.importButton setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
    self.importButton.layer.borderColor = (kAppCustomMainColor.CGColor);
    self.importButton.layer.borderWidth = 1;
    self.importButton.clipsToBounds = YES;
    [self.view addSubview:self.importButton];
    [self.importButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buildButton.mas_bottom).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.height.equalTo(@50);
        
    }];
    
    self.introduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:self.introduceButton];
//    NSString *text3 =  [LangSwitcher switchLang:@"我已阅读并同意服务及隐私条款" key:nil];

//    NSString *text3 = NSLocalizedString(@"我已阅读并同意服务及隐私条款", nil);
//    [self.introduceButton setTitle:text3 forState:UIControlStateNormal];
    [self.introduceButton addTarget:self action:@selector(html5Wallet) forControlEvents:UIControlEventTouchUpInside];
    self.introduceButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.introduceButton setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];
//    [self.introduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
//        make.width.equalTo(@(kScreenWidth));
//        make.height.equalTo(@30);
//
//    }];

    
}

- (void)next
{
    [self.nameTf resignFirstResponder];
    [self.pwdTf becomeFirstResponder];
    
}
- (void)next1
{
    [self.pwdTf resignFirstResponder];
    [self.rePwdTf becomeFirstResponder];
    
}
- (void)next2
{
    [self.rePwdTf resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

- (void)requestProtect
{
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"660917";
    
    http.parameters[@"ckey"] = @"reg_protocol";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.h5String = responseObject[@"data"][@"cvalue"];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}
//创建钱包
- (void)buildWallet
{
    
    
    if ([self.nameTf.text isBlank]) {

        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入钱包名称" key:nil]];

        return;
    }
    
    if (([self.pwdTf.text isBlank])) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入密码" key:nil]];
        
        return;
    }
    
    if (([self.rePwdTf.text isBlank])) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入密码" key:nil]];
        return;
    }
    
    if (![self.pwdTf.text isEqualToString:self.rePwdTf.text]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"输入的密码不一致" key:nil]];
        return;
        
    }
    if (![self.isSelect isEqualToString:@"1"]) {
        
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请先阅读并同意服务条款" key:nil]];
        
        return;
    }
    BuildSucessVC *sucess = [[BuildSucessVC alloc] init];
    sucess.name = self.nameTf.text;
    sucess.PWD = self.rePwdTf.text;
    [self.navigationController pushViewController:sucess animated:YES];
    

    
}
//导入钱包
- (void)importWallet
{
    self.navigationController.navigationBar.hidden = NO;
    WalletImportVC *vc = [[WalletImportVC alloc] init];
    vc.title =  [LangSwitcher switchLang:@"导入钱包" key:nil];

//    vc.title = NSLocalizedString(@"导入钱包", nil);
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)html5Pri:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES)
    {
        _isSelect = @"0";
    }else
    {
        _isSelect = @"1";
    }
    
}
//加载隐私条款
- (void)html5Wallet
{
//    self.introduceButton.selected = !self.introduceButton.selected;
//    [self.introduceButton setImage:kImage(@"打勾 圆") forState:UIControlStateNormal];
//    [self.introduceButton setImage:kImage(@"打勾 圆") forState:UIControlStateSelected];

    HTMLStrVC *htmlVC = [[HTMLStrVC alloc] init];
    self.navigationController.navigationBar.hidden = NO;

    htmlVC.type = HTMLTypePrivacy;

    [self.navigationController pushViewController:htmlVC animated:YES];
    
}


- (void)clickCancel
{
    if (self.walletBlock) {
        self.walletBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
