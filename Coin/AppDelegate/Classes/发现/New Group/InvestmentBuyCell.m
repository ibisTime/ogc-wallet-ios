//
//  InvestmentBuyCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "InvestmentBuyCell.h"

@implementation InvestmentBuyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        amountField.clearButtonMode = UITextFieldViewModeWhileEditing;
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
        [numberBox addSubview:numberField];
        
        
        
        UILabel *numberunit = [UILabel labelWithFrame:CGRectMake(numberField.xx + 15, 0, 40, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        numberunit.text = [LangSwitcher switchLang:@"BTC" key:nil];
        [numberBox addSubview:numberunit];
        
        
        UILabel *poundageLbl = [UILabel labelWithFrame:CGRectMake(15, 140,SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        NSString *poundage = [LangSwitcher switchLang:@"交易手续费：" key:nil];
        NSString *poundagePrice = [LangSwitcher switchLang:@"0.5%" key:nil];
        NSString *poundageAll = [NSString stringWithFormat:@"%@%@",poundage,poundagePrice];
        NSMutableAttributedString *poundageAttrStr = [[NSMutableAttributedString alloc] initWithString:poundageAll];
        [poundageAttrStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(poundage.length,poundageAll.length - poundage.length)];
        poundageLbl.attributedText = poundageAttrStr;
        [self addSubview:poundageLbl];
        
        
        
        
        
        
    }
    return self;
}

@end
