//
//  MoneyAndTreasureHeadView.m
//  Coin
//
//  Created by QinBao Zheng on 2018/9/29.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "MoneyAndTreasureHeadView.h"

@implementation MoneyAndTreasureHeadView
{
//    NSDictionary *dic;
    UILabel *earningsPrice1;
    UILabel *earningsPrice2;
    NSString *symbolStr;
    
    NSString *YesterdayInvest;
    NSString *TotalIncome;
    NSString *TotalInvest;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240 - 64 + kNavigationBarHeight)];
        [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [self addSubview:backView];
        


        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 90 - 64 + kNavigationBarHeight, kScreenWidth, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#FFFFFF")];
        nameLabel.text = [LangSwitcher switchLang:@"投资总额" key:nil];
        [self addSubview:nameLabel];


        UIButton *eyesButton = [UIButton buttonWithTitle:@"BTC" titleColor:nil backgroundColor:kClearColor titleFont:32];
        [eyesButton theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
        
        eyesButton.frame = CGRectMake(15, nameLabel.yy + 6, kScreenWidth - 30, 45);
        NSString *eyesWhetherhide = [[NSUserDefaults standardUserDefaults] objectForKey:@"eyesWhetherhide"];
        if ([eyesWhetherhide isEqualToString:@"闭眼"]) {
            eyesButton.selected = YES;
            [eyesButton setTitle:@"--" forState:(UIControlStateNormal)];
        }else
        {
            [eyesButton setTitle:@"--" forState:(UIControlStateNormal)];
            eyesButton.selected = NO;
        }
        [eyesButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:11 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"眼睛") forState:(UIControlStateNormal)];
            [button setImage:kImage(@"闭眼-白") forState:(UIControlStateSelected)];
        }];

        
        [eyesButton addTarget:self action:@selector(eyesButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        self.eyesButton = eyesButton;
        [self addSubview:eyesButton];
        
        
        NSArray *earningsNameAry = @[@"昨日收益",@"累计收益"];
        for (int i = 0; i < 2; i ++) {
            UILabel *earningsName = [UILabel labelWithFrame:CGRectMake(i%2*SCREEN_WIDTH/2, eyesButton.yy + 20, SCREEN_WIDTH/2, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kWhiteColor];
            earningsName.text = [LangSwitcher switchLang:earningsNameAry[i] key:nil];
            [self addSubview:earningsName];
            
            UILabel *earningsPrice = [UILabel labelWithFrame:CGRectMake(i%2*SCREEN_WIDTH/2, earningsName.yy + 3, SCREEN_WIDTH/2, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:kWhiteColor];
            earningsPrice.text = @"--";
            [self addSubview:earningsPrice];
            
            if (i == 0) {
                earningsPrice1 = earningsPrice;
                
            }else
            {
                earningsPrice2 = earningsPrice;
            }
        }
    }
    return self;
}

-(void)eyesButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [[NSUserDefaults standardUserDefaults]setObject:@"闭眼" forKey:@"eyesWhetherhide"];
    }else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"张眼" forKey:@"eyesWhetherhide"];
    }

    
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    NSString *str = [numberFormatter stringFromNumber:dic[@"totalInvest"]];
//    totalInvest = [CoinUtil convertToRealCoin2:str setScale:4 coin:symbolStr];
    //    self.eyesButton.backgroundColor = [UIColor redColor];
    NSString *eyesWhetherhide = [[NSUserDefaults standardUserDefaults] objectForKey:@"eyesWhetherhide"];
    if ([eyesWhetherhide isEqualToString:@"闭眼"]) {
        [self.eyesButton setTitle:[NSString stringWithFormat:@"**** %@",symbolStr] forState:(UIControlStateNormal)];
        earningsPrice1.text = [NSString stringWithFormat:@"**** %@",symbolStr];
        earningsPrice2.text = [NSString stringWithFormat:@"**** %@",symbolStr];
    }else
    {
        [self.eyesButton setTitle:[NSString stringWithFormat:@"%@ %@",TotalInvest,symbolStr] forState:(UIControlStateNormal)];
        earningsPrice1.text = [NSString stringWithFormat:@"%@ %@",YesterdayInvest,symbolStr];
        earningsPrice2.text = [NSString stringWithFormat:@"%@ %@",TotalIncome,symbolStr];
    }
    [self.eyesButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:15 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"张眼") forState:(UIControlStateNormal)];
        [button setImage:kImage(@"闭眼-白") forState:(UIControlStateSelected)];
    }];
}

-(void)setSymbol:(NSString *)symbol
{
    symbolStr = symbol;
}

-(void)setDataDic:(NSDictionary *)dataDic
{

    YesterdayInvest = [CoinUtil convertToRealCoin2: dataDic[@"yesterdayIncome"] setScale:4 coin:@"USDT"];
    
    
    NSString *eyesWhetherhide = [[NSUserDefaults standardUserDefaults] objectForKey:@"eyesWhetherhide"];
    if ([eyesWhetherhide isEqualToString:@"闭眼"]) {
        
        earningsPrice1.text = [NSString stringWithFormat:@"**** %@",symbolStr];
    }else
    {
        earningsPrice1.text = [NSString stringWithFormat:@"%@ %@",YesterdayInvest,symbolStr];
    }




}


-(void)setDataDic1:(NSDictionary *)dataDic1
{
//    dic = dataDic;
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *usdtTotalIncomeStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic1[@"usdtTotalIncome"]] setScale:4 coin:@"USDT"];
//    usdtTotalIncome.text = usdtTotalIncomeStr;
    
    NSString *usdtTotalInvestStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic1[@"usdtTotalInvest"]] setScale:4 coin:@"USDT"];
//    usdtTotalInvest.text = usdtTotalInvestStr;
    
    
    NSString *btcTotalIncomeStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic1[@"btcTotalIncome"]] setScale:4 coin:@"BTC"];
//    btcTotalIncome.text = btcTotalIncomeStr;
    
    
    NSString *btcTotalInvestStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic1[@"btcTotalInvest"]] setScale:4 coin:@"BTC"];
//    btcTotalInvest.text = btcTotalInvestStr;

    if ([symbolStr isEqualToString:@"BTC"]) {
        TotalIncome = btcTotalIncomeStr;
        TotalInvest = btcTotalInvestStr;
    }else
    {
        TotalIncome = usdtTotalIncomeStr;
        TotalInvest = usdtTotalInvestStr;
    }
    
    NSString *eyesWhetherhide = [[NSUserDefaults standardUserDefaults] objectForKey:@"eyesWhetherhide"];
    if ([eyesWhetherhide isEqualToString:@"闭眼"]) {
        [self.eyesButton setTitle:[NSString stringWithFormat:@"**** %@",symbolStr] forState:(UIControlStateNormal)];

        earningsPrice1.text = [NSString stringWithFormat:@"**** %@",symbolStr];
        earningsPrice2.text = [NSString stringWithFormat:@"**** %@",symbolStr];
    }else
    {

        [self.eyesButton setTitle:[NSString stringWithFormat:@"%@ %@",TotalInvest,symbolStr] forState:(UIControlStateNormal)];
        earningsPrice2.text = [NSString stringWithFormat:@"%@ %@",TotalIncome,symbolStr];
    }
    
    [self.eyesButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:15 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"张眼") forState:(UIControlStateNormal)];
        [button setImage:kImage(@"闭眼-白") forState:(UIControlStateSelected)];
    }];
}

@end
