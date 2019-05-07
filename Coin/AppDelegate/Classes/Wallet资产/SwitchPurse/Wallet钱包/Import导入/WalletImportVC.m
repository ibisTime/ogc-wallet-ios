//
//  WalletImportVC.m
//  Coin
//
//  Created by shaojianfei on 2018/6/9.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WalletImportVC.h"
#import "Masonry.h"
#import "UILabel+Extension.h"
#import "UILable+convience.h"
#import "TLTextView.h"
#import "TLAlert.h"

#import "TLTextField.h"
#import "CaptchaView.h"
#import "WalletNewFeaturesVC.h"
#import "HTMLStrVC.h"
#import "MnemonicUtil.h"
#import "NSString+Check.h"
#define ACCOUNT_HEIGHT 55;

@interface WalletImportVC ()<UITextViewDelegate>
@property (nonatomic ,strong) UILabel *nameLable;

@property (nonatomic ,strong) TLTextView *textView;
@property (nonatomic ,strong) UIButton *importButton;
@property (nonatomic ,strong) NSArray *wordArray;
@property (nonatomic ,strong) NSMutableArray *tempArray;
@property (nonatomic ,strong) NSMutableArray *UserWordArray;

@property (nonatomic ,strong) NSMutableArray *wordTempArray;
@property (nonatomic ,strong) NSArray *userTempArray;

@property (nonatomic,strong) UITextField *phoneTf;

@property (nonatomic,strong) UITextField *pwdTf;

@property (nonatomic,strong) UITextField *rePwdTf;

@property (nonatomic, strong) CaptchaView *captchaView;

@property (nonatomic,strong) UITextField *nameTf;

@property (nonatomic,strong) UITextField *introduceTf;

@property (nonatomic ,strong) UIButton *introduceButton;

@property (nonatomic,copy)NSString *isSelect;

@end

@implementation WalletImportVC

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
    
    self.wordTempArray = [NSMutableArray array];
    
    for (NSString *str in self.userTempArray) {
        if ([str  isEqual: @""]) {
            //
        }else{
            
            [self.wordTempArray addObject:str];
        }
    }
    NSLog(@"%@",self.tempArray);
    self.UserWordArray = self.wordTempArray;
    [self initSub];
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)initSub
{
    
    
    
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 33.5)];
    nameLable.text = [LangSwitcher switchLang:@"导入钱包" key:nil];
    nameLable.textAlignment = NSTextAlignmentLeft;
    self.nameLable = nameLable;
    nameLable.font = Font(24);
//    nameLable.textColor = kTextColor;
//    nameLable.nightTextColor = kNightTextColor;
    [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
    [self.view addSubview:nameLable];
    

    UILabel *promptLbl = [UILabel labelWithFrame:CGRectMake(15, nameLable.yy + 30, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:nil];
    promptLbl.text = @"请输入助记词，按空格分离";
//    promptLbl.textColor = kGaryTextColor;
//    promptLbl.nightTextColor = kNightGaryTextColor;
    [promptLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    [self.view addSubview:promptLbl];
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, promptLbl.yy + 17.5, kScreenWidth - 30, 90)];
//    backView.backgroundColor = kNightBackgroundColor;
//    backView.nightBackgroundColor = kBackgroundColor;
    [backView theme_setBackgroundColorIdentifier:GaryLabelColor moduleName:ColorName];
    [self.view addSubview:backView];
    
    TLTextView *textView = [[TLTextView alloc] initWithFrame:CGRectMake(1, 1, kScreenWidth - 30 - 2, 90 - 2)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEdit)];
    [textView addGestureRecognizer:tap];
    self.textView = textView;
//    textView.backgroundColor = kBackgroundColor;
//    textView.nightBackgroundColor = kNightBackgroundColor;
    [textView theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    textView.returnKeyType = UIReturnKeyNext;
//    [textView theme_setTextIdentifier:GaryLabelColor moduleName:ColorName];
    textView.font = [UIFont systemFontOfSize:15];
    [backView addSubview:self.textView];
    
    
    UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, backView.yy + 27, SCREEN_WIDTH - 30, 16.5)];
    nameLbl.text = @"钱包名称";
    nameLbl.font = FONT(12);
