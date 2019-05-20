//
//  TeamPerFormanceCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TeamPerFormanceCell.h"

@implementation TeamPerFormanceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *allLbl = [UILabel labelWithFrame:CGRectMake(15 , 16.5, SCREEN_WIDTH - 150 - 30 , 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:nil];
        allLbl.text = @"总水滴型号：10滴";
        [self addSubview:allLbl];
        
        
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, allLbl.yy + 5, SCREEN_WIDTH - 150 - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [timeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        timeLbl.text = @"06-19 10:25";
        [self addSubview:timeLbl];
        
        
        
        
        UILabel *commissionLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx , 0, 150 , 75) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(16) textColor:nil];
        [commissionLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        commissionLbl.text = @"提成：3HEY";
        [self addSubview:commissionLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 74.5, SCREEN_WIDTH - 30, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
