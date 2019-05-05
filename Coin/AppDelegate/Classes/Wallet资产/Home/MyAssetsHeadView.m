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
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 33.5)];
        nameLable.text = [LangSwitcher switchLang:@"零用钱包" key:nil];
        
        nameLable.textAlignment = NSTextAlignmentLeft;
        self.nameLable = nameLable;
        nameLable.font = Font(24);
        [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        [self addSubview:nameLable];
        
        
        UIButton *SwitchPurse = [UIButton buttonWithTitle:@"" titleColor:kClearColor backgroundColor:kClearColor titleFont:10];
        SwitchPurse.frame = CGRectMake(SCREEN_WIDTH - 55, 15, 46, 34);
//        [SwitchPurse SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:4 imagePositionBlock:^(UIButton *button) {
//            [button theme_setImageIdentifier:@"钱包切换" forState:(UIControlStateNormal) moduleName:ImgAddress];
//        }];
        [self addSubview:SwitchPurse];
        
        
        UIImageView *switchImg = [[UIImageView alloc]initWithFrame:CGRectMake(16, 0, 18, 18)];
        [switchImg theme_setImageIdentifier:@"钱包切换" moduleName:ImgAddress];
        [SwitchPurse addSubview:switchImg];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, 22, 45, 12) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(10) textColor:nil];
        nameLbl.text = @"钱包切换";
        [nameLbl theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        [SwitchPurse addSubview:nameLbl];
        
        UIImageView *whiteView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 64, SCREEN_WIDTH - 10 , 170)];
//        我的资产背景
        [whiteView theme_setImageIdentifier:@"零用钱包背景" moduleName:ImgAddress];
        [self addSubview:whiteView];
        
        UIButton *allAssetsBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"零用钱包 总资产（¥）" key:nil] titleColor:[UIColor blackColor] backgroundColor:kClearColor titleFont:12];
        allAssetsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        allAssetsBtn.frame = CGRectMake(35, 44, SCREEN_WIDTH - 80, 20);
        
        [whiteView addSubview:allAssetsBtn];
        
        
        allAssetsLbl = [UILabel labelWithFrame:CGRectMake(35, 80, SCREEN_WIDTH - 80, 41) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(41) textColor:kTabbarColor];
         if ([[TLUser user].localMoney isEqualToString:@"USD"])
         {
             allAssetsLbl.text = @"≈0.00";
         }else
         {
             allAssetsLbl.text = @"≈0.00";
         }
        
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
