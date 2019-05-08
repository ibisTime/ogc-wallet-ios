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
    
//    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130 - 64 + kNavigationBarHeight)];
//    topView.image = kImage(@"账单详情");
//    [self addSubview:topView];
    
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 84 - 64 + kNavigationBarHeight - 10, SCREEN_WIDTH - 10, 110)];
    self.bgImage = bgImage;
    bgImage.contentMode = UIViewContentModeScaleToFill;
    bgImage.layer.cornerRadius=5;
    bgImage.layer.shadowOpacity = 0.22;// 阴影透明度
    bgImage.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    bgImage.layer.shadowRadius=3;// 阴影扩散的范围控制
    bgImage.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围
    [self addSubview:bgImage];
    [self.bgImage theme_setImageIdentifier:@"BTC背景" moduleName:ImgAddress];
    
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 110/2 - 20, 40, 40)];
    kViewRadius(iconImage, 20);
    self.bgIV = iconImage;
    [bgImage addSubview:iconImage];
    

    
    UILabel *currentLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#666666") font:14.0];
    currentLbl.frame = CGRectMake(iconImage.xx + 10, 29, SCREEN_WIDTH - 30- iconImage.xx - 10, 20);
//    currentLbl.textAlignment = NSTextAlignmentCenter;
//    currentLbl.text = @"BTC";
    self.currentLbl = currentLbl;
    [self.bgImage addSubview:currentLbl];

    UILabel *amountLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:22.0];
    amountLbl.font = HGboldfont(22);
    amountLbl.frame = CGRectMake(iconImage.xx + 10, currentLbl.yy + 2, SCREEN_WIDTH - 30 - iconImage.xx - 10, 31);
//    amountLbl.textAlignment = NSTextAlignment\Center;
    self.amountLbl = amountLbl;
    [self.bgImage addSubview:amountLbl];


}

-(void)setCurrency:(CurrencyModel *)currency
{
    _currency = currency;

    if ([TLUser isBlankString:currency.currency] == YES) {
        CoinModel *coin = [CoinUtil getCoinModel:currency.symbol];
        
        [self.bgIV sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];

        self.currentLbl.text = currency.symbol;
        self.amountLbl.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:currency.balance coin:currency.symbol],currency.symbol];
    }else
    {
        CoinModel *coin = [CoinUtil getCoinModel:currency.currency];
        
        [self.bgIV sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
        
        NSString *leftAmount = [currency.amount subNumber:currency.frozenAmount];
        self.currentLbl.text = currency.currency;
        self.amountLbl.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:leftAmount coin:currency.currency],currency.currency];
    }
}

@end
