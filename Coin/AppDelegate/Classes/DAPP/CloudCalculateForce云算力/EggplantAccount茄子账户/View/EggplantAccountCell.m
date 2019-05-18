//
//  EggplantAccountCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "EggplantAccountCell.h"

@implementation EggplantAccountCell
{
    UILabel *nameLbl;
    UILabel *timeLbl;
    UILabel *priceLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 17.5, SCREEN_WIDTH - 130, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        nameLbl.text=  @"兑换所得";
        [self addSubview:nameLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy + 5, SCREEN_WIDTH - 130, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        timeLbl.text=  @"兑换所得";
        [self addSubview:timeLbl];
        
        priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(nameLbl.xx, 0, 100, 75)];
        priceLbl.textAlignment = NSTextAlignmentRight;
        priceLbl.font = FONT(12);
        priceLbl.textColor = kHexColor(@"#FF6464");
        priceLbl.text=  @"+50";
        [self addSubview:priceLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
    }
    return self;
}

-(void)setModel:(BillModel *)model
{
    NSString *countStr = [CoinUtil convertToRealCoin:model.transAmountString
                                                coin:model.currency];
    CGFloat money = [countStr doubleValue];
    
    //    CoinModel *coin = [CoinUtil getCoinModel:billModel.currency];
    NSString *moneyStr;
    if (money > 0) {
        
        moneyStr = [NSString stringWithFormat:@"+%@ %@",countStr , model.currency];
        priceLbl.textColor = kHexColor(@"#47D047");
        
       
        
        //        [self.iconIV sd_setImageWithURL:[NSURL URLWithString:[coin.pic2 convertImageUrl]]];
        
    } else {
        priceLbl.textColor = kHexColor(@"#FE4F4F");
        
        moneyStr = [NSString stringWithFormat:@"%@ %@", countStr, model.currency];
        
        
    }
    nameLbl.text = model.bizNote;
    priceLbl.text = moneyStr;
    
    timeLbl.text = [model.createDatetime convertRedDate];
}

@end
