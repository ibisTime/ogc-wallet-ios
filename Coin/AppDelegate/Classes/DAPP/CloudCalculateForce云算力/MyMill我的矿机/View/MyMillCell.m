//
//  MyMillCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillCell.h"

@implementation MyMillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 165)];
        
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的backView
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 10, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        nameLbl.text = @"HEY 007D型";
        [backView addSubview:nameLbl];
        
        UILabel *stateLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx, 10, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        stateLbl.text = @"HEY 矿机";
        stateLbl.textColor = kHexColor(@"#FB6B6B");
        [backView addSubview:stateLbl];
        
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [timeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        timeLbl.text = @"2018-12-26 11:03:34";
        
        [backView addSubview:timeLbl];
        
        
        UILabel *depositLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx, nameLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        NSString *text = @"24:00:00后可连存";
        [depositLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:kHexColor(@"#F49671")
                             range:NSMakeRange(0, 8)];
        depositLbl.attributedText = attributeStr;
        
        [depositLbl sizeToFit];
        depositLbl.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - depositLbl.width, nameLbl.yy + 5, depositLbl.width, 20);
        [backView addSubview:depositLbl];
        
        
        UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45 - 8 - 12 - depositLbl.width, nameLbl.yy + 9, 12, 12)];
        timeImg.image = kImage(@"时间");
        [backView addSubview:timeImg];
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH - 30, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [backView addSubview:lineView];
        
        UILabel *amountLbl = [UILabel labelWithFrame:CGRectMake(0, lineView.yy + 26, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
        amountLbl.text = @"1BTC";
        [backView addSubview:amountLbl];
        
        UILabel *amountNameLbl = [UILabel labelWithFrame:CGRectMake(0, amountLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        amountNameLbl.text = @"购买本金";
        [amountNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [backView addSubview:amountNameLbl];
        
        UILabel *earningsLbl = [UILabel labelWithFrame:CGRectMake(amountLbl.xx, lineView.yy + 26, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
        earningsLbl.text = @"70hHEY";
        [backView addSubview:earningsLbl];
        
        UILabel *earningsNameLbl = [UILabel labelWithFrame:CGRectMake(amountLbl.xx, earningsLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [earningsNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        earningsNameLbl.text = @"总收益";
        [backView addSubview:earningsNameLbl];
        
        
        
        UILabel *dueTimeLbl = [UILabel labelWithFrame:CGRectMake(earningsNameLbl.xx, lineView.yy + 19, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        dueTimeLbl.text = @"70hHEY";
        [backView addSubview:dueTimeLbl];
        
        UILabel *dueTimeNameLbl = [UILabel labelWithFrame:CGRectMake(earningsLbl.xx, dueTimeLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [dueTimeNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        dueTimeNameLbl.text = @"总收益";
        [backView addSubview:dueTimeNameLbl];
        
        UILabel *numberDaysLbl = [[UILabel alloc]initWithFrame:CGRectMake(earningsNameLbl.xx , dueTimeNameLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5)];
        numberDaysLbl.text = @"已加速5天";
        numberDaysLbl.font = FONT(10);
        numberDaysLbl.textAlignment = NSTextAlignmentCenter;
        numberDaysLbl.frame = CGRectMake(earningsNameLbl.xx , dueTimeNameLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5);
        numberDaysLbl.textColor = kHexColor(@"#1EC153");
        [backView addSubview:numberDaysLbl];
        
        
        
        
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
