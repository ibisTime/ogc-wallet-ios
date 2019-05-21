//
//  BuyMillBuyVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BuyMillBuyVC.h"
#import "FlashAgainstVC.h"
@interface BuyMillBuyVC ()<UITextFieldDelegate>
{
    CGFloat rmbPrice;
    CGFloat sellerPrice;
    UILabel *orderInformationLbl;

}

@property (nonatomic , strong)UITextField *numberTextField;;
@property (nonatomic , strong)NSMutableArray <CurrencyModel *>*models;
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
    promptLbl.text = @"请输入购买滴数（滴）";
    [backView addSubview:promptLbl];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, promptLbl.yy + 7, SCREEN_WIDTH - 30, 33.5)];
    textField.placeholder = @"请输入";
    [textField setValue:FONT(24) forKeyPath:@"_placeholderLabel.font"];
    textField.font = FONT(24);
    textField.keyboardType =  UIKeyboardTypeNumberPad;
    textField.textColor = kHexColor([TLUser TextFieldTextColor]);
    [textField setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(numberTextFieldDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                              object:textField];
    textField.delegate = self;
    self.numberTextField = textField;
    [backView addSubview:textField];
    
    UILabel *maintenanceFeeLbl = [UILabel labelWithFrame:CGRectMake(15, textField.yy + 9.5, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    [maintenanceFeeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    maintenanceFeeLbl.text = @"所需维护费：6个氢气";
    [backView addSubview:maintenanceFeeLbl];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, 0.5)];
    [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [backView addSubview:lineView];
    
    UILabel *balanceLbl = [UILabel labelWithFrame:CGRectMake(15, lineView.yy + 22, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
    [balanceLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    balanceLbl.text = @"当前氢气余额：5个";
    [balanceLbl sizeToFit];
    balanceLbl.frame = CGRectMake(15, lineView.yy + 22, balanceLbl.width, 20);
    [backView addSubview :balanceLbl];
    
    
    UIButton *exchangeBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"立即兑换" key:nil] titleColor:kTabbarColor backgroundColor:nil titleFont:12.0 cornerRadius:2];
    kViewBorderRadius(exchangeBtn, 2, 1, kTabbarColor);
    exchangeBtn.frame = CGRectMake(balanceLbl.xx + 17, lineView.yy + 19.5, 64, 25);
    [exchangeBtn addTarget:self action:@selector(exchangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:exchangeBtn];
    
    
    orderInformationLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, lineView.yy + 59.5, SCREEN_WIDTH - 30, 20)];
    orderInformationLbl.text = [NSString stringWithFormat:@"订单总额：0.00元，所需0.00%@",self.model.symbol];
    orderInformationLbl.textColor = kTabbarColor;
    orderInformationLbl.font = FONT(14);
    [backView addSubview:orderInformationLbl];
    
    UIButton *determineBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确定" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16.0 cornerRadius:5];
    determineBtn.frame = CGRectMake(15, backView.yy + 150, SCREEN_WIDTH - 30, 48);
    [determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineBtn];
    
    
    [self queryCenterTotalAmount];
    [self TheMarket];
}

-(void)numberTextFieldDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];
    
    orderInformationLbl.text = [NSString stringWithFormat:@"订单总额：%.2f元，所需%@%@",[textfield.text floatValue]*[self.model.amount floatValue],[CoinUtil mult1:[NSString stringWithFormat:@"%.8f",[self.model.amount floatValue] *[textfield.text floatValue]/sellerPrice] mult2:@"1" scale:8],self.model.symbol];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9'))//数据格式正确
        {
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single=='.')
            {
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
            
            return YES;
        }else{
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }else
    {
        return YES;
    }
    
    
}



//   个人钱包余额查询
- (void)queryCenterTotalAmount
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"802301";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        
        
        self.models = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
 
        for (int i = 0; i< self.models.count; i ++) {
            if ([self.models[i].currency isEqualToString:self.model.symbol]) {
                rmbPrice = [self.models[i].priceCNY floatValue];
            }
        }
        
        
    } failure:^(NSError *error) {

    }];
}

-(void)TheMarket
{
    TLNetworking *InHttp = [[TLNetworking alloc] init];
    InHttp.code = @"650201";
    InHttp.showView = self.view;
    InHttp.parameters[@"type"] = @"0";
    InHttp.parameters[@"symbol"] = self.model.symbol;
    
    
    
    
    
    
    
    [InHttp postWithSuccess:^(id responseObject) {
        sellerPrice = [responseObject[@"data"][@"sellerPrice"] floatValue];
        
    } failure:^(NSError *error) {
    }];
    
}

-(void)exchangeBtnClick
{
    FlashAgainstVC *vc = [FlashAgainstVC new];
    vc.symbol = @"ET";
    [self.navigationController pushViewController:vc animated:YES];
}

//购买 
-(void)determineBtnClick
{
    
    if ([_numberTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入购买滴数"];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"610100";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"machineCode"] = self.model.code;
    http.parameters[@"quantity"] = _numberTextField.text;
    http.parameters[@"investCount"] = [CoinUtil convertToRealCoin:[CoinUtil mult1:[NSString stringWithFormat:@"%.8f",[self.model.amount floatValue] *[_numberTextField.text floatValue]/sellerPrice] mult2:@"1" scale:8] coin:_model.symbol];
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"购买成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error) {
        
    }];
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
