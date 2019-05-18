//
//  OreRecordCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "OreRecordCell.h"

@implementation OreRecordCell
{
    UILabel *timeLbl;
    UILabel *amountLbl;
    UILabel *stateLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, 0, 150, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [timeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
//        timeLbl.text = @"06-19 10:25";
        [self addSubview:timeLbl];
        
        
        amountLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx , 10, SCREEN_WIDTH - 150 - 30 , 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
//        amountLbl.text = @"50HEY";
        [self addSubview:amountLbl];
        
        
        stateLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx , 30, SCREEN_WIDTH - 150 - 30 , 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [stateLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
//        stateLbl.text = @"已出";
        [self addSubview:stateLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59.5, SCREEN_WIDTH - 30, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        self.lineView = lineView;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setModel:(MyMillDetailsModel *)model
{
    if ([model.status isEqualToString:@"0"]) {
        timeLbl.text = [model.incomeTimeExpect convertToDetailDate];
        stateLbl.text = @"待出";
        amountLbl.text =  [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:model.incomeCountExpect coin:model.symbol],model.symbol];
    }else
    {
        timeLbl.text = [model.incomeTimeActual convertToDetailDate];
        stateLbl.text = @"已出";
        amountLbl.text =  [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:model.incomeCountActual coin:model.symbol],model.symbol];
    }
    
}

@end
