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
        
//        self.backgroundColor = kCellViewColor;
//        self.nightBackgroundColor = kNightCellViewColor;
        
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
        [whiteView addSubview:aboutPicLabel];
        
        
        
        
        
        allPicLabel = [UILabel labelWithFrame:CGRectMake(aboutPicLabel.xx, 42, SCREEN_WIDTH - 30 - nameLabel.xx - 15, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:[UIColor blackColor]];
//        aboutPicLabel.text = [NSString stringWithFormat:@"%@%@",amount,model.currency];
//        aboutPicLabel.centerY = freezeLabel.centerY;
        allPicLabel.text = @"≈0.00";
        [whiteView addSubview:allPicLabel];
        
        
        
        
    }
    return self;
}

-(void)setPlatforms:(CurrencyModel *)platforms
{
    NSString *amount = [CoinUtil convertToRealCoin:platforms.amount coin:platforms.currency];
    NSString *frozenAmount = [CoinUtil convertToRealCoin:platforms.frozenAmount coin:platforms.currency];
    NSString *available = [amount subNumber:frozenAmount];
    
    
    
    CoinModel *coin = [CoinUtil getCoinModel:platforms.currency];
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
    nameLabel.text = platforms.currency;
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
