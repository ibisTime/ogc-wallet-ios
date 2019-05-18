//
//  SwitchPurseHeadView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/6.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SwitchPurseHeadView.h"

@implementation SwitchPurseHeadView
{
    UILabel *allAssetsLbl;
    //    UILabel *allPriceLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self theme_setBackgroundColorIdentifier:TableViewColor moduleName:ColorName];
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 33.5)];
        nameLable.text = [LangSwitcher switchLang:@"我的钱包" key:nil];
        
        nameLable.textAlignment = NSTextAlignmentLeft;
        self.nameLable = nameLable;
        nameLable.font = Font(24);
//        nameLable.textColor = kTextColor;
//        nameLable.nightTextColor = kNightTextColor;
        [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        [self addSubview:nameLable];
        
        
        
        
        
        
        UIImageView *whiteView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 64, SCREEN_WIDTH - 10 , 170)];
        //        我的资产背景
        [whiteView theme_setImageIdentifier:@"零用钱包背景" moduleName:ImgAddress];
        [self addSubview:whiteView];
        
        
        
        
        allAssetsLbl = [UILabel labelWithFrame:CGRectMake(35, 44, SCREEN_WIDTH - 80, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        allAssetsLbl.text= [LangSwitcher switchLang:@"零用钱包 总资产（¥）" key:nil];
        [whiteView addSubview:allAssetsLbl];
        
        
        allAssetsLbl = [UILabel labelWithFrame:CGRectMake(35, 80, SCREEN_WIDTH - 80, 41) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(41) textColor:kTabbarColor];
        if ([[TLUser user].localMoney isEqualToString:@"USD"])
        {
            allAssetsLbl.text = @"≈0.00";
        }else
        {
            allAssetsLbl.text = @"≈0.00";
        }
        
        [whiteView addSubview:allAssetsLbl];
        
        
        _SwitchPurse = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _SwitchPurse.frame = self.frame;
        [self addSubview:_SwitchPurse];
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    if ([[TLUser user].localMoney isEqualToString:@"USD"])
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f", [[dataDic[@"totalAmountUSD"] convertToSimpleRealMoney] doubleValue]];
    }
    else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f", [[dataDic[@"totalAmountKRW"] convertToSimpleRealMoney] doubleValue]];
    }
    else
    {
        allAssetsLbl.text = [NSString stringWithFormat:@"≈%.2f", [[dataDic[@"totalAmountCNY"] convertToSimpleRealMoney] doubleValue]];
    }
}

@end
