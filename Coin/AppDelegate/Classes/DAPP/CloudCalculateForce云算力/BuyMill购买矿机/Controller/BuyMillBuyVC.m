//
//  BuyMillBuyVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BuyMillBuyVC.h"

@interface BuyMillBuyVC ()

@end

@implementation BuyMillBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = @"购买";
    self.navigationItem.titleView = self.titleText;
    
    
    [self.topView theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
    [backView theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    [self.view addSubview:backView];
    
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    [lineView1 theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [backView addSubview:lineView1];
    
    UILabel *promptLbl = [UILabel labelWithFrame:CGRectMake(15, 17.5, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    [promptLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    promptLbl.text = @"请输入购买台数（台）";
    [backView addSubview:promptLbl];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, promptLbl.yy + 7, SCREEN_WIDTH - 30, 33.5)];
    textField.placeholder = @"请输入";
    [textField setValue:FONT(24) forKeyPath:@"_placeholderLabel.font"];
    textField.font = FONT(24);
    textField.textColor = kHexColor([TLUser TextFieldTextColor]);
    [textField setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
    [backView addSubview:textField];
    
    UILabel *maintenanceFeeLbl = [UILabel labelWithFrame:CGRectMake(15, textField.yy + 9.5, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    [maintenanceFeeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    maintenanceFeeLbl.text = @"所需维护费：6个茄子";
    [backView addSubview:maintenanceFeeLbl];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, 0.5)];
    [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [backView addSubview:lineView];
    
    UILabel *balanceLbl = [UILabel labelWithFrame:CGRectMake(15, lineView.yy + 22, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
    [balanceLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    balanceLbl.text = @"当前茄子余额：5个";
    [balanceLbl sizeToFit];
    balanceLbl.frame = CGRectMake(15, lineView.yy + 22, balanceLbl.width, 20);
    [backView addSubview :balanceLbl];
    
    
    UIButton *exchangeBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"立即兑换" key:nil] titleColor:kTabbarColor backgroundColor:nil titleFont:12.0 cornerRadius:2];
    kViewBorderRadius(exchangeBtn, 2, 1, kTabbarColor);
    exchangeBtn.frame = CGRectMake(balanceLbl.xx + 17, lineView.yy + 19.5, 64, 25);
    [exchangeBtn addTarget:self action:@selector(exchangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:exchangeBtn];
    
    
    UILabel *orderInformationLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, lineView.yy + 59.5, SCREEN_WIDTH - 30, 20)];
    orderInformationLbl.text = @"订单总额：10000元，所需10000HEY";
    orderInformationLbl.textColor = kTabbarColor;
    orderInformationLbl.font = FONT(14);
    [backView addSubview:orderInformationLbl];
    
    UIButton *determineBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确定" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16.0 cornerRadius:5];
    determineBtn.frame = CGRectMake(15, backView.yy + 150, SCREEN_WIDTH - 30, 48);
    [determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineBtn];
    
}

-(void)exchangeBtnClick
{
    
}

-(void)determineBtnClick
{
    
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
