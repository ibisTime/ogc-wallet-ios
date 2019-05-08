//
//  PrivateKeyWalletCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/3/23.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PrivateKeyWalletCell.h"

@implementation PrivateKeyWalletCell

{
    UIImageView *iconImg;
    UILabel *nameLabel;
    UILabel *priceLabel;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)backButtonClick:(UIButton *)sender
{
    [_delegate MyAsstesButton:sender];
}




-(void)setPlatforms:(NSMutableArray<CurrencyModel *> *)platforms
{
    
    [self.whiteView removeFromSuperview];
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, platforms.count * 80)];
    whiteView.backgroundColor = kWhiteColor;
    self.whiteView = whiteView;
    whiteView.layer.cornerRadius=10;
    whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
    whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
    whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self addSubview:whiteView];
    
    
    for (int i = 0; i < platforms.count; i ++) {
        
        CurrencyModel *model = platforms[i];
        NSString *amount = [CoinUtil convertToRealCoin:model.balance coin:model.symbol];
        
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.frame = CGRectMake(0, i % platforms.count * 80, SCREEN_WIDTH - 30, 80);
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _backButton.tag = 100 + i;
        [whiteView addSubview:_backButton];
        
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20 + i % platforms.count * 80, 40, 40)];
        //        kViewRadius(iconImg, 20);
//        CoinModel *coin = [CoinUtil getCoinModel:model.currency];
        CoinModel *coin = [CoinUtil getCoinModel:model.symbol];
        [iconImg sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
        [whiteView addSubview:iconImg];
        
        nameLabel = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 12, 15 + i % platforms.count * 80, 80, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#333333")];
        nameLabel.text = model.symbol;
        [whiteView addSubview:nameLabel];
        
        
        UILabel *freezeLabel = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 12, 45 + i % platforms.count * 80, 100, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];

        if ([[TLUser user].localMoney isEqualToString:@"USD"])
        {
            freezeLabel.text = [NSString stringWithFormat:@"≈%.2f USD", [[model.priceUSD convertToSimpleRealMoney] doubleValue]];
        }else
        {
            freezeLabel.text = [NSString stringWithFormat:@"≈%.2f CNY", [[model.priceCNY convertToSimpleRealMoney] doubleValue]];
        }
        [whiteView addSubview:freezeLabel];

        
        
        
        
        priceLabel = [UILabel labelWithFrame:CGRectMake(nameLabel.xx + 10, 15 + i % platforms.count * 80, SCREEN_WIDTH - nameLabel.xx - 30 - 15 - 10, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(16) textColor:[UIColor blackColor]];
        priceLabel.text = [NSString stringWithFormat:@"%@%@",amount,model.symbol];
        [whiteView addSubview:priceLabel];
        
        
        UILabel *allPriceLabel = [UILabel labelWithFrame:CGRectMake(nameLabel.xx + 10, 45 + i % platforms.count * 80, SCREEN_WIDTH - nameLabel.xx - 30 - 15 - 10, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"999999")];

        [whiteView addSubview:allPriceLabel];
        
        if ([[TLUser user].localMoney isEqualToString:@"USD"])
        {
            allPriceLabel.text = [NSString stringWithFormat:@"≈%.2f USD", [[model.amountCNY convertToSimpleRealMoney] doubleValue]];
        }else
        {
            allPriceLabel.text = [NSString stringWithFormat:@"≈%.2f CNY", [[model.amountCNY convertToSimpleRealMoney] doubleValue]];
        }
        if (i != platforms.count - 1) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 80 + i % platforms.count * 80, SCREEN_WIDTH - 30, 1)];
            lineView.backgroundColor = kLineColor;
            [whiteView addSubview:lineView];
        }
    }
}


@end
