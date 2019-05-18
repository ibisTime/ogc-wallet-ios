//
//  TLMoneyDetailsHeadView.m
//  Coin
//
//  Created by QinBao Zheng on 2018/9/26.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLMoneyDetailsHeadView.h"

@implementation TLMoneyDetailsHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {




//        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250 - 64 + kNavigationBarHeight)];
//        self.backImage = backImage;
//        backImage.backgroundColor = kTabbarColor;
//        backImage.image = kImage(@"bijiabao");
        
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250 - 64 + kNavigationBarHeight)];
        [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [self addSubview:backView];
//        self.backImage = backView;
        
        //初始化CAGradientlayer对象，使它的大小为UIView的大小
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.frame = backView.bounds;
//
//        //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
//        [backView.layer addSublayer:gradientLayer];
//
//        //设置渐变区域的起始和终止位置（范围为0-1）
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(0, 1);
//
//        //设置颜色数组
//        gradientLayer.colors = @[(__bridge id)kHexColor(@"#4265E0").CGColor,
//                                 (__bridge id)kHexColor(@"#2F49A5").CGColor];
//
//        //设置颜色分割点（范围：0-1）
//        gradientLayer.locations = @[@(0.5f), @(1.0f)];
        
        
        
        
        
//        [self addSubview:backImage];


        UIImageView *backImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 250 - 64 + kNavigationBarHeight - 60, kScreenWidth, 60)];
//        backImage1.image = kImage(@"Rectangle 11");
//        backImage1.backgroundColor = kHexColor(@"#6F81C2");
        [backImage1 theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        backImage1.alpha = 0.5;
        [self addSubview:backImage1];


        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 90 - 64 + kNavigationBarHeight, kScreenWidth, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#FFFFFF")];
        nameLabel.text = [LangSwitcher switchLang:@"预期年化收益率" key:nil];
      
        [self addSubview:nameLabel];

        UILabel *priceLabel =[UILabel labelWithFrame:CGRectMake(15, 116 - 64 + kNavigationBarHeight, kScreenWidth - 30, 45) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(32) textColor:kHexColor(@"#FFFFFF")];
        self.priceLabel = priceLabel;

        [self addSubview:priceLabel];

        NSArray *nameArray = @[@"认购期限",@"剩余额度",@"起购额度"];
        for (int i = 0; i < 3 ; i++) {
            UILabel *numberLabel = [UILabel labelWithFrame:CGRectMake(10 + i % 3 * kScreenWidth/3, 250 - 64 + kNavigationBarHeight - 60 + 11.5, kScreenWidth/3 - 20, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#FFFFFF")];
            numberLabel.tag = 1000 + i;

//            numberLabel.text = @"300 ETH";
            [self addSubview:numberLabel];

            UILabel *contactLabel = [UILabel labelWithFrame:CGRectMake(10 + i % 3 * kScreenWidth/3, 250 - 64 + kNavigationBarHeight - 60 + 33.5, kScreenWidth/3 - 20, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#FFFFFF")];
            contactLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
//            contactLabel.alpha = 0.7;

            [self addSubview:contactLabel];
        }
    }

    return self;
}

-(void)setMoneyModel:(TLtakeMoneyModel *)moneyModel
{

    NSString *str = [NSString stringWithFormat:@"+%.2f%%",[moneyModel.expectYield floatValue]*100];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font = [UIFont systemFontOfSize:24];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(str.length - 4,4
                                                                              )];
    self.priceLabel.attributedText = attrString;

    UILabel *label1 = [self viewWithTag:1000];
    UILabel *label2 = [self viewWithTag:1001];
    UILabel *label3 = [self viewWithTag:1002];
    label1.text = [NSString stringWithFormat:@"%@%@",moneyModel.limitDays,[LangSwitcher switchLang:@"天" key:nil]];

    NSString *avilAmount = [CoinUtil convertToRealCoin:moneyModel.avilAmount coin:moneyModel.symbol];
    if ([avilAmount floatValue] > 10000) {
        label2.text = [NSString stringWithFormat:@"%.2f万 %@",[avilAmount floatValue]/10000,moneyModel.symbol];
    }
    else
    {
        label2.text = [NSString stringWithFormat:@"%.2f %@",[avilAmount floatValue],moneyModel.symbol];
    }

    NSString *minAmount = [CoinUtil convertToRealCoin:moneyModel.minAmount coin:moneyModel.symbol];

    if ([minAmount floatValue] > 10000) {
        label3.text = [NSString stringWithFormat:@"%.2f万 %@",[minAmount floatValue]/10000,moneyModel.symbol];
    }
    else
    {
        label3.text = [NSString stringWithFormat:@"%.2f %@",[minAmount floatValue],moneyModel.symbol];
    }




}

@end