//    nameLbl.textColor = kGaryTextColor;
//    nameLbl.nightTextColor = kNightGaryTextColor;
    [nameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    [self.view addSubview:nameLbl];

    
    UITextField *nameTf = [[UITextField alloc]initWithFrame:CGRectMake(15, backView.yy + 52, SCREEN_WIDTH - 30, 25)];
    [nameTf setValue:FONT(18) forKeyPath:@"_placeholderLabel.font"];
    nameTf.placeholder = [LangSwitcher switchLang:@"请设置钱包密码" key:nil];
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
    
    _isSelect = @"1";
//    self.introduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:self.introduceButton];
//    [self.introduceButton setImage:kImage(@"Combined Shape2") forState:UIControlStateNormal];
//    [self.introduceButton setImage:kImage(@"Oval Copy2") forState:UIControlStateSelected];
//    [self.introduceButton addTarget:self action:@selector(html5Pri:) forControlEvents:UIControlEventTouchUpInside];
//    [self.introduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(rePwdTf.mas_bottom).offset(15);
//        make.left.equalTo(self.view.mas_left).offset(15);
//        make.width.equalTo(@(30));
//        make.height.equalTo(@30);
//
//    }];
//
//    UIButton *button = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"我已阅读并同意服务及隐私条款" key:nil] titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:12];
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(rePwdTf.mas_bottom).offset(15);
//        make.left.equalTo(self.introduceButton.mas_right).offset(0);
//        make.width.equalTo(@(SCREEN_WIDTH - 60));
//        make.height.equalTo(@30);
//
//    }];
    
    self.importButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text2 = [LangSwitcher switchLang:@"导入钱包" key:nil];
    [self.importButton setTitle:text2 forState:UIControlStateNormal];
    self.importButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.importButton.frame = CGRectMake(15, lineView3.yy + 55, SCREEN_WIDTH - 30, 50);
    [self.importButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.importButton addTarget:self action:@selector(importNow) forControlEvents:UIControlEventTouchUpInside];
    [self.importButton setBackgroundColor:kAppCustomMainColor forState:UIControlStateNormal];
    self.importButton.layer.borderColor = (kAppCustomMainColor.CGColor);
    self.importButton.layer.borderWidth = 1;
    self.importButton.clipsToBounds = YES;
    [self.view addSubview:self.importButton];
    
    
    
//    self.introduceButton = [UIButton buttonWithImageName:nil cornerRadius:6];
//    NSString *text4 = [LangSwitcher switchLang:@"什么是助记词" key:nil];
//    [self.introduceButton setTitle:text4 forState:UIControlStateNormal];
//    self.introduceButton.titleLabel.font = [UIFont systemFontOfSize:16];
//
//    [self.introduceButton setTitleColor:kHexColor(@"#007AFF") forState:UIControlStateNormal];
//    [self.introduceButton addTarget:self action:@selector(html5Wallet) forControlEvents:UIControlEventTouchUpInside];
//    [self.introduceButton setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
////    self.introduceButton.layer.borderColor = (kAppCustomMainColor.CGColor);
////    self.introduceButton.layer.borderWidth = 1;
////    self.introduceButton.clipsToBounds = YES;
//
//    [self.view addSubview:self.introduceButton];
//    [self.introduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.importButton.mas_bottom).offset(26);
//        make.right.equalTo(self.view.mas_right).offset(-15);
//        make.left.equalTo(self.view.mas_left).offset(15);
//        make.height.equalTo(@50);
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

- (void)importNow
{
    
    if ([self.textView.text isBlank]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入助记词" key:nil]];
        return;
    }
    if ([self.nameTf.text isBlank]) {

        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入钱包名称" key:nil]];

        return;
    }
    
    if (([self.pwdTf.text  isBlank])) {
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
//    NSString *pwd = [self.FirstPSWArray componentsJoinedByString:@""];
//    //            [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:KUserPwd];
//    //导入钱包交易密码
   
//    //
    
    //            [[NSUserDefaults standardUserDefaults] synchronize];
  
    
    //验证
    self.wordArray = [NSArray array];
    self.wordArray = [self.textView.text componentsSeparatedByString:@" "];
    self.tempArray = [NSMutableArray array];

    for (NSString *str in self.wordArray) {
        if ([str  isEqual: @""]) {
//
        }else{
            
            [self.tempArray addObject:str];
        }
    }
    NSLog(@"%@",self.tempArray);

//    NSString *result = [MnemonicUtil getMnemonicsISRight:self.textView.text];
    if ([[MnemonicUtil getMnemonicsISRight:self.textView.text] isEqualToString:@"1"]) {
        NSString *mnemonics = self.textView.text;
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"ChengWallet.db"];
        NSLog(@"dbPath = %@",dbPath);
        FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
        
        if ([dataBase open])
        {
            [dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS ChengWallet (rowid INTEGER PRIMARY KEY AUTOINCREMENT, userid text,mnemonics text,pwd text,walletName text)"];
        }
        [dataBase close];
        
        [dataBase open];
        [dataBase executeUpdate:@"INSERT INTO ChengWallet (userid,mnemonics,pwd,walletName) VALUES (?,?,?,?)",[TLUser user].userId,mnemonics,self.pwdTf.text,self.nameTf.text];
        [dataBase close];
        
        [TLAlert alertWithTitle:[LangSwitcher switchLang:@"提示" key:nil] message:[LangSwitcher switchLang:@"导入成功" key:nil] confirmAction:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            //            创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"PrivateKeyWalletCreat" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }];
        
        


        //设置交易密码
    }else{
        

        [TLAlert alertWithMsg:@"助记词不存在,请检测备份"];
        self.importButton.selected = NO;
        return;


    }
    
    //
    
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

-(void)buttonClick
{
    HTMLStrVC *htmlVC = [[HTMLStrVC alloc] init];
    self.navigationController.navigationBar.hidden = NO;
    htmlVC.type = HTMLTypePrivacy;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (void)html5Wallet
{
    HTMLStrVC *htmlVC = [[HTMLStrVC alloc] init];
    self.navigationController.navigationBar.hidden = NO;
    htmlVC.type = HTMLTypeMnemonic;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)beginEdit
{
    [self.view endEditing:YES];
}


//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    CoinWeakSelf;
//    　　if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
//
//        if (self.walletBlock) {
//            self.walletBlock();
//        }
//        　　　　NSLog(@"clicked navigationbar back button");
//        　　}
//
//}

@end
