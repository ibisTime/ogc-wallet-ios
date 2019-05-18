//
//  EggplantAccountHeadView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "EggplantAccountHeadView.h"

@implementation EggplantAccountHeadView
{
    UILabel *numberLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH - 10, 120)];
        [backImg theme_setImageIdentifier:@"茄子账户背景" moduleName:ImgAddress];
        
        [self addSubview:backImg];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(35, 31, 100, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        nameLbl.text = @"茄子余额";
        [backImg addSubview:nameLbl];
        
        numberLbl = [UILabel labelWithFrame:CGRectMake(35, nameLbl.yy + 9 , 100, 33.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(24) textColor:nil];
        
        NSString *text = @"51个";
        NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeStr addAttribute:NSFontAttributeName
                                     value:FONT(14)
                             range:NSMakeRange(text.length - 1, 1)];
        numberLbl.attributedText = attributeStr;
        [backImg addSubview:numberLbl];
        
        UIButton *exchangeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        exchangeBtn.frame = CGRectMake(SCREEN_WIDTH - 40 - 81, 53, 81, 34);
        [exchangeBtn setTitle:@"去兑换" forState:(UIControlStateNormal)];
        self.exchangeBtn = exchangeBtn;
        [exchangeBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
        exchangeBtn.titleLabel.font = FONT(14);
        kViewRadius(exchangeBtn, 2);
        [self addSubview:exchangeBtn];
        
        
        UILabel *runningWaterLbl = [UILabel labelWithFrame:CGRectMake(15, 140, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        runningWaterLbl.text = @"茄子账户流水";
        [runningWaterLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [backImg addSubview:runningWaterLbl];
        
    }
    return self;
}

-(void)setAmount:(NSString *)amount
{
    NSString *text = [NSString stringWithFormat:@"%.2f个",[amount floatValue]/100];
    NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSFontAttributeName
                         value:FONT(14)
                         range:NSMakeRange(text.length - 1, 1)];
    numberLbl.attributedText = attributeStr;
}

@end
