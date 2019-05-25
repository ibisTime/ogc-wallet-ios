//
//  AIQuantitativeRecordTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeRecordTableView.h"

#import "PosMyInvestmentHeadView.h"
#import "AIQuantitativeRecordCell.h"
#define PosMyInvestmentDetails @"PosMyInvestmentDetailsCell"
@interface AIQuantitativeRecordTableView()<UITableViewDelegate, UITableViewDataSource>{
    NSInteger select;
    NSMutableArray *selectArray;
    AIQuantitativeRecordCell *cell;
}

@end
@implementation AIQuantitativeRecordTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        
        [self registerClass:[AIQuantitativeRecordCell class] forCellReuseIdentifier:PosMyInvestmentDetails];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    
    return self;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:PosMyInvestmentDetails forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.models.count > 0) {
        cell.model = self.models[indexPath.row];
    }
    if (self.dataArray > 0) {
        cell.dataArray = self.dataArray;
    }
    return cell;
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
