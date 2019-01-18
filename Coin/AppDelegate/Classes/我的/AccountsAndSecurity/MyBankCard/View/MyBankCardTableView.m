
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
    return self.models.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:MyBankCard forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.models = self.models[indexPath.row];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.deleteBtn.tag = indexPath.row;
    [cell.defaultBtn addTarget:self action:@selector(defaultBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.defaultBtn.tag = indexPath.row;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

-(void)deleteBtnClick:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag setTitle:@"删除"];
}

-(void)defaultBtnClick:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag setTitle:@"默认"];
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
