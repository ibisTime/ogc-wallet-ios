//
//  MarketDetaiilsHeadView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MarketDetaiilsHeadView.h"

@implementation MarketDetaiilsHeadView
{
    UIButton *selectBtn;
    UIView *bottomView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(15, 30, 150, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(24) textColor:nil];
        priceLbl.text = @"¥ 30,123.34";
        [self addSubview:priceLbl];
        
        
        UILabel *proportionLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 70, 30, 70, 30)];
        proportionLbl.text = @"+0.99%";
        proportionLbl.textAlignment = NSTextAlignmentCenter;
        proportionLbl.backgroundColor = kHexColor(@"#C93D3D");
        proportionLbl.font = FONT(14);
        proportionLbl.textColor = kWhiteColor;
        kViewRadius(proportionLbl, 2);
        [self addSubview:proportionLbl];
        
        UILabel *numberLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - proportionLbl.width - 30 , 30, 0, 30)];
        numberLbl.text = @"311.85";
        numberLbl.textAlignment = NSTextAlignmentCenter;
        numberLbl.textColor = kHexColor(@"#C93D3D");
        numberLbl.font = FONT(14);
        [self addSubview:numberLbl];
        
        [numberLbl sizeToFit];
        numberLbl.frame = CGRectMake(SCREEN_WIDTH - proportionLbl.width - 30 - numberLbl.width, 30, numberLbl.width, 30);
        priceLbl.frame = CGRectMake(15, 30, SCREEN_WIDTH - numberLbl.width - proportionLbl.width - 60, 30);
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
        NSArray *array1 = @[@"6,316.70亿",@"16.70亿",@"16.70万",@"16.70万"];
        NSArray *array2 = @[@"市值(CNY)",@"24H成交额",@"流通量",@"发行总量"];
        for (int i = 0; i < 4; i ++) {
            UILabel *moneyLbl = [UILabel labelWithFrame:CGRectMake(0 + i % 4 * SCREEN_WIDTH/4, lineView.yy + 16, SCREEN_WIDTH/4, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
            moneyLbl.text = array1[i];
            [self addSubview:moneyLbl];
            
            UILabel *moneyNameLbl = [UILabel labelWithFrame:CGRectMake(0 + i % 4 * SCREEN_WIDTH/4, moneyLbl.yy + 6, SCREEN_WIDTH/4, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(11) textColor:nil];
            moneyNameLbl.text = array2[i];
            [moneyNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            [self addSubview:moneyNameLbl];
            
        }
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 10)];
        [lineView1 theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [self addSubview:lineView1];
        
        
        UILabel *movementsLbl = [UILabel labelWithFrame:CGRectMake(15, lineView1.yy , 150, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        movementsLbl.text = @"实时走势";
        [self addSubview:movementsLbl];
        
        
        _smoothView = [[SmoothChartView1 alloc] initWithFrame:CGRectMake(15, 200, SCREEN_WIDTH - 30,200)];
        [_smoothView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [self addSubview:_smoothView];
        [_smoothView refreshChartAnmition];

        CGFloat maxPrice = 100;
        CGFloat minPrice = 0;
        
        NSArray *arrayX = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        NSArray *arrayY = @[@"23",@"44",@"56",@"1",@"32",@"57",@"88",@"88",@"49"];
        
        _smoothView.arrY = @[@"0",@"20",@"40",@"80",@"100"];
        [_smoothView drawSmoothViewWithArrayX:arrayX andArrayY:arrayY andScaleX:100 andScalemax:100 andScalemin:0];
        [_smoothView refreshChartAnmition];
        
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 430, SCREEN_WIDTH, 10)];
        [lineView2 theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [self addSubview:lineView2];
        
        
        UIButton *marketBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        marketBtn.frame = CGRectMake(12, lineView2.yy + 15, 50, 25);
        [marketBtn setTitle:@"行情" forState:(UIControlStateNormal)];
        marketBtn.titleLabel.font = FONT(16);
        [marketBtn theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateSelected) moduleName:ColorName];
        [marketBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
        marketBtn.selected = YES;
        [marketBtn addTarget:self action:@selector(marketBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        marketBtn.tag = 100;
        selectBtn = marketBtn;
        
        [self addSubview:marketBtn];
        
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(marketBtn.centerX - 12.5, marketBtn.yy + 4, 25, 2)];
        [bottomView theme_setBackgroundColorIdentifier:LabelColor moduleName:ColorName];
        [self addSubview:bottomView];
        
        UIButton *briefBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        briefBtn.frame = CGRectMake(marketBtn.xx + 15, lineView2.yy + 15, 50, 25);
        [briefBtn setTitle:@"简况" forState:(UIControlStateNormal)];
        [briefBtn theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateSelected) moduleName:ColorName];
        [briefBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
        [briefBtn addTarget:self action:@selector(marketBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        briefBtn.titleLabel.font = FONT(16);
        briefBtn.tag = 101;
        [self addSubview:briefBtn];
        
    }
    
    
    
    return self;
}

-(void)marketBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    selectBtn = sender;
    [UIView animateWithDuration:0.4 animations:^{
        bottomView.frame = CGRectMake(sender.centerX - 12.5, sender.yy + 4, 25, 2);
    }];
    
    [_delegate MarketDetaiilsHeadButton:sender];
    
}

@end
