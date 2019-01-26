//
//  OrderRecordCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "OrderRecordCell.h"

@implementation OrderRecordCell
{

    int minutes;
    int seconds;
    NSTimer *_countDownTimer;
    NSInteger secondsCountDown;
    OrderRecordModel *orderModels;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(14, 18, 30, 30)];
        [self addSubview:_headImg];
        
        _nameLbl = [UILabel labelWithFrame:CGRectMake(60, 14.5, 100, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        
        [self addSubview:_nameLbl];
        
        
        _stateLbl = [UILabel labelWithFrame:CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [self addSubview:_stateLbl];
        
        
        _timeLbl = [UILabel labelWithFrame:CGRectMake(60, 43.5, 0, 11) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#333333")];
        [self addSubview:_timeLbl];
        
        
        _stateLbl2 = [UILabel labelWithFrame:CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#999999")];
        [self addSubview:_stateLbl2];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 65, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

-(void)setRow:(NSInteger)row
{
    
}


-(void)setModels:(OrderRecordModel *)models
{
    orderModels = models;
    
    [_countDownTimer invalidate];
    
    if ([models.status isEqualToString:@"0"]) {
        self.headImg.image = kImage(@"待支付-订单");
        
        if ([models.type isEqualToString:@"0"]) {
            _nameLbl.text = @"买入";
        }else
        {
            _nameLbl.text = @"卖出";
        }
        [_nameLbl sizeToFit];
        _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
        
        _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        NSDate *currentDate = [NSDate date];
        [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        
        NSString *invalidDatetime = [models.invalidDatetime convertToDetailDate];
        
        [self dateTimeDifferenceWithStartTime:dateString endTime:invalidDatetime];
        [_countDownTimer invalidate];
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
        
        _stateLbl.text = [NSString stringWithFormat:@"%@%d分%d秒",[LangSwitcher switchLang:@"剩余付款时间：" key:nil],minutes,seconds];
        secondsCountDown =minutes*60 + seconds;
        _stateLbl.font = FONT(12);
        _stateLbl.textColor = kHexColor(@"#0EC55B");
        
        _timeLbl.text = [models.createDatetime convertToDetailDate];
        [_timeLbl sizeToFit];
        _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
        
        _stateLbl2.text = @"待支付";
        _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
        _stateLbl2.textColor = kHexColor(@"#0EC55B");
    }
    
    if (([models.status isEqualToString:@"1"] || [models.status isEqualToString:@"2"])) {
        self.headImg.image = kImage(@"已完成-订单");
        if ([models.type isEqualToString:@"0"]) {
            _nameLbl.text = @"买入";
        }else
        {
            _nameLbl.text = @"卖出";
        }
        
        [_nameLbl sizeToFit];
        _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
        
        _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
        NSString *leftAmount = [CoinUtil convertToRealCoin:models.count coin:@"BTC"];
        if ([models.type isEqualToString:@"0"]) {
            _stateLbl.text = [NSString stringWithFormat:@"+%@BTC",leftAmount];
        }else
        {
            _stateLbl.text = [NSString stringWithFormat:@"-%@BTC",leftAmount];
        }
        
        _stateLbl.font = FONT(14);
        _stateLbl.textColor = kHexColor(@"#333333");
        
        _timeLbl.text = [models.createDatetime convertToDetailDate];
        [_timeLbl sizeToFit];
        _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
        if ([models.status isEqualToString:@"1"]) {
            _stateLbl2.text = [LangSwitcher switchLang:@"已支付" key:nil];
        }else
        {
            _stateLbl2.text = [LangSwitcher switchLang:@"已完成" key:nil];
        }
        
        _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
        _stateLbl2.textColor = kHexColor(@"#D53D3D");

    }
    if (([models.status isEqualToString:@"3"] || [models.status isEqualToString:@"4"])) {
    
        self.headImg.image = kImage(@"已取消-订单");
        
        if ([models.type isEqualToString:@"0"]) {
            _nameLbl.text = [LangSwitcher switchLang:@"买入" key:nil];
        }else
        {
            _nameLbl.text = [LangSwitcher switchLang:@"卖出" key:nil];
        }
        [_nameLbl sizeToFit];
        _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
        
        _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
        if ([models.status isEqualToString:@"3"]) {
            _stateLbl.text = [LangSwitcher switchLang:@"用户取消订单" key:nil];
        }else
        {
            _stateLbl.text = [LangSwitcher switchLang:@"平台取消订单" key:nil];
        }
        _stateLbl.font = FONT(12);
        _stateLbl.textColor = kHexColor(@"#999999");
        
        _timeLbl.text = [models.createDatetime convertToDetailDate];
        [_timeLbl sizeToFit];
        _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
        
        _stateLbl2.text = @"已取消";
        _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
        _stateLbl2.textColor = kHexColor(@"#999999");

        
    }
    
    
    if ([models.status isEqualToString:@"5"]) {
        self.headImg.image = kImage(@"已超时-订单");
        if ([models.type isEqualToString:@"0"]) {
            _nameLbl.text = @"买入";
        }else
        {
            _nameLbl.text = @"卖出";
        }
        [_nameLbl sizeToFit];
        _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
        
        _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
        _stateLbl.text = @"订单超时";
        _stateLbl.font = FONT(12);
        _stateLbl.textColor = kHexColor(@"#999999");
        
        _timeLbl.text = [models.createDatetime convertToDetailDate];
        [_timeLbl sizeToFit];
        _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
        
        _stateLbl2.text = @"已取消";
        _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
        _stateLbl2.textColor = kHexColor(@"#999999");

    }


}



-(void)countDownAction{
    //倒计时-1
    secondsCountDown--;
    
    //重新计算 时/分/秒
//    NSString *str_hour = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
    
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
    
    NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];
    
//    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_minute,str_second];
    //修改倒计时标签及显示内容
    self.stateLbl.text = [NSString stringWithFormat:@"剩余付款时间：%@分%@秒",str_minute,str_second];
    
    
    //当倒计时到0时做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        
        [_countDownTimer invalidate];
        self.headImg.image = kImage(@"已超时-订单");
        _nameLbl.text = @"BTC";
        [_nameLbl sizeToFit];
        _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
        
        _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
        _stateLbl.text = @"订单超时";
        _stateLbl.font = FONT(12);
        _stateLbl.textColor = kHexColor(@"#999999");
        
        _timeLbl.text = [orderModels.createDatetime convertToDetailDate];
        [_timeLbl sizeToFit];
        _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
        
        _stateLbl2.text = @"已取消";
        _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
        _stateLbl2.textColor = kHexColor(@"#999999");
    }
    
}



- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
     [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 *3600)%3600;
    int day = (int)value / (24 *3600);
    NSString *str;
    if (day != 0) {
       
        str = [NSString stringWithFormat:@"剩余付款时间：%d天%d小时%d分%d秒",day,house,minute,second];
        }else if (day==0 && house !=0)
        {
            str = [NSString stringWithFormat:@"剩余付款时间：%d小时%d分%d秒",house,minute,second];
        }else if (day==0 && house==0 && minute!=0)
        {
            str = [NSString stringWithFormat:@"剩余付款时间：%d分%d秒",minute,second];
        }else{
            str = [NSString stringWithFormat:@"剩余付款时间：%d秒",second];
        }
    
    minutes = minute;
    seconds = second;
    
    
    return str;
    
}




-(void)setDataArray:(NSArray *)dataArray
{
    self.dataArray = dataArray;
}

@end
