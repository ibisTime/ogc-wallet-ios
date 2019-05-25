//
//  BuyMillListCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BuyMillListCell.h"

@implementation BuyMillListCell
{
    UILabel *nameLbl;
    UILabel *symbolLbl;
    UILabel *nissanCanLbl;
    UILabel *percentageLbl;
    UIView *progressView;
}
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
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH - 60)/2, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        nameLbl.text = @"HEY 007D型";
        [backView addSubview:nameLbl];
        
        symbolLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx, 0, (SCREEN_WIDTH - 60)/2, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        symbolLbl.text = @"HEY 水滴型号";
        [backView addSubview:symbolLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH - 30, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [backView addSubview:lineView];
        
        nissanCanLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.yy + 15, SCREEN_WIDTH - 30, 22.5)];
        
        nissanCanLbl.textColor = kTabbarColor;
        nissanCanLbl.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:nissanCanLbl];
        
        UIView *progressBackView = [[UIView alloc]initWithFrame:CGRectMake(23, nissanCanLbl.yy + 13, SCREEN_WIDTH - 23 - 53 - 30, 5)];
        [progressBackView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        kViewRadius(progressBackView, 2.5);
        [backView addSubview:progressBackView];
        
        percentageLbl = [UILabel labelWithFrame:CGRectMake(progressBackView.xx + 5, nissanCanLbl.yy + 7.5, 45, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:nil];
        percentageLbl.text = @"10%";
        [percentageLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [backView addSubview:percentageLbl];
        
        
        progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 5)];
        progressView.backgroundColor = kTabbarColor;
        kViewRadius(progressView, 2.5);
        [progressBackView addSubview:progressView];
        
        NSArray *numberAry = @[@"1000CNY",@"7天",@"100滴"];
        NSArray *nameAry = @[@"起购",@"期限",@"剩余"];
        for (int i = 0; i < 3; i ++) {
            UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(0 + i % 3 * (SCREEN_WIDTH - 30)/3, progressBackView.yy + 21.5, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
            numberLbl.text = numberAry[i];
            numberLbl.tag = 100 + i;
            [backView addSubview:numberLbl];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0 + i % 3 * (SCREEN_WIDTH - 30)/3, progressBackView.yy + 48, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
            [nameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            nameLbl.text = nameAry[i];
            
            [backView addSubview:nameLbl];
        }
    }
    return self;
}


-(void)setModel:(BuyMillListModel *)model
{
    nameLbl.text = model.name;
    symbolLbl.text = [NSString stringWithFormat:@"%@ 水滴型号",model.symbol];
    nissanCanLbl.text = [NSString stringWithFormat:@"%@%%日产能",model.dailyOutput];
    progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 23 - 53 - 30) * [model.stockOut integerValue] / [model.stockTotal integerValue], 5);
    percentageLbl.text = [NSString stringWithFormat:@"%.1f%%",[model.stockOut floatValue] / [model.stockTotal floatValue] * 100];
    UILabel *label1 = [self viewWithTag:100];
    UILabel *label2 = [self viewWithTag:101];
    UILabel *label3 = [self viewWithTag:102];
    label1.text = [NSString stringWithFormat:@"%@CNY起购",model.amount];
    label2.text = [NSString stringWithFormat:@"%@天",model.daysLimit];
    label3.text = [NSString stringWithFormat:@"%ld滴",[model.stockTotal integerValue] - [model.stockOut integerValue]];
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
