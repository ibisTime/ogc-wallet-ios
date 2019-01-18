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
//    UILabel *allPriceLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 148 - 64 + kNavigationBarHeight)];
        topImage.image = kImage(@"Mask");
        [self addSubview:topImage];
        
        
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 44)];
        nameLable.text = [LangSwitcher switchLang:@"我的资产" key:nil];
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.font = Font(18);
        nameLable.textColor = kWhiteColor;
        [self addSubview:nameLable];
        
        
        UIImageView *whiteView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 87 - 64 + kNavigationBarHeight - 10, SCREEN_WIDTH - 10 , 180)];
//        我的资产背景
        whiteView.image = kImage(@"我的资产背景背景");
        [self addSubview:whiteView];
        
        
//        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(35, 48, 11, 12)];
//        iconImg.image = kImage(@"");
//        [whiteView addSubview:iconImg];
        
        UIButton *allAssetsBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"总资产" key:nil] titleColor:[UIColor blackColor] backgroundColor:kClearColor titleFont:12];
        allAssetsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        allAssetsBtn.frame = CGRectMake(35, 48 + 5, SCREEN_WIDTH - 80, 14);
        [allAssetsBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:4 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"转出") forState:(UIControlStateNormal)];
        }];
        [whiteView addSubview:allAssetsBtn];
        
        
        allAssetsLbl = [UILabel labelWithFrame:CGRectMake(35, allAssetsBtn.yy + 20, SCREEN_WIDTH - 80, 32) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(32) textColor:kTabbarColor];
        allAssetsLbl.text = @"≈0.00 CNY";
        [whiteView addSubview:allAssetsLbl];
        
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    if ([[TLUser user].localMoney isEqualToString:@"USD"])
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f USD", [[dataDic[@"totalAmountUSD"] convertToSimpleRealMoney] doubleValue]];
    }
    else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f KRW", [[dataDic[@"totalAmountKRW"] convertToSimpleRealMoney] doubleValue]];
    }
    else
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f CNY", [[dataDic[@"totalAmountCNY"] convertToSimpleRealMoney] doubleValue]];
    }
}

@end
