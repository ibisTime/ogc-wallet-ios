//
//  InvestmentTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "InvestmentTableView.h"
//V
#import "InvestmentHeadCell.h"
#define InvestmentHead @"InvestmentHeadCell"
//#import "AccountMoneyCellTableViewCell.h"
@interface InvestmentTableView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arr;
}

@end

@implementation InvestmentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InvestmentHeadCell class] forCellReuseIdentifier:InvestmentHead];
        //        [self registerClass:[AccountMoneyCellTableViewCell class] forCellReuseIdentifier:platformCell1];
        
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InvestmentHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:InvestmentHead forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 320;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}


@end
