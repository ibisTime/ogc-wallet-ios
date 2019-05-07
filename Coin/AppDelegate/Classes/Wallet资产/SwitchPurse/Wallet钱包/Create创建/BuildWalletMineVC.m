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

//@property (nonatomic ,strong) UIImageView *nameLable;

@property (nonatomic ,strong) UIButton *buildButton;

@property (nonatomic ,strong) UIButton *importButton;

@property (nonatomic ,strong) UIButton *introduceButton;
//@property (nonatomic ,copy) NSString *h5String;
@property (nonatomic,strong) UITextField *phoneTf;

@property (nonatomic,strong) UITextField *pwdTf;

@property (nonatomic,strong) UITextField *rePwdTf;

@property (nonatomic, strong) CaptchaView *captchaView;

@property (nonatomic,strong) UITextField *nameTf;

@property (nonatomic,strong) UITextField *introduceTf;

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
    self.navigationItem.titleView = self.titleText;
    [self initViews];
    self.navigationController.navigationBar.titleTextAttributes=
  @{NSForegroundColorAttributeName:kWhiteColor
    ,
    NSFontAttributeName:[UIFont systemFontOfSize:16]};

}

- (void)initViews
{
    
    
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 33.5)];
    nameLable.text = [LangSwitcher switchLang:@"导入钱包" key:nil];
    nameLable.textAlignment = NSTextAlignmentLeft;
//    self.nameLable = nameLable;
    nameLable.font = Font(24);
    //    nameLable.textColor = kTextColor;
    //    nameLable.nightTextColor = kNightTextColor;
    [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
    [self.view addSubview:nameLable];
    
    
    
    
    UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, nameLable.yy + 45, SCREEN_WIDTH - 30, 16.5)];
    nameLbl.text = @"钱包名称";
    nameLbl.font = FONT(12);
    //    nameLbl.textColor = kGaryTextColor;
    //    nameLbl.nightTextColor = kNightGaryTextColor;
    [nameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    [self.view addSubview:nameLbl];
    
    
    UITextField *nameTf = [[UITextField alloc]initWithFrame:CGRectMake(15, nameLable.yy + 70, SCREEN_WIDTH - 30, 25)];
    [nameTf setValue:FONT(18) forKeyPath:@"_placeholderLabel.font"];
    nameTf.placeholder = [LangSwitcher switchLang:@"请输入钱包名称" key:nil];
    nameTf.font = FONT(18);
    //    nameTf.textColor = kGaryTextColor;
    //    nameTf.ni
    [nameTf theme_setTextIdentifier:GaryLabelColor moduleName:ColorName];
    //    nameTf.textColor = kGaryTextColor;
    //    nameTf.ni
    //    nameTf.pl = kNightGaryTextColor;
    [self.view addSubview:nameTf];
    self.nameTf = nameTf;
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(15, nameTf.yy + 10, SCREEN_WIDTH - 30, 0.5)];
    [self.view addSubview:lineView1];
    //    [lineView1 theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    //    lineView1.backgroundColor = kGaryTextColor;
    //    lineView1.nightBackgroundColor = kNightGaryTextColor;
    [lineView1 theme_setBackgroundColorIdentifier:GaryLabelColor moduleName:ColorName];
    
    UILabel *pwdLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, lineView1.yy + 20, SCREEN_WIDTH - 30, 16.5)];
    pwdLbl.text = @"请输入8～16位数字、字母组合";
    pwdLbl.font = FONT(12);
    [pwdLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    [self.view addSubview:pwdLbl];
    
    UITextField *pwdTf = [[UITextField alloc]initWithFrame:CGRectMake(15, pwdLbl.yy+8.5, SCREEN_WIDTH - 30, 25)];
    pwdTf.placeholder = [LangSwitcher switchLang:@"请设置钱包密码" key:nil];
    [pwdTf setValue:FONT(18) forKeyPath:@"_placeholderLabel.font"];
    pwdTf.font = FONT(18);
    [pwdTf theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
    [self.view addSubview:pwdTf];
    self.pwdTf = pwdTf;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(15, pwdTf.yy + 10, SCREEN_WIDTH - 30, 0.5)];
    [self.view addSubview:lineView2];
    
    [lineView2 theme_setBackgroundColorIdentifier:GaryLabelColor moduleName:ColorName];
    
    //re密码
    UILabel *rePwdLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, lineView2.yy + 20, SCREEN_WIDTH - 30, 16.5)];
    rePwdLbl.text = @"请输入8～16位数字、字母组合";
    [rePwdLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    //    pwdLbl.textColor = kGaryTextColor;
    //    pwdLbl.nightTextColor = kNightGaryTextColor;
    rePwdLbl.font = FONT(12);
    [self.view addSubview:rePwdLbl];
    
    
    
    
    
    
    UITextField *rePwdTf = [[UITextField alloc]initWithFrame:CGRectMake(15, rePwdLbl.yy + 8.5, SCREEN_WIDTH - 30, 25)];
    rePwdTf.placeholder = [LangSwitcher switchLang:@"请输入重复密码" key:nil];
    [rePwdTf setValue:FONT(18) forKeyPath:@"_placeholderLabel.font"];
    rePwdTf.font = FONT(18);
    [rePwdTf theme_setTextIdentifier:GaryLabelColor moduleName:ColorName];
    [self.view addSubview:rePwdTf];
    self.rePwdTf = rePwdTf;
    
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(15, rePwdTf.yy + 10, SCREEN_WIDTH - 30, 0.5)];
    [self.view addSubview:lineView3];
    [lineView3 theme_setBackgroundColorIdentifier:GaryLabelColor moduleName:ColorName];
    
    self.buildButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text =  [LangSwitcher switchLang:@"创建钱包" key:nil];
