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
    UIImageView *youImg;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = kTableViewColor;
//        self.nightBackgroundColor = kNightTableViewColor;
        
        
        
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 33.5)];
        nameLable.text = [LangSwitcher switchLang:@"零用钱包" key:nil];
        
        nameLable.textAlignment = NSTextAlignmentLeft;
        self.nameLable = nameLable;
        nameLable.font = Font(24);
        [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        [self addSubview:nameLable];
        
        
        
        UIImageView *switchImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 55 + 16, 15, 18, 18)];
        [switchImg theme_setImageIdentifier:@"钱包切换" moduleName:ImgAddress];
        [self addSubview:switchImg];
        
        
        
        
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 55,15 + 22, 45, 12) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(10) textColor:nil];
        nameLbl.text = @"钱包切换";
        [self addSubview:nameLbl];
        
        UIButton *SwitchPurse = [UIButton buttonWithTitle:@"" titleColor:kClearColor backgroundColor:kClearColor titleFont:10];
        SwitchPurse.frame = CGRectMake(SCREEN_WIDTH - 55, 15, 46, 34);
        self.SwitchPurse = SwitchPurse;
        [self addSubview:SwitchPurse];
        
        
        
        
        UIImageView *whiteView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 64, SCREEN_WIDTH - 10 , 170)];
//        我的资产背景
        [whiteView theme_setImageIdentifier:@"零用钱包背景" moduleName:ImgAddress];
        [self addSubview:whiteView];
        

        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backBtn.frame = CGRectMake(5, 64, SCREEN_WIDTH - 10 , 170);
        self.backBtn = backBtn;
        [self addSubview:backBtn];
        
        allAssetsLbl = [UILabel labelWithFrame:CGRectMake(35, 44, SCREEN_WIDTH - 80, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        
        [whiteView addSubview:allAssetsLbl];
        
        
        allPriceLbl = [UILabel labelWithFrame:CGRectMake(35, 80, SCREEN_WIDTH - 80, 41) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(41) textColor:kTabbarColor];
         if ([[TLUser user].localMoney isEqualToString:@"USD"])
         {
             allPriceLbl.text = @"≈0.00";
         }else
         {
             allPriceLbl.text = @"≈0.00";
         }
        
        [whiteView addSubview:allPriceLbl];
        
        youImg = [[UIImageView alloc]init];
        [youImg theme_setImageIdentifier:@"我的跳转" moduleName:ImgAddress];
        [whiteView addSubview:youImg];
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    if ([[USERDEFAULTS objectForKey:@"mnemonics"] isEqualToString:@""]) {
        self.nameLable.text = [LangSwitcher switchLang:@"零用钱包" key:nil];
        allAssetsLbl.text= [LangSwitcher switchLang:@"零用钱包 总资产（¥）" key:nil];
        allAssetsLbl.frame = CGRectMake(35, 44, SCREEN_WIDTH - 80, 20);
        youImg.hidden = YES;
    }else
    {
        self.nameLable.text = [LangSwitcher switchLang:@"私钥钱包" key:nil];
        CustomFMDBModel *_fmdbModel;
        NSArray *array = [CustomFMDB FMDBqueryMnemonics];
        for (int i = 0; i < array.count; i ++) {
            if ([array[i][@"mnemonics"] isEqualToString:[USERDEFAULTS objectForKey:@"mnemonics"]]) {
                youImg.hidden = NO;
                _fmdbModel = [CustomFMDBModel mj_objectWithKeyValues:array[i]];
                allAssetsLbl.text= [NSString stringWithFormat:@"%@ 总资产（¥）",_fmdbModel.walletName];
                [allAssetsLbl sizeToFit];
                allAssetsLbl.frame = CGRectMake(35, 44, allAssetsLbl.width, 20);
                youImg.frame = CGRectMake(allAssetsLbl.xx + 5, 44 + 4, 7, 12);
            }
        }
    }
    
    
    
    if ([[TLUser user].localMoney isEqualToString:@"USD"])
    {
        allPriceLbl.text = [NSString stringWithFormat:@"≈%.2f USD", [[dataDic[@"totalAmountUSD"] convertToSimpleRealMoney] doubleValue]];
    }
    else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
    {
        allPriceLbl.text = [NSString stringWithFormat:@"≈%.2f KRW", [[dataDic[@"totalAmountKRW"] convertToSimpleRealMoney] doubleValue]];
    }
    else
    {
        allPriceLbl.text = [NSString stringWithFormat:@"≈%.2f CNY", [[dataDic[@"totalAmountCNY"] convertToSimpleRealMoney] doubleValue]];
    }
}

@end
