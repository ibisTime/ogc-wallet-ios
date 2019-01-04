//
//  PaymentInstructionsView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/4.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PaymentInstructionsView.h"

@implementation PaymentInstructionsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *nameLbael = [UILabel labelWithFrame:CGRectMake(10, 23, SCREEN_WIDTH - 60, 26.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(19) textColor:kHexColor(@"#333333")];
        nameLbael.text = [LangSwitcher switchLang:@"付款须知" key:nil];
        [self addSubview:nameLbael];
        
        UILabel *PSLbl = [UILabel labelWithFrame:CGRectMake(10, nameLbael.yy + 16, SCREEN_WIDTH - 60, 27) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#333333")];
        NSString *str1 = [LangSwitcher switchLang:@"请在" key:nil];
        NSString *str2 = [LangSwitcher switchLang:@"十分钟" key:nil];
        NSString *str3 = [LangSwitcher switchLang:@"内完成付款" key:nil];
        NSString *allStr = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
        NSMutableAttributedString *PSAttrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
        [PSAttrStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(str1.length,str2.length)];
        PSLbl.attributedText = PSAttrStr;
        [self addSubview:PSLbl];
        
        
        UILabel *PSLbl1 = [UILabel labelWithFrame:CGRectMake(10, PSLbl.yy, SCREEN_WIDTH - 60, 27) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#333333")];
        NSString *str11 = [LangSwitcher switchLang:@"转账请务必填写" key:nil];
        NSString *str21 = [LangSwitcher switchLang:@"转账附言" key:nil];
        NSString *allStr1 = [NSString stringWithFormat:@"%@%@",str11,str21];
        NSMutableAttributedString *PSAttrStr1 = [[NSMutableAttributedString alloc] initWithString:allStr1];
        [PSAttrStr1 addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(str11.length,str21.length)];
        PSLbl1.attributedText = PSAttrStr1;
        [self addSubview:PSLbl1];
        
        
        
        UILabel *IntroductionLbl = [UILabel labelWithFrame:CGRectMake(10, PSLbl1.yy + 13.5, SCREEN_WIDTH - 60, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FA7D0E")];
        IntroductionLbl.text = [LangSwitcher switchLang:@"每天取消3次订单后，24小时内不允许交易" key:nil];
        [self addSubview:IntroductionLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, IntroductionLbl.yy + 15.5, SCREEN_WIDTH - 40, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        
        UIButton *IkonwBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"知道了" key:nil] titleColor:kTabbarColor backgroundColor:kClearColor titleFont:16];
        self.IkonwBtn = IkonwBtn;
        IkonwBtn.titleLabel.font = HGboldfont(16);
        IkonwBtn.frame = CGRectMake(0, lineView.yy , SCREEN_WIDTH - 40, 45);
        [self addSubview:IkonwBtn];
        
        
        
    }
    return self;
}

@end
