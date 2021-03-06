//
//  WallAccountHeadView.m
//  Coin
//
//  Created by shaojianfei on 2018/6/6.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WallAccountHeadView.h"
#import "Masonry.h"
#import "UILable+convience.h"
#import "AppColorMacro.h"
#import "UILabel+Extension.h"
#import "NSString+Extension.h"

#import "LangSwitcher.h"
#import "CoinUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface WallAccountHeadView()
@property (nonatomic ,strong) UIImageView *bgIV;
@property (nonatomic ,strong) UILabel *textLbl;
@property (nonatomic ,strong) UILabel *currentLbl;
@property (nonatomic ,strong) UILabel *amountLbl;
@property (nonatomic ,strong) UIImageView *bgImage;
@end
@implementation WallAccountHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //
        [self initSubvies];
        
    }
    return self;
}
- (void)initSubvies
{
    
    UIImageView *bgImage = [[UIImageView alloc] init];

    self.bgImage = bgImage;
    bgImage.image = kImage(@"账单背景");
    bgImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bgImage];

    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);

        
    }];
    UIImageView *bgIV = [[UIImageView alloc] init];
    self.bgIV = bgIV;
    bgIV.contentMode = UIViewContentModeScaleToFill;
    bgIV.layer.cornerRadius = 20;
    bgIV.clipsToBounds = YES;
    [self.bgImage addSubview:bgIV];
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.bgImage.mas_left).offset(20);
        make.top.equalTo(@28);
        make.width.height.equalTo(@40);
        
    }];
    
    self.bgIV = bgIV;
    
    //text
    UILabel *textLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:17.0];
    
//    textLbl.text = [LangSwitcher switchLang:@"我的资产" key:nil];
    self.textLbl = textLbl;
    [self.bgImage addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgIV.mas_right).offset(17);
        make.top.equalTo(self.bgImage.mas_top).offset(24);
        
    }];
    
    UILabel *currentLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:15.0];
    
    //    textLbl.text = [LangSwitcher switchLang:@"我的资产" key:nil];
    self.currentLbl = currentLbl;
    [self.bgImage addSubview:currentLbl];
    [currentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgIV.mas_right).offset(17);
        make.top.equalTo(self.textLbl.mas_top).offset(10);
        
    }];
    UILabel *amountLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12.0];
    
    //    textLbl.text = [LangSwitcher switchLang:@"我的资产" key:nil];
    self.amountLbl = amountLbl;
    [self.bgImage addSubview:amountLbl];
    [amountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgIV.mas_right).offset(17);
        make.top.equalTo(self.textLbl.mas_bottom).offset(10);
        
    }];
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
//    [self.bgImage addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right);
//        make.left.equalTo(self.mas_left);
//
//        make.bottom.equalTo(self.mas_bottom).offset(-8);
//        make.height.equalTo(@4);
//    }];
}

-(void)setCurrency:(CurrencyModel *)currency
{
    _currency = currency;
    if (self.ISLocal == YES) {
        //去中心化货币
        CoinModel *coin = [CoinUtil getCoinModel:currency.symbol];

        [self.bgIV sd_setImageWithURL:[NSURL URLWithString:[coin.icon convertImageUrl]]];

//        self.currentLbl.text = currency.symbol;
        //    NSString *leftAmount = [platform.amountString subNumber:platform.frozenAmountString];
        
        NSString* t = [CoinUtil convertToRealCoin:currency.balance coin:currency.symbol];
       
        self.textLbl.text = [NSString stringWithFormat:@"%.6f%@ ",[t floatValue],currency.symbol];
        //    NSString *rightAmount = [platform.inAmountString subNumber:platform.addAmountString];
        
        //对应币种价格
        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
            self.amountLbl.text = [NSString stringWithFormat:@"≈%.2f USD", [currency.amountUSD doubleValue]];

        }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
        {
            self.amountLbl.text = [NSString stringWithFormat:@"≈%.2f KRW", [currency.amountKRW doubleValue]];

        }
        else{
            
            self.amountLbl.text = [NSString stringWithFormat:@"≈%.2f CNY", [currency.amountCNY doubleValue]];

        }
        
        //人民币价格
//        self.amountLbl.text = [NSString stringWithFormat:@"%.2f CNY",[currency.amountCNY doubleValue]];
        
    }else{
        
       
    CoinModel *coin = [CoinUtil getCoinModel:currency.currency];

    [self.bgIV sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
//    self.currentLbl.text = currency.currency;
    NSString *leftAmount = [currency.amountString subNumber:currency.frozenAmountString];

        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
                self.textLbl.text = [NSString stringWithFormat:@"%.4f%@",[[CoinUtil convertToRealCoin:leftAmount coin:currency.currency] doubleValue],currency.currency];
           
        }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
        {
            self.textLbl.text = [NSString stringWithFormat:@"%.4f%@",[[CoinUtil convertToRealCoin:leftAmount coin:currency.currency] doubleValue],currency.currency];
            
        }
        else{
            
              self.textLbl.text = [NSString stringWithFormat:@"%.4f%@",[[CoinUtil convertToRealCoin:leftAmount coin:currency.currency] doubleValue],currency.currency];
        }

    NSString *rightAmount = [currency.inAmountString subNumber:currency.addAmountString];
        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
            self.amountLbl.text = [NSString stringWithFormat:@"≈%.2fUSD", [currency.amountUSD doubleValue]];

        }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
            self.amountLbl.text = [NSString stringWithFormat:@"≈%.2fKRW", [currency.amountKRW doubleValue]];

        else{
            
            self.amountLbl.text = [NSString stringWithFormat:@"≈%.2fCNY", [currency.amountCNY doubleValue]];

        }
    //对应币种价格
    }
//    人民币价格
//    self.rmbPriceLbl.text = [NSString stringWithFormat:@"≈%.2f CNY",[[CoinUtil convertToRealCoin:leftAmount coin:platform.currency] doubleValue]];
}
@end
