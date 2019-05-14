//
//  BuyMillListCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BuyMillListCell.h"

@implementation BuyMillListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 190)];
        
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的backView
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH - 60)/2, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        nameLbl.text = @"HEY 007D型";
        [backView addSubview:nameLbl];
        
        UILabel *symbolLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx, 0, (SCREEN_WIDTH - 60)/2, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        symbolLbl.text = @"HEY 矿机";
        [backView addSubview:symbolLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH - 30, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [backView addSubview:lineView];
        
        UILabel *nissanCanLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.yy + 15, SCREEN_WIDTH - 30, 22.5)];
        nissanCanLbl.text = @"0.1%日产能";
        nissanCanLbl.textColor = kTabbarColor;
        nissanCanLbl.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:nissanCanLbl];
        
        UIView *progressBackView = [[UIView alloc]initWithFrame:CGRectMake(23, nissanCanLbl.yy + 13, SCREEN_WIDTH - 23 - 53 - 30, 5)];
        [progressBackView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        kViewRadius(progressBackView, 2.5);
        [backView addSubview:progressBackView];
        
        UILabel *percentageLbl = [UILabel labelWithFrame:CGRectMake(progressBackView.xx + 5, nissanCanLbl.yy + 7.5, 45, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:nil];
        percentageLbl.text = @"10%";
        [percentageLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [backView addSubview:percentageLbl];
        
        
        UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 5)];
        progressView.backgroundColor = kTabbarColor;
        kViewRadius(progressView, 2.5);
        [progressBackView addSubview:progressView];
        
        NSArray *numberAry = @[@"1000CNY",@"7天",@"100台"];
        NSArray *nameAry = @[@"起购",@"期限",@"剩余"];
        for (int i = 0; i < 3; i ++) {
            UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(0 + i % 3 * (SCREEN_WIDTH - 30)/3, progressBackView.yy + 21.5, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
            numberLbl.text = numberAry[i];
            [backView addSubview:numberLbl];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0 + i % 3 * (SCREEN_WIDTH - 30)/3, progressBackView.yy + 48, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
            [nameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            nameLbl.text = nameAry[i];
            [backView addSubview:nameLbl];
        }
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
