//
//  MarketDetaiilsCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MarketDetaiilsCell.h"

@implementation MarketDetaiilsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UILabel *currencyLbl = [UILabel labelWithFrame:CGRectMake(15, 14, (SCREEN_WIDTH - 30)/3, 19) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
        currencyLbl.text = @"BTC";
        [self addSubview:currencyLbl];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(currencyLbl.xx, 14, (SCREEN_WIDTH - 30)/3, 19) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
        priceLbl.text = @"464,411.25";
        [self addSubview:priceLbl];
        
        
        
        
        UILabel *currencyNameLbl = [UILabel labelWithFrame:CGRectMake(15, 35, (SCREEN_WIDTH - 30)/3, 19) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        currencyNameLbl.text = @"比特币现金";
        [currencyNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:currencyNameLbl];
        
        UILabel *priceProportionLbl = [[UILabel alloc]initWithFrame:CGRectMake(currencyLbl.xx, 35, (SCREEN_WIDTH - 30)/3, 19)];
        priceProportionLbl.textAlignment = NSTextAlignmentCenter;
        priceProportionLbl.font = FONT(12);
        priceProportionLbl.text = @"0.76%";
        priceProportionLbl.textColor = kHexColor(@"#C93D3D");
        //        #28BE67
        [self addSubview:priceProportionLbl];
        
        
        
        UIButton *marketValueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [marketValueBtn setTitle:@"1.3亿" forState:(UIControlStateNormal)];
        marketValueBtn.frame = CGRectMake(priceLbl.xx, 0, (SCREEN_WIDTH - 30)/3, 65);
        marketValueBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [marketValueBtn theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
        marketValueBtn.titleLabel.font = HGboldfont(16);
        [marketValueBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:12 imagePositionBlock:^(UIButton *button) {
            [marketValueBtn setImage:kImage(@"涨") forState:(UIControlStateNormal)];
        }];
        [self addSubview:marketValueBtn];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 65, SCREEN_WIDTH - 30, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
    }
    return self;
    
}

@end
