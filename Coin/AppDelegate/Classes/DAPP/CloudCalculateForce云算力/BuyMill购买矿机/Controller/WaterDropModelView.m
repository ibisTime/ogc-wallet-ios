//
//  WaterDropModelView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/23.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "WaterDropModelView.h"

@implementation WaterDropModelView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 305)];
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        kViewRadius(backView, 4);
        [self addSubview:backView];
        
        NSArray *leftAry = @[@"购买产品",@"购买金额",@"到期日期",@"预计收益"];
        for (int i = 0; i < 4; i ++) {
            UILabel *leftLbl = [UILabel labelWithFrame:CGRectMake(20, 30 + i % 4 * 45, 90, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
            [leftLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            leftLbl.text = leftAry[i];
            [self addSubview:leftLbl];
            
            UILabel *rightLbl = [UILabel labelWithFrame:CGRectMake(110, 30 + i % 4 * 45, SCREEN_WIDTH - 110 - 60 - 20, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
            rightLbl.tag = 100 + i;
            [self addSubview:rightLbl];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, leftLbl.yy, SCREEN_WIDTH - 60 - 40, 0.5)];
            [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
            [self addSubview:lineView];
            
            
        }
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 60 - 20, 15, 20, 20);
        [deleteBtn setImage:kImage(@"红包 删除") forState:(UIControlStateNormal)];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:deleteBtn];
        
        UIButton *confirm = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:14];
        confirm.frame = CGRectMake(20, 235, SCREEN_WIDTH - 15 - 60 - 20, 45);
        kViewRadius(confirm, 2);
        self.confirm = confirm;
        [self addSubview:confirm];
        
    }
    return self;
}

-(void)setModel:(BuyMillListModel *)model
{
    _model = model;
    UILabel *label1 = [self viewWithTag:100];
    
    
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSTimeInterval starttime =  24 * 60 * 60 * [model.daysLimit integerValue];
    NSDate * startYear = [currentDate dateByAddingTimeInterval:+starttime];
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:startYear];
    
    UILabel *label3 = [self viewWithTag:102];
    
    
    label1.text = model.name;
    label3.text = startDate;
    
    
    
    
}

-(void)setOrderInformation:(NSString *)orderInformation
{
    UILabel *label2 = [self viewWithTag:101];
    label2.text = orderInformation;
    
    UILabel *label4 = [self viewWithTag:103];
    label4.text = [NSString stringWithFormat:@"%.2f%%",[_model.dailyOutput floatValue] * [_model.daysLimit integerValue] * [orderInformation floatValue]];
    
}

-(void)deleteBtnClick
{
    [[UserModel user].cusPopView dismiss];
}

@end
