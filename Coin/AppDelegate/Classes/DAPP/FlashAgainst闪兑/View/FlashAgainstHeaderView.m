//
//  FlashAgainstHeaderView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FlashAgainstHeaderView.h"

@implementation FlashAgainstHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
        iconImg.image = kImage(@"头像");
        [self addSubview:iconImg];
        
        UILabel *phoneLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 10, 15, SCREEN_WIDTH - 25, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:nil];
        phoneLbl.text = [TLUser user].mobile;
        [self addSubview:phoneLbl];
        
        UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 45)];
        kViewBorderRadius(borderView, 2, 0.5, kHexColor([TLUser TextFieldPlacColor]));
        [self addSubview:borderView];
        
        UILabel *symbolLbl1 = [UILabel labelWithFrame:CGRectMake(11, 0, SCREEN_WIDTH/2 - 26, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [symbolLbl1 theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        symbolLbl1.text = @"1MGC=0.001036196 ETH";
        [borderView addSubview:symbolLbl1];
        
        UILabel *symbolLbl2 = [UILabel labelWithFrame:CGRectMake(symbolLbl1.xx, 0, SCREEN_WIDTH/2 - 26, 45) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        symbolLbl2.text = @"1MGC=0.023 USD";
        [symbolLbl2 theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [borderView addSubview:symbolLbl2];
        
        UIButton *conversionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [conversionBtn setImage:kImage(@"切换") forState:(UIControlStateNormal)];
        conversionBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 20, borderView.yy + 20, 40, 40);
        [self addSubview:conversionBtn];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 140, SCREEN_WIDTH/2 - 47.5, 50)];
        [leftView theme_setBackgroundColorIdentifier:@"FlashAgainstConversionColor" moduleName:ColorName];
        kViewRadius(leftView, 2);
        [self addSubview:leftView];
        
        
        UILabel *leftLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
        leftLbl.font = FONT(14);
        leftLbl.text = @"BTC";
        [leftLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [leftLbl sizeToFit];
        leftLbl.frame = CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - leftLbl.width/2 + 20, 0, leftLbl.width, 50);
        [leftView addSubview:leftLbl];
        
        UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - leftLbl.width/2 - 20, 10, 30, 30)];
        leftImg.image = kImage(@"BTC");
        [leftView addSubview:leftImg];
        
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(conversionBtn.xx + 12.5, 140, SCREEN_WIDTH/2 - 47.5, 50)];
        [rightView theme_setBackgroundColorIdentifier:@"FlashAgainstConversionColor" moduleName:ColorName];
        kViewRadius(rightView, 2);
        [self addSubview:rightView];
        
        UILabel *rightLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
        rightLbl.font = FONT(14);
        rightLbl.text = @"ETHETH";
        [rightLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [rightLbl sizeToFit];
        rightLbl.frame = CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - rightLbl.width/2 + 20, 0, rightLbl.width, 50);
        [rightView addSubview:rightLbl];
        
        UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - rightLbl.width/2 - 20, 10, 30, 30)];
        rightImg.image = kImage(@"ETH");
        [rightView addSubview:rightImg];
        
        UIView *leftNumberView = [[UIView alloc]initWithFrame:CGRectMake(15, 205, (SCREEN_WIDTH - 45)/2, 45)];
        [leftNumberView theme_setBackgroundColorIdentifier:@"leftNumberView" moduleName:ColorName];
        kViewBorderRadius(leftNumberView, 2, 1, kHexColor([TLUser LineColor]));
        [self addSubview:leftNumberView];
        
        UITextField *leftNumberTf = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH - 45)/2 - 30, 45)];
        leftNumberTf.placeholder = [LangSwitcher switchLang:@"兑换数量" key:nil];
        [leftNumberTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        leftNumberTf.font = FONT(14);
        leftNumberTf.keyboardType =  UIKeyboardTypeNumberPad;
        leftNumberTf.textColor = kHexColor([TLUser TextFieldTextColor]);
        [leftNumberTf setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
        [leftNumberView addSubview:leftNumberTf];
        
        UIView *rightNumberView = [[UIView alloc]initWithFrame:CGRectMake(leftNumberView.xx + 15, 205, (SCREEN_WIDTH - 45)/2, 45)];
        [rightNumberView theme_setBackgroundColorIdentifier:@"leftNumberView" moduleName:ColorName];
        kViewBorderRadius(rightNumberView, 2, 1, kHexColor([TLUser LineColor]));
        [self addSubview:rightNumberView];
        
        UITextField *rightNumberTf = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH - 45)/2 - 30, 45)];
        rightNumberTf.placeholder = [LangSwitcher switchLang:@"收到数量" key:nil];
        [rightNumberTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        rightNumberTf.font = FONT(14);
        rightNumberTf.keyboardType =  UIKeyboardTypeNumberPad;
        rightNumberTf.textColor = kHexColor([TLUser TextFieldTextColor]);
        [rightNumberTf setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
        [rightNumberView addSubview:rightNumberTf];
        
        UILabel *balanceLbl = [[UILabel alloc]initWithFrame:CGRectMake(16, 250 + 20.5, 0, 16.5)];
        balanceLbl.font = FONT(12);
        balanceLbl.text = @"余额 0.00034";
        [balanceLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [balanceLbl sizeToFit];
        balanceLbl.frame = CGRectMake(16, 250 + 20.5, balanceLbl.width, 16.5);
        [self addSubview:balanceLbl];
        
        UIButton *allBtn = [[UIButton alloc]initWithFrame:CGRectMake(balanceLbl.xx + 20, 250 + 15, 50, 27)];
        [allBtn setTitle:@"全部" forState:(UIControlStateNormal)];
//        [allBtn setTitleColor:kHexColor(@"#FFFFFF") forState:(UIControlStateNormal)];
        [allBtn setBackgroundColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
        kViewRadius(allBtn, 4);
        allBtn.titleLabel.font = FONT(12);
        [self addSubview:allBtn];

        UILabel *poundageLbl = [[UILabel alloc]initWithFrame:CGRectMake(16, 250 + 20.5, 0, 16.5)];
        poundageLbl.font = FONT(12);
        poundageLbl.text = @"手续费：0.0034";
        [poundageLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [poundageLbl sizeToFit];
        poundageLbl.frame = CGRectMake(allBtn.xx + 30, 250 + 20.5, poundageLbl.width, 16.5);
        [self addSubview:poundageLbl];
        
        UIButton *exchangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, allBtn.yy + 35, SCREEN_WIDTH - 30, 48)];
        [exchangeBtn setTitle:@"兑换" forState:(UIControlStateNormal)];

        [exchangeBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
        kViewRadius(exchangeBtn, 4);
        exchangeBtn.titleLabel.font = FONT(16);
        [self addSubview:exchangeBtn];
        
    }
    return self;
}

@end
