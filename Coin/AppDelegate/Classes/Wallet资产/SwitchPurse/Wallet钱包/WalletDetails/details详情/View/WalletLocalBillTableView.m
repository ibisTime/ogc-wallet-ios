//
//  WalletLocalBillTableView.m
//  Coin
//
//  Created by shaojianfei on 2018/6/15.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WalletLocalBillTableView.h"
#import "BillCell.h"
#import "LocalBillCell.h"
@interface  WalletLocalBillTableView()<UITableViewDelegate, UITableViewDataSource>


@end
static NSString *identifierCell = @"BillListCell";
static NSString *identifierLocalBillCell = @"LocalBillCell";


@implementation WalletLocalBillTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        

        
        [self registerClass:[BillCell class] forCellReuseIdentifier:identifierCell];
        [self registerClass:[LocalBillCell class] forCellReuseIdentifier:identifierLocalBillCell];

        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.trxs.count > 0) {
        return self.trxs.count;
    }else if (self.ustds.count > 0) {
        return self.ustds.count;
    }else{
        return self.bills.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LocalBillCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierLocalBillCell forIndexPath:indexPath];
    cell.currencyModel = self.billModel;
    [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    if (self.trxs.count > 0) {
        cell.trxModel = self.trxs[indexPath.row];
    }else if (self.ustds.count > 0) {
        cell.usdtModel = self.ustds[indexPath.row];
    }else
    {
        cell.billModel = self.bills[indexPath.row];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 76;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *contentView = [[UIView alloc] init];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    [contentView addSubview:backView];
    
    UILabel *lab = [UILabel labelWithFrame:CGRectMake(15, 0, kScreenWidth - 35, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
    [backView addSubview:lab];
    lab.text =[NSString stringWithFormat:@"%@",[LangSwitcher switchLang:@"交易记录" key:nil]];
    
    
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(contentView.mas_top);
//        make.right.equalTo(contentView.mas_right).offset(-15);
//        make.width.equalTo(@75);
//        make.height.equalTo(@40);
//    }];
    
    return contentView;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}


@end
