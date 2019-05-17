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
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        MyMillDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        if (indexPath.section == 0) {
            NSArray *leftAry = @[@"矿机型号",@"台数",@"今日算力",@"运行情况"];
            NSArray *rightAry = @[@"HEY 007D",@"7台",@"0.1%*7台=0.7%",@"运行中（2019-01-07 20:00:00失效）"];
            cell.leftLbl.text = leftAry[indexPath.row];
            cell.rightLbl.text = rightAry[indexPath.row];
            if (indexPath.row == 3) {
                cell.lineView.hidden = YES;
            }else
            {
                cell.lineView.hidden = NO;
            }
        }
        if (indexPath.section == 1) {
            NSArray *leftAry = @[@"加速情况",@"连存状态"];
            NSArray *rightAry = @[@"已加速0天",@"将在24:00:00开启连存"];
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
    return cell;
    
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
        
        UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(15, 20, 100, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [titleLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        titleLbl.text = @"出矿记录";
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
