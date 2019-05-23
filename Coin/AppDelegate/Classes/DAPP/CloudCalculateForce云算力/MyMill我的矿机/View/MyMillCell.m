//
//  MyMillCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillCell.h"

@implementation MyMillCell
{
    UILabel *nameLbl;
    UILabel *stateLbl;
    UILabel *timeLbl;
    UILabel *depositLbl;
    UILabel *amountLbl;
    UILabel *earningsLbl;
    UILabel *dueTimeLbl;
    UILabel *numberDaysLbl;
    UILabel *dueTimeNameLbl;
    UILabel *earningsNameLbl;
    UIView *lineView;
    UIImageView *timeImg;
    
    NSTimer *_countDownTimer;
    NSInteger secondsCountDown;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 165)];
        
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的backView
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 10, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [backView addSubview:nameLbl];
        
        stateLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx, 10, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        stateLbl.textColor = kHexColor(@"#FB6B6B");
        [backView addSubview:stateLbl];
        
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [timeLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [backView addSubview:timeLbl];
        
        
        depositLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx, nameLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        
        [depositLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        
        
        
        
        [backView addSubview:depositLbl];
        
        
        timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45 - 8 - 12 - depositLbl.width, nameLbl.yy + 9, 12, 12)];
        timeImg.image = kImage(@"时间");
        [backView addSubview:timeImg];
        
        
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH - 30, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [backView addSubview:lineView];
        
        amountLbl = [UILabel labelWithFrame:CGRectMake(0, lineView.yy + 26, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
//        amountLbl.text = @"1BTC";
        [backView addSubview:amountLbl];
        
        UILabel *amountNameLbl = [UILabel labelWithFrame:CGRectMake(0, amountLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        amountNameLbl.text = @"购买本金";
        [amountNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [backView addSubview:amountNameLbl];
        
        earningsLbl = [UILabel labelWithFrame:CGRectMake(amountLbl.xx, lineView.yy + 26, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:nil];
//        earningsLbl.text = @"70hHEY";
        earningsLbl.text = @"0.00";
        [backView addSubview:earningsLbl];
        
        earningsNameLbl = [UILabel labelWithFrame:CGRectMake(amountLbl.xx, earningsLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [earningsNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        earningsNameLbl.text = @"已获得收益";
        [backView addSubview:earningsNameLbl];
        
        
        
        dueTimeLbl = [UILabel labelWithFrame:CGRectMake(earningsNameLbl.xx, lineView.yy + 19, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:nil];
//        dueTimeLbl.text = @"0.00";
        [backView addSubview:dueTimeLbl];
        
        dueTimeNameLbl = [UILabel labelWithFrame:CGRectMake(earningsLbl.xx, dueTimeLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [dueTimeNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        dueTimeNameLbl.text = @"到期时间";
        [backView addSubview:dueTimeNameLbl];
        
        numberDaysLbl = [[UILabel alloc]initWithFrame:CGRectMake(earningsNameLbl.xx , dueTimeNameLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5)];
        
        numberDaysLbl.font = FONT(10);
        numberDaysLbl.textAlignment = NSTextAlignmentCenter;
        numberDaysLbl.frame = CGRectMake(earningsNameLbl.xx , dueTimeNameLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5);
        numberDaysLbl.textColor = kHexColor(@"#1EC153");
        [backView addSubview:numberDaysLbl];
        
        
        
        
    }
    return self;
}

-(void)setModel:(MyMillModel *)model
{
    _model = model;
    nameLbl.text = model.machine[@"name"];
    stateLbl.text = model.statussStr;
    if ([model.status isEqualToString:@"0"]) {
        stateLbl.textColor = kHexColor(@"#1EC153");
    }
    if ([model.status isEqualToString:@"1"]) {
        stateLbl.textColor = kHexColor(@"#1EC153");
    }
    if ([model.status isEqualToString:@"2"]) {
        [stateLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    }
    
    if ([model.continueFlag isEqualToString:@"1"]) {
        stateLbl.frame = CGRectMake(nameLbl.xx, 10, (SCREEN_WIDTH - 60)/2, 20);
        depositLbl.hidden = NO;
        timeImg.hidden = NO;
        depositLbl.frame = CGRectMake(timeLbl.xx, nameLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 20);
        secondsCountDown = [self dateTimeDifferenceWithStartTime:[model.continueStartTime convertToDetailDate]];

        if (secondsCountDown >0) {
            [_countDownTimer invalidate];
            _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
            NSString *str_hour = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
            NSString *str_minute = [NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
            NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];
            
            NSString *text = [NSString stringWithFormat:@"%@:%@:%@后可涡环",str_hour,str_minute,str_second];
            
            NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
            [attributeStr addAttribute:NSForegroundColorAttributeName
                                 value:kHexColor(@"#F49671")
                                 range:NSMakeRange(0, str_hour.length + str_minute.length + str_minute.length + 2)];
            depositLbl.attributedText = attributeStr;
            [depositLbl sizeToFit];
            depositLbl.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - depositLbl.width, nameLbl.yy + 5, depositLbl.width, 20);
            timeImg.frame = CGRectMake(SCREEN_WIDTH - 45 - 8 - 12 - depositLbl.width, nameLbl.yy + 9, 12, 12);
        }else
        {
            NSString *text = @"涡环失效";
            NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
            [attributeStr addAttribute:NSForegroundColorAttributeName
                                 value:kHexColor(@"#F49671")
                                 range:NSMakeRange(0, 0)];
            depositLbl.attributedText = attributeStr;
            [depositLbl sizeToFit];
            depositLbl.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - depositLbl.width, nameLbl.yy + 5, depositLbl.width, 20);
            timeImg.frame = CGRectMake(SCREEN_WIDTH - 45 - 8 - 12 - depositLbl.width, nameLbl.yy + 9, 12, 12);
        }
        
        
        
    }else
    {
        stateLbl.frame =CGRectMake(nameLbl.xx, 10, (SCREEN_WIDTH - 60)/2, 45);
        depositLbl.hidden = YES;
        timeImg.hidden = YES;
    }
    
    
    timeLbl.text = [model.createTime convertDate];
    
    amountLbl.text = [NSString stringWithFormat:@"%.2fCNY",[model.amount floatValue]*[model.quantity integerValue]];
//
    dueTimeLbl.text = [model.endTime convertDate];
    if ([model.speedDays integerValue] > 0) {
        numberDaysLbl.text = [NSString stringWithFormat:@"已加速%@天",model.speedDays];
        dueTimeLbl.frame = CGRectMake(earningsNameLbl.xx, lineView.yy + 19, (SCREEN_WIDTH - 30)/3, 22.5);
        dueTimeNameLbl.frame = CGRectMake(earningsLbl.xx, dueTimeLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5);
        numberDaysLbl.hidden = NO;
        
    }else
    {
        dueTimeLbl.frame = CGRectMake(earningsNameLbl.xx, lineView.yy + 26, (SCREEN_WIDTH - 30)/3, 22.5);
        dueTimeNameLbl.frame = CGRectMake(earningsLbl.xx, dueTimeLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5);
        numberDaysLbl.hidden = YES;
    }
    
    numberDaysLbl.frame = CGRectMake(earningsNameLbl.xx , dueTimeNameLbl.yy + 4, (SCREEN_WIDTH - 30)/3, 16.5);
    [self EarnedIncome];
}

//numbernLbl.text = [CoinUtil convertToRealCoin:[numberFormatter stringFromNumber:dataDic[@"totalAward"]] coin:responseObject[@"data"][@"cvalue"]];

-(void)setCvalue:(NSString *)cvalue
{
    _cvalue = cvalue;
    [self EarnedIncome];
}

-(void)EarnedIncome
{
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    if (_model.incomeActual > 0) {
        earningsLbl.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:_model.incomeActual coin:_cvalue],_cvalue];
//    }
//    else
//    {
//        earningsLbl.text = [NSString stringWithFormat:@"0%@",_cvalue];
//    }
}

-(void)countDownAction{
    //倒计时-1
    secondsCountDown--;
    
    //重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
    
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
    
    NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];
    
    NSString *text = [NSString stringWithFormat:@"%@:%@:%@后可涡环",str_hour,str_minute,str_second];
    NSMutableAttributedString*attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName
                         value:kHexColor(@"#F49671")
                         range:NSMakeRange(0, 8)];
    depositLbl.attributedText = attributeStr;
    [depositLbl sizeToFit];
    depositLbl.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - depositLbl.width, nameLbl.yy + 5, depositLbl.width, 20);
    timeImg.frame = CGRectMake(SCREEN_WIDTH - 45 - 8 - 12 - depositLbl.width, nameLbl.yy + 9, 12, 12);
    
}




//计算日期
-(NSInteger)dateTimeDifferenceWithStartTime:(NSString *)startTime

{
    
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startDate =[formatter dateFromString:startTime];
    
    
    NSDate *now = [NSDate date];
    NSString *nowstr = [formatter stringFromDate:now];
    NSDate *nowDate = [formatter dateFromString:nowstr];
    
    
    
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [nowDate timeIntervalSince1970]*1;
    NSTimeInterval value = start - end;
    
    
    
    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
    int house = (int)value / (3600)%3600;
    
    int day = (int)value / (24 * 3600) %(3600 * 24);
    
    NSString *str;
    
    NSInteger time;//剩余时间为多少分钟

    
    time = day*24*60*60 + house*60*60 + minute*60 + second;
    
    return time;
    
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
