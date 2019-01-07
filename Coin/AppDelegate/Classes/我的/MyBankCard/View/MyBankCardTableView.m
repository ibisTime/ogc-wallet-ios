
//
//  MyBankCardTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyBankCardTableView.h"
#import "MyBankCardCell.h"
@interface MyBankCardTableView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arr;
}
@end

@implementation MyBankCardTableView

static NSString *MyBankCard = @"MyBankCardCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyBankCardCell class] forCellReuseIdentifier:MyBankCard];
        //        [self registerClass:[AccountMoneyCellTableViewCell class] forCellReuseIdentifier:platformCell1];
        
    }
    
    return self;
}


#pragma mark - UITableViewDataSource;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:MyBankCard forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 173;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
