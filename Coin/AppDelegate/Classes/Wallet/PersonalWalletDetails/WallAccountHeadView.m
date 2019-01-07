//
//  WallAccountHeadView.m
//  Coin
//
//  Created by shaojianfei on 2018/6/6.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WallAccountHeadView.h"

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
    
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130 - 64 + kNavigationBarHeight)];
    topView.image = kImage(@"账单详情");
    [self addSubview:topView];
    
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 84 - 64 + kNavigationBarHeight - 10, SCREEN_WIDTH - 10, 110)];

    self.bgImage = bgImage;
    bgImage.image = kImage(@"背景");
    bgImage.contentMode = UIViewContentModeScaleToFill;
    bgImage.layer.cornerRadius=5;
    bgImage.layer.shadowOpacity = 0.22;// 阴影透明度
    bgImage.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    bgImage.layer.shadowRadius=3;// 阴影扩散的范围控制
    bgImage.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围
    [self addSubview:bgImage];

//    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(10);
//        make.bottom.equalTo(self.mas_bottom).offset(-10);
//        make.left.equalTo(self.mas_left).offset(15);
//        make.right.equalTo(self.mas_right).offset(-15);
//    }];
    
//    UIImageView *bgIV = [[UIImageView alloc] init];
//    self.bgIV = bgIV;
//    bgIV.contentMode = UIViewContentModeScaleToFill;
//    bgIV.layer.cornerRadius = 20;
//    bgIV.clipsToBounds = YES;
//    [self.bgImage addSubview:bgIV];
//    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.left.equalTo(self.bgImage.mas_left).offset(20);
//        make.top.equalTo(@28);
//        make.width.height.equalTo(@40);
//
//    }];
//    self.bgIV = bgIV;

    //text
//    UILabel *textLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:17.0];
//
////    textLbl.text = [LangSwitcher switchLang:@"我的资产" key:nil];
//    self.textLbl = textLbl;
//    [self.bgImage addSubview:textLbl];
//    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.bgIV.mas_right).offset(17);
//        make.top.equalTo(self.bgImage.mas_top).offset(24);
//
//    }];
    
    UILabel *currentLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#666666") font:14.0];
    currentLbl.frame = CGRectMake(0, 29, SCREEN_WIDTH - 30, 20);
    currentLbl.textAlignment = NSTextAlignmentCenter;
//    currentLbl.text = @"BTC";
    self.currentLbl = currentLbl;
    [self.bgImage addSubview:currentLbl];
//    [currentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.bgIV.mas_right).offset(17);
//        make.top.equalTo(self.textLbl.mas_top).offset(10);
//
//    }];
    UILabel *amountLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:22.0];
//    amountLbl.text = @"1.00234BTC";
    amountLbl.font = HGboldfont(22);
    //    textLbl.text = [LangSwitcher switchLang:@"我的资产" key:nil];
    amountLbl.frame = CGRectMake(0, currentLbl.yy + 2, SCREEN_WIDTH - 30, 31);
    amountLbl.textAlignment = NSTextAlignmentCenter;
    self.amountLbl = amountLbl;
    [self.bgImage addSubview:amountLbl];
//    [amountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.bgIV.mas_right).offset(17);
//        make.top.equalTo(self.textLbl.mas_bottom).offset(10);
//
//    }];

}

-(void)setCurrency:(CurrencyModel *)currency
{
    _currency = currency;
//    if (self.ISLocal == YES) {
        //去中心化货币
//        CoinModel *coin = [CoinUtil getCoinModel:currency.currency];
//
//        [self.bgIV sd_setImageWithURL:[NSURL URLWithString:[coin.icon convertImageUrl]]];
//
//
//        self.textLbl.text = [NSString stringWithFormat:@"%.8f%@",[[CoinUtil convertToRealCoin:currency.balance coin:currency.symbol] floatValue],currency.symbol];
    
        //对应币种价格
//        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
//            self.amountLbl.text = [NSString stringWithFormat:@"≈%@ USD", currency.amountUSD];
//
//        }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
//        {
//            self.amountLbl.text = [NSString stringWithFormat:@"≈%@ KRW", currency.amountKRW];
//
//        }
//        else{
//
//            self.amountLbl.text = [NSString stringWithFormat:@"≈%@ CNY", currency.amountCNY];
//
//        }

        
//    }else{
//
//
    CoinModel *coin = [CoinUtil getCoinModel:currency.currency];

    [self.bgIV sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
    NSString *leftAmount = [currency.amount subNumber:currency.frozenAmount];
    self.currentLbl.text = currency.currency;
    
    self.amountLbl.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:leftAmount coin:currency.currency],currency.currency];
//
//        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
//                self.textLbl.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:leftAmount coin:currency.currency],currency.currency];
//
//        }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
//        {
//            self.textLbl.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:leftAmount coin:currency.currency],currency.currency];
//
//        }
//        else{
//
//              self.textLbl.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:leftAmount coin:currency.currency],currency.currency];
//        }
//
//        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
//            self.amountLbl.text = [NSString stringWithFormat:@"≈%@USD", currency.amountUSD];
//
//        }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
//            self.amountLbl.text = [NSString stringWithFormat:@"≈%@KRW", currency.amountKRW];
//
//        else{
//
//            self.amountLbl.text = [NSString stringWithFormat:@"≈%@CNY", currency.amountCNY];
//
//        }
//    }

}
@end
