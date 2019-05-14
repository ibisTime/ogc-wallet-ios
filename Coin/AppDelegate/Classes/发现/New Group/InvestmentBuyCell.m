//
//  InvestmentBuyCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "InvestmentBuyCell.h"

@implementation InvestmentBuyCell
{
    BOOL isHaveDian;
    UILabel *poundageLbl;
    UILabel *poundageLbl1;
    UILabel *numberunit;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UIView *amountBox = [[UIView alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 45)];
        kViewBorderRadius(amountBox, 2, 0.5, kHexColor(@"#979797"));
        [self addSubview:amountBox];
        
        UILabel *amountLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 0, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        amountLabel.text = [LangSwitcher switchLang:@"金额" key:nil];
        [amountLabel sizeToFit];
        amountLabel.frame = CGRectMake(15, 0, amountLabel.width, 45);
        [amountBox addSubview:amountLabel];
        
        UITextField *amountField = [[UITextField alloc]initWithFrame:CGRectMake(amountLabel.xx + 15, 0, SCREEN_WIDTH - amountLabel.xx - 15 - 60 - 30, 45)];
        amountField.placeholder = [LangSwitcher switchLang:@"请输入买人金额" key:nil];
        [amountField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        amountField.font = FONT(14);
        amountField.tag = 10000;
        self.amountField = amountField;
        amountField.delegate = self;
        amountField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(amounttextFieldTextDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                                  object:amountField];
        [amountBox addSubview:amountField];
        
        
        UILabel *amountunit = [UILabel labelWithFrame:CGRectMake(amountField.xx + 15, 0, 40, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        amountunit.text = [LangSwitcher switchLang:@"CNY" key:nil];
        
        [amountBox addSubview:amountunit];
        
        
        UIView *numberBox = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 45)];
        kViewBorderRadius(numberBox, 2, 0.5, kHexColor(@"#979797"));
        [self addSubview:numberBox];
        
        UILabel *numberLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 0, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        numberLabel.text = [LangSwitcher switchLang:@"数量" key:nil];
        [numberLabel sizeToFit];
        numberLabel.frame = CGRectMake(15, 0, numberLabel.width, 45);
        [numberBox addSubview:numberLabel];
        
        UITextField *numberField = [[UITextField alloc]initWithFrame:CGRectMake(numberLabel.xx + 15, 0, SCREEN_WIDTH - numberLabel.xx - 15 - 60 - 30, 45)];
        numberField.placeholder = [LangSwitcher switchLang:@"请输入买人数量" key:nil];
        [numberField setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        numberField.font = FONT(14);
        numberField.clearButtonMode = UITextFieldViewModeWhileEditing;
        numberField.tag = 10001;
        numberField.delegate = self;
        self.numberField = numberField;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(numbertextFieldTextDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                                  object:numberField];
        [numberBox addSubview:numberField];
        
        
        
        numberunit = [UILabel labelWithFrame:CGRectMake(numberField.xx + 15, 0, 40, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
//        numberunit.text = [LangSwitcher switchLang:@"BTC" key:nil];
        [numberBox addSubview:numberunit];
        
        
        
        
        poundageLbl = [UILabel labelWithFrame:CGRectMake(15, 140,SCREEN_WIDTH/2 - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        poundageLbl.tag = 1000;
        [self addSubview:poundageLbl];
        
        poundageLbl1 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 140,SCREEN_WIDTH/2 - 15, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        poundageLbl1.tag = 1001;
        poundageLbl1.hidden = YES;
        [self addSubview:poundageLbl1];
        
        
        
    }
    return self;
}

-(void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    numberunit.text = symbol;
}

-(void)setRate:(NSString *)Rate
{
    if ([Rate floatValue] > 0) {
        NSString *poundage = [LangSwitcher switchLang:@"交易手续费：" key:nil];
        NSString *poundagePrice = [NSString stringWithFormat:@"%.2f%%",[Rate floatValue]*100];
        NSString *poundageAll = [NSString stringWithFormat:@"%@%@",poundage,poundagePrice];
        NSMutableAttributedString *poundageAttrStr = [[NSMutableAttributedString alloc] initWithString:poundageAll];
        [poundageAttrStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(poundage.length,poundageAll.length - poundage.length)];
        poundageLbl.attributedText = poundageAttrStr;
        poundageLbl1.attributedText = poundageAttrStr;
    }
    
}

-(void)setBalance:(NSString *)balance
{
    if ([TLUser isBlankString:balance] == YES) {
        poundageLbl1.hidden = YES;
        
    }else
    {
        poundageLbl1.hidden = NO;
        NSString *poundage = [LangSwitcher switchLang:@"可用余额：" key:nil];
        NSString *poundagePrice = [NSString stringWithFormat:@"%@%@",balance,self.symbol];
        NSString *poundageAll = [NSString stringWithFormat:@"%@%@",poundage,poundagePrice];
        NSMutableAttributedString *poundageAttrStr = [[NSMutableAttributedString alloc] initWithString:poundageAll];
        [poundageAttrStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(poundage.length,poundageAll.length - poundage.length)];
        poundageLbl.attributedText = poundageAttrStr;
    }
}


-(void)amounttextFieldTextDidChangeOneCI:(NSNotification *)notification
{
    
    UITextField *textfield=[notification object];
    NSLog(@"ssssss %@",textfield.text);
    self.numberField.text = [NSString stringWithFormat:@"%.8f",[textfield.text floatValue]/self.price];
}


-(void)numbertextFieldTextDidChangeOneCI:(NSNotification *)notification
{
    
    UITextField *textfield=[notification object];
    NSLog(@"ssssss %@",textfield.text);
    self.amountField.text = [NSString stringWithFormat:@"%.2f",[textfield.text floatValue]*self.price];
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            isHaveDian=NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                if([textField.text length]==0){
                    if(single == '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single=='.')
                {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian=YES;
                        return YES;
                    }else
                    {
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
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



-(void)setPrice:(CGFloat)price
{
    _price = price;
}


@end
