//
//  MyMillDetailsTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillDetailsTableView.h"
#import "MyMillDetailsCell.h"
#import "OreRecordCell.h"
@interface MyMillDetailsTableView()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation MyMillDetailsTableView

static NSString *MyAsstes = @"EggplantAccountCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyMillDetailsCell class] forCellReuseIdentifier:MyAsstes];
        [self registerClass:[OreRecordCell class] forCellReuseIdentifier:@"OreRecordCell"];
        
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark - UITableViewDataSource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return 2;
    }
    
    return self.models.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        MyMillDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        
        NSString *continueOutput;
        if ([_model.continueStatus isEqualToString:@"1"]) {
            continueOutput = self.model.continueOutput;
        }else
        {
            continueOutput = self.model.machine[@"dailyOutput"];
        }
        
        if (indexPath.section == 0) {
            NSArray *leftAry = @[@"型号水滴",@"滴数",@"今日热量",@"运行情况"];
            NSArray *rightAry = @[self.model.machine[@"name"],
                                  self.model.quantity,
                                  [NSString stringWithFormat:@"%.2f%%",[continueOutput floatValue]],
                                  self.model.statussStr];
            cell.leftLbl.text = leftAry[indexPath.row];
            cell.rightLbl.text = rightAry[indexPath.row];
            
            if (indexPath.row == 3)
            {
                cell.lineView.hidden = YES;
            }
            else
            {
                cell.lineView.hidden = NO;
            }
        }
        if (indexPath.section == 1) {
            NSArray *leftAry = @[@"加速情况",@"涡环状态"];
            NSString *EvenState;
            if ([self.model.continueStatus isEqualToString:@"0"]) {
                
                EvenState = @"未涡环";
            }
            if ([self.model.continueStatus isEqualToString:@"1"]) {
                EvenState = @"涡环中";
            }
            if ([self.model.continueStatus isEqualToString:@"2"]) {
                EvenState = @"涡环失效";
            }
            
            NSArray *rightAry = @[[NSString stringWithFormat:@"已加速%@天",self.model.speedDays],
                                  EvenState];
            cell.leftLbl.text = leftAry[indexPath.row];
            cell.rightLbl.text = rightAry[indexPath.row];
            if (indexPath.row == 1) {
                cell.lineView.hidden = YES;
            }else
            {
                cell.lineView.hidden = NO;
            }
        }
        return cell;
    }
    
    OreRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OreRecordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    cell.model = self.models[indexPath.row];
    return cell;
    
}

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
    
    int house = (int)value / (24 * 3600)%3600;
    
    int day = (int)value / (24 * 3600);
    
    NSString *str;
    
    NSInteger time;//剩余时间为多少分钟
    
    
    time = day*24*60*60 + house*60*60 + minute*60 + second;
    
    return time;
    
}


-(void)MyAsstesButton:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 60;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 40;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section ==2) {
        UIView *headView = [UIView new];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [headView addSubview:backView];
        
        UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [titleLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        titleLbl.text = @"电子雨滴分解记录";
        [backView addSubview:titleLbl];
        
        
        return headView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 10;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        UIView *headView = [UIView new];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [lineView theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [headView addSubview:lineView];
        
        return headView;
    }
    return [UIView new];
}


@end
