//
//  MyAsstesCell.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "MyAsstesCell.h"



@implementation MyAsstesCell
{
    UIImageView *iconImg;
    UILabel * nameLabel;
    UILabel *priceLabel;
    UILabel *aboutPicLabel;
    UILabel *allPicLabel;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self theme_setBackgroundColorIdentifier:CellBackColor moduleName:@"homepage"];
        

        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 75)];

        [whiteView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        self.whiteView = whiteView;
        whiteView.layer.cornerRadius=4;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        
        
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17.5, 40, 40)];
        //        kViewRadius(iconImg, 20);
        
        [whiteView addSubview:iconImg];
        
        nameLabel = [UILabel labelWithFrame:CGRectMake(66, 12.5, 100, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#333333")];
//        nameLabel.text = model.currency;
        [whiteView addSubview:nameLabel];
        
        
        priceLabel = [UILabel labelWithFrame:CGRectMake(nameLabel.xx, 12.5, SCREEN_WIDTH - 30 - nameLabel.xx - 15, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(16) textColor:kTextColor2];
        priceLabel.text = @"0";
        [whiteView addSubview:priceLabel];
        
        aboutPicLabel = [UILabel labelWithFrame:CGRectMake(66, 42, 100, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextColor2];
//        availableLabel.text = [NSString stringWithFormat:@"%@%@%@",[LangSwitcher switchLang:@"可用" key:nil],available,model.currency];
        aboutPicLabel.text = @"≈0.11";
        [aboutPicLabel theme_setTextIdentifier:GaryLabelColor moduleName:ColorName];
        [whiteView addSubview:aboutPicLabel];
        
        
        
        
        
        allPicLabel = [UILabel labelWithFrame:CGRectMake(aboutPicLabel.xx, 42, SCREEN_WIDTH - 30 - nameLabel.xx - 15, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:[UIColor blackColor]];
//        aboutPicLabel.text = [NSString stringWithFormat:@"%@%@",amount,model.currency];
//        aboutPicLabel.centerY = freezeLabel.centerY;
        allPicLabel.text = @"≈0.00";
        [allPicLabel theme_setTextIdentifier:GaryLabelColor moduleName:ColorName];
        [whiteView addSubview:allPicLabel];
        
        
        
        
    }
    return self;
}

-(void)setPlatforms:(CurrencyModel *)platforms
{
    _platforms = platforms;
    
    
    if ([[USERDEFAULTS objectForKey:@"mnemonics"] isEqualToString:@""]) {
        NSLog(@"---------%@",platforms);
        CoinModel *coin = [CoinUtil getCoinModel:platforms.currency];
        
        [iconImg sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
        
        nameLabel.text = [NSString stringWithFormat:@"%@（%@）",platforms.currency,coin.cname];
        
        
        NSString *amount = [CoinUtil convertToRealCoin:platforms.amount coin:platforms.currency];
        NSString *rightAmount = [CoinUtil convertToRealCoin:platforms.frozenAmount coin:platforms.currency];
        NSString *ritAmount = [amount subNumber:rightAmount];
        
        
        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
            aboutPicLabel.text = [NSString stringWithFormat:@"≈%.2f USD",[platforms.priceUSD doubleValue]];
            allPicLabel.text = [NSString stringWithFormat:@"%.2f USD",[platforms.amountUSD doubleValue]];
            
        } else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
        {
            aboutPicLabel.text = [NSString stringWithFormat:@"≈%.2f KRW",[platforms.priceKRW doubleValue]];
            allPicLabel.text = [NSString stringWithFormat:@"%.2f KRW",[platforms.amountKRW doubleValue]];
            
        }
        else{
            aboutPicLabel.text = [NSString stringWithFormat:@"≈%.2f CNY",[platforms.priceCNY doubleValue]];
            allPicLabel.text = [NSString stringWithFormat:@"%.2f CNY",[platforms.amountCNY doubleValue]];
        }
        priceLabel.text = [NSString stringWithFormat:@"%.8f",[ritAmount doubleValue]];
    }else
    {
        NSLog(@"---------%@",platforms);
        CoinModel *coin = [CoinUtil getCoinModel:platforms.symbol];
        
        NSString *amount = [CoinUtil convertToRealCoin:platforms.balance coin:platforms.symbol];
        
        [iconImg sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
        
        nameLabel.text = [NSString stringWithFormat:@"%@（%@）",platforms.symbol,coin.cname];
        
        
//        NSString *amount = [CoinUtil convertToRealCoin:platforms.amount coin:platforms.symbol];
//        NSString *rightAmount = [CoinUtil convertToRealCoin:platforms.frozenAmount coin:platforms.symbol];
//        NSString *ritAmount = [amount subNumber:rightAmount];
        
        
        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
            aboutPicLabel.text = [NSString stringWithFormat:@"≈%.2f USD",[platforms.priceUSD doubleValue]];
            allPicLabel.text = [NSString stringWithFormat:@"%.2f USD",[platforms.amountUSD doubleValue]];
            
        } else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
        {
            aboutPicLabel.text = [NSString stringWithFormat:@"≈%.2f KRW",[platforms.priceKRW doubleValue]];
            allPicLabel.text = [NSString stringWithFormat:@"%.2f KRW",[platforms.amountKRW doubleValue]];
            
        }
        else{
            aboutPicLabel.text = [NSString stringWithFormat:@"≈%.2f CNY",[platforms.priceCNY doubleValue]];
            allPicLabel.text = [NSString stringWithFormat:@"%.2f CNY",[platforms.amountCNY doubleValue]];
        }
        priceLabel.text = [NSString stringWithFormat:@"%.8f",[amount doubleValue]];
    }
    
    
    
    
    nameLabel.frame = CGRectMake(66, 12.5, 100, 22.5);
    [nameLabel sizeToFit];
    nameLabel.frame = CGRectMake(66, 12.5, nameLabel.width, 22.5);
    priceLabel.frame = CGRectMake(nameLabel.xx, 12.5, SCREEN_WIDTH - 30 - nameLabel.xx - 15, 22.5);
    aboutPicLabel.frame = CGRectMake(66, 42, 100, 20);
    [aboutPicLabel sizeToFit];
    aboutPicLabel.frame = CGRectMake(66, 42, aboutPicLabel.width, 20);
    allPicLabel.frame = CGRectMake(aboutPicLabel.xx, 42, SCREEN_WIDTH - 30 - aboutPicLabel.xx - 15, 22.5);
}

//-(void)backButtonClick:(UIButton *)sender
//{
//    [_delegate MyAsstesButton:sender];
//}




//-(void)setPlatforms:(NSMutableArray<CurrencyModel *> *)platforms
//{
//
//    [self.whiteView removeFromSuperview];
//
//
//
//    for (int i = 0; i < platforms.count; i ++) {
//
//        CurrencyModel *model = platforms[i];
//        NSString *amount = [CoinUtil convertToRealCoin:model.amount coin:model.currency];
//
//        NSString *frozenAmount = [CoinUtil convertToRealCoin:model.frozenAmount coin:model.currency];
//        NSString *available = [amount subNumber:frozenAmount];
//
//
////        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
////        _backButton.frame = CGRectMake(0, i % platforms.count * 100, SCREEN_WIDTH - 30, 100);
////        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
////        _backButton.tag = 100 + i;
////        [whiteView addSubview:_backButton];
//
//
//
//    }
//}

@end
