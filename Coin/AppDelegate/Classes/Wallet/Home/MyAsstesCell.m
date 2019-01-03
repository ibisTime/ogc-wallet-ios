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
    UILabel *nameLabel;
    UILabel *priceLabel;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 320)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        
        
        
        
        
        for (int i = 0; i < 3; i ++) {
            
            
            _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            _backButton.frame = CGRectMake(0, i % 3 * 100, SCREEN_WIDTH - 30, 100);
            [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            _backButton.tag = 100 + i;
            [whiteView addSubview:_backButton];
            
            
            iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30 + i % 3 * 100, 40, 40)];
            iconImg.image = kImage(@"BTC");
            [whiteView addSubview:iconImg];
            
            nameLabel = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 12, 23.5 + i % 3 * 100, SCREEN_WIDTH - 23.5 - 45, 21) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#333333")];
            nameLabel.text = @"BTC";
            [whiteView addSubview:nameLabel];
            
            
            UILabel *freezeLabel = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 12, nameLabel.yy + 4 + i % 3 * 100, 0, 12) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:kTextColor2];
            freezeLabel.text = @"冻结1.00BTC";
            [freezeLabel sizeToFit];
            freezeLabel.frame = CGRectMake(iconImg.xx + 12, nameLabel.yy + 4, freezeLabel.width, 12);
            [whiteView addSubview:freezeLabel];
            
            UILabel *availableLabel = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 12, freezeLabel.yy + 4, SCREEN_WIDTH - iconImg.xx - 12 - 30 - 15, 12) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:kTextColor2];
            availableLabel.text = @"可用1.00BTC";
            [whiteView addSubview:availableLabel];
            
            
            priceLabel = [UILabel labelWithFrame:CGRectMake(freezeLabel.xx + 10, 34.5 + i % 3 * 100, SCREEN_WIDTH - freezeLabel.xx - 30 - 15 - 10, 21) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(15) textColor:[UIColor blackColor]];
            priceLabel.text = @"1.00023BTC";
            priceLabel.centerY = freezeLabel.centerY;
            [whiteView addSubview:priceLabel];
        
            if (i != 2) {
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 100 + i % 3 * 100, SCREEN_WIDTH - 30, 1)];
                lineView.backgroundColor = kLineColor;
                [whiteView addSubview:lineView];
            }
            
            
            
            
        }
        
        
    }
    return self;
}

-(void)backButtonClick:(UIButton *)sender
{
    [_delegate MyAsstesButton:sender];
}


-(void)setPlatform:(CurrencyModel *)platform
{
//    cname
    CoinModel *coin = [CoinUtil getCoinModel:platform.currency];
    
    NSString *name;
    LangType type = [LangSwitcher currentLangType];
//    NSString *lan;
    if (type == LangTypeSimple || type == LangTypeTraditional) {
        name = coin.cname;
    }else
    {
        name = coin.ename;
    }
    
    nameLabel.text = [NSString stringWithFormat:@"%@(%@)",name,platform.currency];
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]]];
    NSString *leftAmount = [CoinUtil convertToRealCoin:platform.amountString coin:platform.currency];
    NSString *rightAmount = [CoinUtil convertToRealCoin:platform.frozenAmountString coin:platform.currency];
    NSString *ritAmount = [leftAmount subNumber:rightAmount];
    priceLabel.text = [NSString stringWithFormat:@"%@",ritAmount];
    
    
}

@end
