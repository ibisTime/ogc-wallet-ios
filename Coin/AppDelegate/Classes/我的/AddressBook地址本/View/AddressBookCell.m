//
//  AddressBookCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AddressBookCell.h"

@implementation AddressBookCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 13, SCREEN_WIDTH - 180, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kTextColor];
        _nameLabel.text = @"火币地址";
        [self addSubview:_nameLabel];
        
        
        
        _timeLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 165, 13, 150, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor];
        _timeLabel.text = @"2019-10-10 20:00:00";
        [_timeLabel theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:_timeLabel];
        
        
        _addressLabel = [UILabel labelWithFrame:CGRectMake(15, _nameLabel.yy + 7, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kTextColor];
        _addressLabel.text = @"1cjiosuadfiosdaufi0xf750b288323dfpfdspof";
        [_addressLabel theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:_addressLabel];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.4)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
        
    }
    return self;
}

@end
