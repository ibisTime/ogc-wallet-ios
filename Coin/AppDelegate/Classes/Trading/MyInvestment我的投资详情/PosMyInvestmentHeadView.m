//
//  PosMyInvestmentHeadView.m
//  Coin
//
//  Created by QinBao Zheng on 2018/9/26.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "PosMyInvestmentHeadView.h"

@implementation PosMyInvestmentHeadView
{
    UILabel *btcTotalInvest;
    UILabel *btcTotalIncome;
    
    UILabel *usdtTotalInvest;
    UILabel *usdtTotalIncome;
    
}
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
            
            if (i == 0) {
                btcTotalInvest = allPrice;
            }else
            {
                usdtTotalInvest = allPrice;
            }
            
            UIButton *earningsButton = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"累计收益" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12];
            self.earningsButton = earningsButton;
            self.earningsButton.frame = CGRectMake(78 + (SCREEN_WIDTH - 78)/2, 23.5 + i %2 * 105, (SCREEN_WIDTH - 78)/2, 16.5);
            earningsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.earningsButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(@"更多白色") forState:(UIControlStateNormal)];
            }];
            [self.earningsButton addTarget:self action:@selector(earningsButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            self.earningsButton.tag = 100 + i;
            [self addSubview:earningsButton];
            
            
            UILabel *earningsPrice = [UILabel labelWithFrame:CGRectMake(78 + (SCREEN_WIDTH - 78)/2, self.earningsButton.yy + 6, (SCREEN_WIDTH - 78)/2, 33.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(24) textColor:kWhiteColor];
            earningsPrice.text = [LangSwitcher switchLang:@"0.00" key:nil];
            [self addSubview:earningsPrice];
            
            if (i == 0) {
                btcTotalIncome = earningsPrice;
            }else
            {
                usdtTotalIncome = earningsPrice;
            }
            
            self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.backButton.frame = CGRectMake(78 + (SCREEN_WIDTH - 78)/2, 0 + i %2 * 105, SCREEN_WIDTH/2, 105);
            self.backButton.tag = 100 + i;
            [self.backButton addTarget:self action:@selector(earningsButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:self.backButton];

        }

    }
    return self;
}

-(void)earningsButtonClick:(UIButton *)sender
{
    [_delegate PosMyInvestmentButton:sender.tag  - 100];
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    NSLog(@"%@",dataDic);
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *usdtTotalIncomeStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic[@"usdtTotalIncome"]] setScale:4 coin:@"USDT"];
    usdtTotalIncome.text = usdtTotalIncomeStr;

    NSString *usdtTotalInvestStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic[@"usdtTotalInvest"]] setScale:4 coin:@"USDT"];
    usdtTotalInvest.text = usdtTotalInvestStr;

    
    NSString *btcTotalIncomeStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic[@"btcTotalIncome"]] setScale:4 coin:@"BTC"];
    btcTotalIncome.text = btcTotalIncomeStr;

    
    NSString *btcTotalInvestStr = [CoinUtil convertToRealCoin2: [numberFormatter stringFromNumber:dataDic[@"btcTotalInvest"]] setScale:4 coin:@"BTC"];
    btcTotalInvest.text = btcTotalInvestStr;
    
}

@end
