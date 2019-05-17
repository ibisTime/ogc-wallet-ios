//
//  OreRecordCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "OreRecordCell.h"

@implementation OreRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [timeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        timeLbl.text = @"06-19 10:25";
        [self addSubview:timeLbl];
        
        
        UILabel *amountLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx , 10, SCREEN_WIDTH - 100 - 30 , 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        amountLbl.text = @"50HEY";
        [self addSubview:amountLbl];
        
        
        UILabel *stateLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx , 30, SCREEN_WIDTH - 100 - 30 , 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [stateLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        stateLbl.text = @"已出";
        [self addSubview:stateLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59.5, SCREEN_WIDTH - 30, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        self.lineView = lineView;
        [self addSubview:lineView];
    }
    return self;
}

@end
