//
//  MyAssetsHeadView.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "MyAssetsHeadView.h"

@implementation MyAssetsHeadView
{
    UILabel *allAssetsLbl;
    UILabel *allPriceLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140 + kStatusBarHeight)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 44)];
        nameLable.text = [LangSwitcher switchLang:@"我的资产" key:nil];
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.font = Font(16);
        nameLable.textColor = kWhiteColor;
        [self addSubview:nameLable];
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, kStatusBarHeight + 75, SCREEN_WIDTH - 40, 170)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        
        
        UIButton *allAssetsBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"总资产" key:nil] titleColor:[UIColor blackColor] backgroundColor:kClearColor titleFont:15];
        allAssetsBtn.frame = CGRectMake(0, 35, SCREEN_WIDTH - 40, 20);
        [allAssetsBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:4 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"账单") forState:(UIControlStateNormal)];
        }];
        [whiteView addSubview:allAssetsBtn];
        
        
        allAssetsLbl = [UILabel labelWithFrame:CGRectMake(0, allAssetsBtn.yy + 10, SCREEN_WIDTH - 40, 40) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(40) textColor:RGB(54, 73, 198)];
        allAssetsLbl.text = @"0.00";
        [whiteView addSubview:allAssetsLbl];
        
        allPriceLbl = [UILabel labelWithFrame:CGRectMake(0, allAssetsLbl.yy + 10, SCREEN_WIDTH - 40, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(12) textColor:kTextColor2];
        allPriceLbl.text = @"";
        [whiteView addSubview:allPriceLbl];
        
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    if ([[TLUser user].localMoney isEqualToString:@"USD"])
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f", [[dataDic[@"totalAmountUSD"] convertToSimpleRealMoney] doubleValue]];
        allPriceLbl.text = @"（USD）";
    }
    else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f", [[dataDic[@"totalAmountKRW"] convertToSimpleRealMoney] doubleValue]];
        allPriceLbl.text = @"（KRW）";
    }
    else
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f", [[dataDic[@"totalAmountCNY"] convertToSimpleRealMoney] doubleValue]];
        allPriceLbl.text = @"（CNY）";
    }
}

@end
