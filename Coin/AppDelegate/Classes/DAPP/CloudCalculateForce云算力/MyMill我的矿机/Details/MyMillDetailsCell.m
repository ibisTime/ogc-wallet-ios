//
//  MyMillDetailsCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillDetailsCell.h"

@implementation MyMillDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        self.lineView = lineView;
        [self addSubview:lineView];
        
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [leftLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        self.leftLbl = leftLbl;
        [self addSubview:leftLbl];
        
        UILabel *rightLbl = [UILabel labelWithFrame:CGRectMake(leftLbl.xx, 0, SCREEN_WIDTH - leftLbl.xx, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        self.rightLbl = rightLbl;
        
        [self addSubview:rightLbl];
    }
    return self;
}

@end
