//
//  AIQuantitativeDetailsTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeDetailsTableView.h"


#import "AIQuantitativeCell.h"
#import "ProductDetailsCell.h"
#import "ProductIntroductionCell.h"
@interface AIQuantitativeDetailsTableView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arr;
    ProductIntroductionCell *_cell;
}

@end

@implementation AIQuantitativeDetailsTableView

static NSString *MyAsstes = @"AIQuantitativeCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AIQuantitativeCell class] forCellReuseIdentifier:MyAsstes];
        [self registerClass:[ProductDetailsCell class] forCellReuseIdentifier:@"ProductDetailsCell"];
        
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark - UITableViewDataSource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AIQuantitativeCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        return cell;
    }
    if (indexPath.section == 1) {
        ProductDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        NSArray *nameAry = @[@"产品名称",@"认购币种",@"购买方式"];
        cell.nameLbl.text = nameAry[indexPath.row];
        NSArray *detailsAry = @[@"币币加BTC第一期",@"BTC",@"期满自动转入个人账户"];
        cell.detailsLbl.text = detailsAry[indexPath.row];
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    ProductIntroductionCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[ProductIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    
    return cell;
}

-(void)MyAsstesButton:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 155;
    }
    if (indexPath.section == 1) {
        return 55;
    }
    return _cell.detailsLbl.yy;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return 45;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        
        UILabel *headLbl = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        headLbl.text = @"产品详情";
        [headView addSubview:headLbl];
        
        return headView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
