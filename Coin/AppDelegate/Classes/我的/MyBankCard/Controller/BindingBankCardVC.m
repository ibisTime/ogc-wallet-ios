//
//  BindingBankCardVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BindingBankCardVC.h"

@interface BindingBankCardVC ()

@end

@implementation BindingBankCardVC

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"绑定银行卡" key:nil];
    self.navigationItem.titleView = self.titleText;
    [self initView];
    
}

-(void)initView
{
    NSArray *nameArray = @[@"持卡人",@"银行",@"开户支行",@"银行卡号"];
    NSArray *placArray = @[@"持卡人",@"银行名称",@"开户支行",@"银行卡号"];
    
    for (int i = 0; i < 4; i ++) {
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, i% 4 * 55, 0, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        nameLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
        [nameLabel sizeToFit];
        nameLabel.frame = CGRectMake(15, i% 4 * 55, nameLabel.width, 55);
        [self.view addSubview:nameLabel];
        
        
        UITextField *nameTextFid = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.xx + 20, i% 4 * 55, SCREEN_WIDTH - nameLabel.xx - 20 - 30, 55)];
        nameTextFid.placeholder = [LangSwitcher switchLang:@"请输入密码（6~16个字符或字母组成）" key:nil];
        [nameTextFid setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
        nameTextFid.font = FONT(15);
        nameTextFid.placeholder = [LangSwitcher switchLang:placArray[i] key:nil];
        [self.view addSubview:nameTextFid];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, i% 4 * 55 + 54, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
        
        if (i == 1) {
            UIButton *chooseBankCardBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [chooseBankCardBtn setImage:kImage(@"发布文章-下拉") forState:(UIControlStateNormal)];
            chooseBankCardBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - 9, 55, 39, 55);
            [self.view addSubview:chooseBankCardBtn];
        }
        
    }
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kHexColor(@"#4064E6") titleFont:15];
    confirmBtn.frame = CGRectMake(15, 280, SCREEN_WIDTH - 30, 50);
    kViewRadius(confirmBtn, 4);
    [self.view addSubview:confirmBtn];
    
    
    
}


@end
