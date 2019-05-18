//
//  PosBuyBalanceCell.m
//  Coin
//
//  Created by QinBao Zheng on 2018/9/26.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "PosBuyBalanceCell.h"

@implementation PosBuyBalanceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, kScreenWidth - 15 - 64 - 25, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:nil];
        self.nameLabel = nameLabel;

        [self addSubview:nameLabel];


        UIButton *intoButton = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"转入资金" key:nil] titleColor:kTabbarColor backgroundColor:kClearColor titleFont:12];
        self.intoButton = intoButton;
        intoButton.frame = CGRectMake(kScreenWidth - 15 - 64, 12, 64, 26);
        kViewBorderRadius(intoButton, 2, 1, kTabbarColor);
        [self addSubview:intoButton];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//        lineView.backgroundColor = kLineColor;
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        [lineView1 theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView1];
    }
    return self;
}

-(void)setCurrencys:(CurrencyModel *)currencys
{
//    NSString *text = currencys.amountString;

//    NSString *name = [LangSwitcher switchLang:@"可用余额:" key:nil];
//    currencys.currency];

    NSString *leftAmount = [CoinUtil convertToRealCoin:currencys.amount coin:currencys.currency];
    NSString *rightAmount = [CoinUtil convertToRealCoin:currencys.frozenAmount coin:currencys.currency];
    NSString *ritAmount = [leftAmount subNumber:rightAmount];
//    NSString *str1 = [NSString stringWithFormat:@" %.2f ",[ritAmount doubleValue]];


//    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",[LangSwitcher switchLang:@"可用余额:" key:nil],str1,currencys.currency];

//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
//    UIFont *font = [UIFont systemFontOfSize:20];
//    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(name.length,str1.length)];
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@%@",[LangSwitcher switchLang:@"可用余额" key:nil],ritAmount,currencys.currency];

}

@end
