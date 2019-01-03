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
#import "InvestmentBuyCell.h"
#define InvestmentBuy @"InvestmentBuyCell"
#import "PayWayCell.h"
#define PayWay @"PayWayCell"
//#import "AccountMoneyCellTableViewCell.h"
@interface InvestmentTableView()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *selectBtn;
    UIView *lineView;
}

@end

@implementation InvestmentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InvestmentHeadCell class] forCellReuseIdentifier:InvestmentHead];
        [self registerClass:[InvestmentBuyCell class] forCellReuseIdentifier:InvestmentBuy];
        [self registerClass:[PayWayCell class] forCellReuseIdentifier:PayWay];
        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        InvestmentHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:InvestmentHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        InvestmentBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:InvestmentBuy forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    PayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:PayWay forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 220;
    }
    if (indexPath.section == 1) {
        return 176;
    }
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 1) {
        return 55;
    }
    if (section == 2) {
        return 10;
    }
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        UIView *headView = [UIView new];
        
        NSArray *btnArray = @[@"买入",@"卖出"];
        for (int i = 0; i < 2; i ++) {
            UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#999999") backgroundColor:kWhiteColor titleFont:16];
            btn.frame = CGRectMake(i % 2 * SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2, 45);
            [btn setTitleColor:kHexColor(@"#FA7D0E") forState:(UIControlStateSelected)];
            if (i == 0) {
                btn.selected = YES;
                selectBtn = btn;
            }
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [headView addSubview:btn];
        }
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 1)];
        bottomLine.backgroundColor = kLineColor;
        [headView addSubview:bottomLine];
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2/2 - 20, 55 - 3, 40, 3)];
        lineView.backgroundColor = kHexColor(@"#FA7D0E");
        kViewRadius(lineView, 1.5);
        [headView addSubview:lineView];
        
        
        
        
        return headView;
    }
    
    return [UIView new];
}

-(void)BtnClick:(UIButton *)sender
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}


@end
