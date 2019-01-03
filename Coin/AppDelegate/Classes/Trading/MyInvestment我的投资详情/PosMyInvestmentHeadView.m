//
//  PosMyInvestmentHeadView.m
//  Coin
//
//  Created by QinBao Zheng on 2018/9/26.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "PosMyInvestmentHeadView.h"

@implementation PosMyInvestmentHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *nameArr = @[@"BTC",@"USDT"];
        for (int i = 0; i < 2; i ++) {
            
        }
        

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 104, SCREEN_WIDTH - 30, 0.5)];
        lineView.backgroundColor = kHexColor(@"#BAC1C8");
        [self addSubview:lineView];

        

//        NSArray *priceArray = @[@"99.900(BTC)",@"900.00(BTC)"];
        for (int i = 0; i < 2; i ++) {
            
            
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 20.5 + i %2 * 105, 50, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kWhiteColor];
            nameLabel.text = nameArr[i];
            [self addSubview:nameLabel];
            
            
            
            UILabel *allPriceName = [UILabel labelWithFrame:CGRectMake(78, 23.5 + i %2 * 105, (SCREEN_WIDTH - 78)/2, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kWhiteColor];
            allPriceName.text = [LangSwitcher switchLang:@"投资总资产" key:nil];
            [self addSubview:allPriceName];
            
            
            UILabel *allPrice = [UILabel labelWithFrame:CGRectMake(78, allPriceName.yy + 6, (SCREEN_WIDTH - 78)/2, 33.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(24) textColor:kWhiteColor];
            allPrice.text = [LangSwitcher switchLang:@"0.00" key:nil];
            [self addSubview:allPrice];
            
            
            
            UIButton *earningsButton = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"累计收益" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12];
            self.earningsButton = earningsButton;
            self.earningsButton.frame = CGRectMake(78 + (SCREEN_WIDTH - 78)/2, 23.5 + i %2 * 105, (SCREEN_WIDTH - 78)/2, 16.5);
            earningsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.earningsButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"更多白色") forState:(UIControlStateNormal)];
            }];
            [self addSubview:earningsButton];
            
            
            UILabel *earningsPrice = [UILabel labelWithFrame:CGRectMake(78 + (SCREEN_WIDTH - 78)/2, self.earningsButton.yy + 6, (SCREEN_WIDTH - 78)/2, 33.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(24) textColor:kWhiteColor];
            earningsPrice.text = [LangSwitcher switchLang:@"0.00" key:nil];
            [self addSubview:earningsPrice];
            
            
            
            self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.backButton.frame = CGRectMake(78 + (SCREEN_WIDTH - 78)/2, 0 + i %2 * 105, SCREEN_WIDTH/2, 105);
            [self addSubview:self.backButton];
            
//            UILabel *peiceLabel = [UILabel labelWithFrame:CGRectMake(0 + i %2 * SCREEN_WIDTH/2,  47, SCREEN_WIDTH/2, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(30) textColor:kWhiteColor];
//
//            peiceLabel.tag = 1212 + i;
//
//            if (i == 0) {
//                peiceLabel.frame = CGRectMake(SCREEN_WIDTH/4 - peiceLabel.frame.size.width/2,  40, peiceLabel.frame.size.width, 30);
//
//                UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(peiceLabel.frame.origin.x, 15 , peiceLabel.frame.size.width, 18) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kWhiteColor];
//                nameLabel.text = [LangSwitcher switchLang:@"投资总资产" key:nil];
//                self.nameLabel = nameLabel;
//                nameLabel.alpha = 0.6;
//                [self addSubview:nameLabel];
//
//
//            }else
//            {
//                peiceLabel.frame = CGRectMake(SCREEN_WIDTH/4*3 - peiceLabel.frame.size.width/2,  40, peiceLabel.frame.size.width, 30);
//
//
//
//
//            }

//            [self addSubview:peiceLabel];
        }

    }
    return self;
}



-(void)setDataDic:(NSDictionary *)dataDic
{
    NSLog(@"%@",dataDic);
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    NSString *totalInvest = [CoinUtil convertToRealCoin2:  [numberFormatter stringFromNumber:dataDic[@"totalInvest"]] setScale:4 coin:@"BTC"];
//
//    UILabel *label1 = [self viewWithTag:1212];
//
//    NSString *label1Str = [NSString stringWithFormat:@"%@ (BTC)",totalInvest];
//
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:label1Str];
//    [attrString addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(label1Str.length - 5,5)];
//    label1.attributedText = attrString;
//
//    [label1 sizeToFit];
//
//    if (label1.frame.size.width > SCREEN_WIDTH/2 - 20) {
//        label1.frame = CGRectMake(10,  40, SCREEN_WIDTH/2 - 20, 30);
//    }else
//    {
//        label1.frame = CGRectMake(SCREEN_WIDTH/4 - label1.frame.size.width/2,  40, label1.frame.size.width, 30);
//    }
//
//
//    self.nameLabel.frame = CGRectMake(label1.frame.origin.x, 15 , SCREEN_WIDTH/2 - label1.frame.origin.x - 10, 18);
//
//
//
//
//    NSNumberFormatter *numberFormatter1 = [[NSNumberFormatter alloc] init];
//    NSString *totalIncome = [CoinUtil convertToRealCoin2:[numberFormatter1 stringFromNumber:dataDic[@"totalIncome"]] setScale:4 coin:@"BTC"];
//
//    UILabel *label2 = [self viewWithTag:1213];
//    NSString *label2Str = [NSString stringWithFormat:@"%@ (BTC)",totalIncome];
//    NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:label2Str];
//    [attrString1 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(label2Str.length - 5,5)];
//    label2.attributedText = attrString1;
//    [label2 sizeToFit];


//    if (label2.frame.size.width > SCREEN_WIDTH/2 - 20) {
//        label2.frame = CGRectMake(10 + SCREEN_WIDTH/2,  40, SCREEN_WIDTH/2 - 20, 30);
//    }else
//    {
//        label2.frame = CGRectMake(SCREEN_WIDTH/4*3 - label2.frame.size.width/2,  40, label2.frame.size.width, 30);
//    }


//    self.earningsButton.frame = CGRectMake(label2.frame.origin.x, 15 , SCREEN_WIDTH - label2.frame.origin.x - 10, 18);
//    [self.earningsButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
//        [button setImage:kImage(@"更多白色") forState:(UIControlStateNormal)];
//    }];



}

@end