//     = NSLocalizedString(@"创建钱包", nil);
    
    [self.buildButton setTitle:text forState:UIControlStateNormal];
    self.buildButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.buildButton.frame = CGRectMake(15, lineView3.yy + 60, SCREEN_WIDTH - 30, 50);
    [self.buildButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.buildButton addTarget:self action:@selector(buildWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.buildButton setBackgroundColor:kAppCustomMainColor forState:UIControlStateNormal];
    [self.view addSubview:self.buildButton];
//    [self.buildButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(kHeight(400)));
//        make.right.equalTo(self.view.mas_right).offset(-15);
//        make.left.equalTo(self.view.mas_left).offset(15);
//        make.height.equalTo(@50);
//
//    }];
    
    
//    self.importButton = [UIButton buttonWithImageName:nil cornerRadius:6];
//    NSString *text2 =  [LangSwitcher switchLang:@"导入钱包" key:nil];
//
////    NSString *text2 = NSLocalizedString(@"导入钱包", nil);
//    [self.importButton setTitle:text2 forState:UIControlStateNormal];
//    self.importButton.titleLabel.font = [UIFont systemFontOfSize:16];
//
//    [self.importButton setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];
//    [self.importButton addTarget:self action:@selector(importWallet) forControlEvents:UIControlEventTouchUpInside];
//    [self.importButton setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
//    self.importButton.layer.borderColor = (kAppCustomMainColor.CGColor);
//    self.importButton.layer.borderWidth = 1;
//    self.importButton.clipsToBounds = YES;
//    [self.view addSubview:self.importButton];
//    [self.importButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.buildButton.mas_bottom).offset(15);
//        make.right.equalTo(self.view.mas_right).offset(-15);
//        make.left.equalTo(self.view.mas_left).offset(15);
//        make.height.equalTo(@50);
//
//    }];
    
//    self.introduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [self.introduceButton addTarget:self action:@selector(html5Wallet) forControlEvents:UIControlEventTouchUpInside];
//    self.introduceButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    [self.introduceButton setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];

    
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
        
//        self.h5String = responseObject[@"data"][@"cvalue"];
        
        
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
//    if (![self.isSelect isEqualToString:@"1"]) {
//
//        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请先阅读并同意服务条款" key:nil]];
//
//        return;
//    }
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
