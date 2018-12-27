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
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 7, SCREEN_WIDTH - 40, 150)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        
        
        nameLabel = [UILabel labelWithFrame:CGRectMake(10, 12, SCREEN_WIDTH - 60, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:RGB(54, 73, 198)];
        nameLabel.text = @"比特币资产(BTC)";
        [whiteView addSubview:nameLabel];
        
        priceLabel = [UILabel labelWithFrame:CGRectMake(10, 44, SCREEN_WIDTH - 60, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(20) textColor:[UIColor blackColor]];
        priceLabel.text = @"1.00023";
        [whiteView addSubview:priceLabel];
        
        
        UILabel *freezeLabel = [UILabel labelWithFrame:CGRectMake(10, 76, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        freezeLabel.text = @"冻结1.00BTC";
        [freezeLabel sizeToFit];
        freezeLabel.frame = CGRectMake(10, 76, freezeLabel.width, 20);
        [whiteView addSubview:freezeLabel];
        
        UILabel *availableLabel = [UILabel labelWithFrame:CGRectMake(freezeLabel.xx + 15, 76, SCREEN_WIDTH - 40 - freezeLabel.xx - 25, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        availableLabel.text = @"可用1.00BTC";
        [whiteView addSubview:availableLabel];
        
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70 - 40, 27.5, 50, 50)];
        iconImg.image = kImage(@"以太币图标");
        [whiteView addSubview:iconImg];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 105, SCREEN_WIDTH - 40, 1)];
        lineView.backgroundColor = kLineColor;
        [whiteView addSubview:lineView];
        
        
        NSArray *nameArray = @[@"转入",@"转出",@"账单"];
        NSArray *imageArray = @[@"账单", @"账单",@"账单"];
        for (int i = 0; i < 3; i ++) {
            UIButton *allAssetsBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:nameArray[i] key:nil] titleColor:[UIColor blackColor] backgroundColor:kClearColor titleFont:13];
            allAssetsBtn.frame = CGRectMake(i % 3 * (SCREEN_WIDTH - 40)/3, 105, (SCREEN_WIDTH - 40)/3, 45);
            [allAssetsBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
                [button setImage:kImage(imageArray[i]) forState:(UIControlStateNormal)];
            }];
            [whiteView addSubview:allAssetsBtn];

            if (i == 0) {
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 40)/3 - 0.5, 117.5, 1, 20)];
                lineView.backgroundColor = kLineColor;
                [whiteView addSubview:lineView];
                self.intoBtn = allAssetsBtn;
            }
            
            if (i == 1) {
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 40)/3*2 - 0.5, 117.5, 1, 20)];
                lineView.backgroundColor = kLineColor;
                [whiteView addSubview:lineView];
                self.rollOutBtn = allAssetsBtn;
            }
            if (i == 2) {
                self.billBtn = allAssetsBtn;
            }
        }
        
        
    }
    return self;
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
