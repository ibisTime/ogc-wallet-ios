//
//  PayWayCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PayWayCell.h"

@implementation PayWayCell
{
    UILabel *instructionsLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = kBackgroundColor;
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2 - 15, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#666666")];
        nameLabel.text = [LangSwitcher switchLang:@"支付方式" key:nil];
        self.nameLabel = nameLabel;
        [backView addSubview:nameLabel];
        
        _payBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"支付宝" key:nil] titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:14];
        _payBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2 - 34, 50);
        _payBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [backView addSubview:_payBtn];
        [_payBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"支付宝支付") forState:(UIControlStateNormal)];
        }];
        
        
        
        UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 7.5 - 18, 18.5, 7.5, 13)];
        youImg.image = kImage(@"更多-灰色");
        [backView addSubview:youImg];
        
        instructionsLbl = [UILabel labelWithFrame:CGRectMake(15, backView.yy + 14, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        instructionsLbl.text = [LangSwitcher switchLang:@"说明：单笔交易限额0.00" key:nil];
        [self addSubview:instructionsLbl];
        
        
        
        
    }
    return self;
}

-(void)setBiggestLimit:(NSString *)biggestLimit
{
    if ([biggestLimit floatValue] > 10000) {
        instructionsLbl.text = [NSString stringWithFormat:@"说明：单笔交易限额%.f万元",[biggestLimit floatValue]/10000];
    }else
    {
        instructionsLbl.text = [NSString stringWithFormat:@"说明：单笔交易限额%@元",biggestLimit];
    }
    
}

-(void)setPayWayDic:(NSDictionary *)payWayDic
{
    if ([payWayDic[@"name"] isEqualToString:@"支付宝"]) {
        [_payBtn setTitle:[LangSwitcher switchLang:@"支付宝" key:nil] forState:(UIControlStateNormal)];
        [_payBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"支付宝支付") forState:(UIControlStateNormal)];
        }];
    }else if([payWayDic[@"name"] isEqualToString:@"银行卡"])
    {
        [_payBtn setTitle:[LangSwitcher switchLang:@"银行卡" key:nil] forState:(UIControlStateNormal)];
        [_payBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"银行卡支付") forState:(UIControlStateNormal)];
        }];
    }else
    {
        [_payBtn setTitle:[LangSwitcher switchLang:@"" key:nil] forState:(UIControlStateNormal)];
        [_payBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"") forState:(UIControlStateNormal)];
        }];
    }
    
}

@end
