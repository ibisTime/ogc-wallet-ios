
//
//  OrderRecordTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "OrderRecordTableView.h"
#import "OrderRecordCell.h"
#define OrderRecord @"OrderRecordCell"
@interface OrderRecordTableView()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *selectBtn;
    UIView *lineView;
}

@end

@implementation OrderRecordTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[OrderRecordCell class] forCellReuseIdentifier:OrderRecord];
//        [self registerClass:[InvestmentBuyCell class] forCellReuseIdentifier:InvestmentBuy];
//        [self registerClass:[PayWayCell class] forCellReuseIdentifier:PayWay];
        
        
        
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    OrderRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[OrderRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
//    OrderRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderRecord forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    cell.models = self.models[indexPath.row];
//    if (cell.dataArray.count > 0) {
//        cell.dataArray = self.dataArray;
//    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return 66;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
