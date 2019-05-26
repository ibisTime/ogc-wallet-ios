//
//  InviteEarningCell.m
//  Coin
//
//  Created by QinBao Zheng on 2018/10/9.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "InviteEarningCell.h"

@implementation InviteEarningCell
{
    CAGradientLayer *layer;
    UILabel *stateLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {



        self.mobile = [UIButton buttonWithTitle:@"" titleColor:kHexColor(@"#333333") backgroundColor:kClearColor titleFont:15];
        self.mobile.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:self.mobile];


        self.priceLabel = [UILabel labelWithFrame:CGRectMake(self.mobile.xx + 10, 0, (SCREEN_WIDTH - stateLabel.xx - 6 - 10 - 15)/2, 60) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#333333")];
        [self addSubview:self.priceLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59, SCREEN_WIDTH - 30, 0.5)];
//        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];


    }
    return self;
}

-(void)setModel:(InviteEarningsModel *)model
{
    NSString *transAmountString = [CoinUtil convertToRealCoin:model.transAmountString  coin:model.currency];
    if ([transAmountString floatValue] >= 0) {
        self.priceLabel.text = [NSString stringWithFormat:@"+%@ %@",transAmountString,model.currency];
    }else
    {
        self.priceLabel.text = [NSString stringWithFormat:@"%@ %@",transAmountString,model.currency];
    }
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(SCREEN_WIDTH - self.priceLabel.frame.size.width - 15, 0, self.priceLabel.frame.size.width, 60);


    self.mobile.frame = CGRectMake(15, 0, SCREEN_WIDTH - self.priceLabel.frame.size.width - 15 - 10, 60);



    LangType type = [LangSwitcher currentLangType];

    if ([model.bizType isEqualToString:@"jf_lottery_in"])
    {
        [self.mobile setTitle:model.bizNote forState:(UIControlStateNormal)];
        if (type == LangTypeSimple || type == LangTypeTraditional) {
            [self.mobile SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"抽奖中文") forState:(UIControlStateNormal)];
            }];
        }else if (type == LangTypeKorean)
        {
            [self.mobile SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"抽奖韩文") forState:(UIControlStateNormal)];
            }];


        }else{
            [self.mobile SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"抽奖英文") forState:(UIControlStateNormal)];
            }];
        }
    }else if ([model.bizType isEqualToString:@"invite_income_pop_in"])
    {


        [self.mobile setTitle:model.refUserMobile forState:(UIControlStateNormal)];
        if (type == LangTypeSimple || type == LangTypeTraditional) {
            [self.mobile SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"量化中文") forState:(UIControlStateNormal)];
            }];
        }else if (type == LangTypeKorean)
        {
            [self.mobile SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"量化韩文") forState:(UIControlStateNormal)];
            }];


        }else{
            [self.mobile SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"量化英文") forState:(UIControlStateNormal)];
            }];
        }
    }


}


@end
