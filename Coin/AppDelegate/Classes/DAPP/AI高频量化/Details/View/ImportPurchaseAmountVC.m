//
//  ImportPurchaseAmountVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "ImportPurchaseAmountVC.h"

@implementation ImportPurchaseAmountVC
{
    UILabel *expectedIncomeLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 340)];
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        kViewRadius(backView, 4);
        [self addSubview:backView];
        
        NSArray *leftAry = @[@"代币名称",@"个人账户余额",@"购买额度"];
        for (int i = 0; i < 3; i ++) {
            UILabel *leftLbl = [UILabel labelWithFrame:CGRectMake(20, 30 + i % 4 * 45, 90, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
            if (i == 2) {
                [leftLbl theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
            }else
            {
                [leftLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            }
            
            leftLbl.text = leftAry[i];
            [self addSubview:leftLbl];
            
            UILabel *rightLbl = [UILabel labelWithFrame:CGRectMake(110, 30 + i % 4 * 45, SCREEN_WIDTH - 110 - 60 - 20, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
            rightLbl.tag = 100 + i;
            [self addSubview:rightLbl];
            
            if (i != 2) {
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, leftLbl.yy, SCREEN_WIDTH - 60 - 40, 0.5)];
                [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
                [self addSubview:lineView];
            }
            
            if (i == 1) {
                
                rightLbl.frame = CGRectMake(110, 30 + i % 4 * 45, SCREEN_WIDTH - 110 - 60 - 20 - 70, 45);
                
                UIButton *intoBtn = [UIButton buttonWithTitle:@"转入资金" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:12 cornerRadius:2];
                self.intoBtn = intoBtn;
                intoBtn.frame = CGRectMake(SCREEN_WIDTH - 60 - 20 - 60, rightLbl.y + 8, 60, 27);
                kViewBorderRadius(intoBtn, 2, 1, kTabbarColor);
                [self addSubview:intoBtn];
            }
            
        }
        
        
        UITextField *buyCreditsTf = [[UITextField alloc]initWithFrame:CGRectMake(20, 165, SCREEN_WIDTH - 40 - 50 - 60, 45)];
        buyCreditsTf.placeholder = [LangSwitcher switchLang:@"请输入购买额度" key:nil];
        [buyCreditsTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        buyCreditsTf.font = FONT(14);
        buyCreditsTf.textColor = kHexColor([TLUser TextFieldTextColor]);
        [buyCreditsTf setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buyCreditsTfDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                                  object:buyCreditsTf];
        self.buyCreditsTf = buyCreditsTf;
        [self addSubview:buyCreditsTf];
        
        
        
        UILabel *smbolLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 50 - 60, 165, 50, 45) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        smbolLbl.text = @"BTC";
        [self addSubview:smbolLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, buyCreditsTf.yy, SCREEN_WIDTH - 60 - 40, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
        expectedIncomeLbl = [UILabel labelWithFrame:CGRectMake(20, lineView.yy + 10, SCREEN_WIDTH - 100, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [expectedIncomeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:expectedIncomeLbl];
        
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 60 - 20, 15, 20, 20);
        [deleteBtn setImage:kImage(@"红包 删除") forState:(UIControlStateNormal)];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:deleteBtn];
        
        UIButton *confirm = [UIButton buttonWithTitle:@"确认付款" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:14];
        confirm.frame = CGRectMake(20, 270, SCREEN_WIDTH - 15 - 60 - 20, 45);
        kViewRadius(confirm, 2);
        self.confirm = confirm;
        [self addSubview:confirm];
        
    }
    return self;
}

-(void)buyCreditsTfDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];
    
    if ([textfield.text floatValue] == 0) {
        NSString *text = [NSString stringWithFormat:@"预计每日收入0.00 %@",self.model.symbolBuy];
        
        NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:kTabbarColor
                             range:NSMakeRange(4, 4)];
        expectedIncomeLbl.attributedText = attributeStr;
    }else
    {
        self.price = [CoinUtil mult1:textfield.text mult2:self.model.rate scale:8];
        NSString *text = [NSString stringWithFormat:@"预计每日收入%@ %@",self.price,self.model.symbolBuy];
        
        NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:kTabbarColor
                             range:NSMakeRange(6, self.price.length)];
        expectedIncomeLbl.attributedText = attributeStr;
        
    }
    
    
    
}

-(void)deleteBtnClick
{
    [[UserModel user].cusPopView dismiss];
}

-(void)setModel:(AIQuantitativeModel *)model
{
    _model = model;
    
    NSString *text = [NSString stringWithFormat:@"预计每日收入0.00 %@",model.symbolBuy];
    
    NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName
                         value:kTabbarColor
                         range:NSMakeRange(4, 4)];
    expectedIncomeLbl.attributedText = attributeStr;
    
    
    UILabel *label1 = [self viewWithTag:100];
    label1.text = model.symbolBuy;
}

-(void)setCurrencyModel:(CurrencyModel *)currencyModel
{
    UILabel *label2 = [self viewWithTag:101];
    NSString *amount = [CoinUtil convertToRealCoin:currencyModel.amount coin:currencyModel.currency];
    NSString *rightAmount = [CoinUtil convertToRealCoin:currencyModel.frozenAmount coin:currencyModel.currency];
    NSString *ritAmount = [amount subNumber:rightAmount];
    label2.text = [NSString stringWithFormat:@"%@%@",ritAmount,currencyModel.currency];
    
}


@end
