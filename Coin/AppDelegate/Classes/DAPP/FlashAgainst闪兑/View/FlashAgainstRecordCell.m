//
//  FlashAgainstRecordCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/26.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FlashAgainstRecordCell.h"

@implementation FlashAgainstRecordCell
{
    UILabel *smybolNameLbl;
    UILabel *smybolPriceLbl;
    UILabel *timeLbl;
    UILabel *obtainPriceLbl;
    UILabel *poundageLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        smybolNameLbl = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH/2 - 15, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [self addSubview:smybolNameLbl];
        
        smybolPriceLbl = [UILabel labelWithFrame:CGRectMake(15, smybolNameLbl.yy + 9, SCREEN_WIDTH/2 - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [smybolPriceLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:smybolPriceLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, smybolPriceLbl.yy + 9, SCREEN_WIDTH/2 - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [timeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:timeLbl];
        
        obtainPriceLbl = [UILabel labelWithFrame:CGRectMake(smybolNameLbl.xx, 20, SCREEN_WIDTH/2 - 15, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [obtainPriceLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        obtainPriceLbl.textColor = kHexColor(@"28BE67");
        [self addSubview:obtainPriceLbl];
        
        poundageLbl = [UILabel labelWithFrame:CGRectMake(smybolNameLbl.xx, obtainPriceLbl.yy + 9, SCREEN_WIDTH/2 - 15, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [poundageLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:poundageLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 110.5, SCREEN_WIDTH - 30, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
    }
    return self;
}

-(void)setModel:(FlashAgainstModel *)model
{
    smybolNameLbl.text = [NSString stringWithFormat:@"%@兑%@",model.symbolOut,model.symbolIn];
    obtainPriceLbl.text = [NSString stringWithFormat:@"+%@%@",[CoinUtil convertToRealCoin:model.countIn coin:model.symbolIn],model.symbolIn];
    
    NSString *rightPic = [NSString stringWithFormat:@"%.8f",[model.valueCnyOut floatValue]/[model.valueCnyIn floatValue]];
    
    smybolPriceLbl.text = [NSString stringWithFormat:@"1%@=%@%@",model.symbolOut,[CoinUtil mult1:rightPic mult2:@"1" scale:8],model.symbolIn];
    poundageLbl.text = [NSString stringWithFormat:@"手续费：%@%@",[CoinUtil convertToRealCoin:model.fee coin:model.symbolOut],model.symbolOut];
    timeLbl.text = model.createTime;
    
}

@end
