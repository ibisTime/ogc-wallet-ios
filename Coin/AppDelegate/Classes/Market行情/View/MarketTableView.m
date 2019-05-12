//
//  MarketTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MarketTableView.h"
#import "MarketCell.h"
@interface MarketTableView ()<UITableViewDataSource, UITableViewDelegate>
{
    MarketCell *cell;
}
@end


@implementation MarketTableView



- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[MarketCell class] forCellReuseIdentifier:@"AlertsCell"];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"AlertsCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[MarketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 66;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *topView = [[UIView alloc]init];
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [headView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [topView addSubview:headView];
    
    UILabel *currcuyLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/3 - 10 - 50, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    currcuyLbl.text = @"币种名称";
    [headView addSubview:currcuyLbl];
    
    UIButton *priceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    priceBtn.frame = CGRectMake(currcuyLbl.xx, 0, (SCREEN_WIDTH/3 - 10)/2 - 7.5 + 25, 35);
    [priceBtn setTitle:@"价格(¥)" forState:(UIControlStateNormal)];
    [priceBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    priceBtn.titleLabel.font = FONT(12);
    priceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [priceBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
        [priceBtn setImage:kImage(@"箭头") forState:(UIControlStateNormal)];
    }];
    [headView addSubview:priceBtn];
    
    UIButton *riseAndFallBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    riseAndFallBtn.frame = CGRectMake(priceBtn.xx + 15, 0, (SCREEN_WIDTH/3 - 10)/2 - 7.5 + 25, 35);
    [riseAndFallBtn setTitle:@"24H涨跌" forState:(UIControlStateNormal)];
    [riseAndFallBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    riseAndFallBtn.titleLabel.font = FONT(12);
    riseAndFallBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [riseAndFallBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
        [riseAndFallBtn setImage:kImage(@"箭头") forState:(UIControlStateNormal)];
    }];
    [headView addSubview:riseAndFallBtn];
    
    
    UIButton *marketValueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    marketValueBtn.frame = CGRectMake(riseAndFallBtn.xx, 0, (SCREEN_WIDTH/3 - 10), 35);
    [marketValueBtn setTitle:@"市值&市场占比" forState:(UIControlStateNormal)];
    [marketValueBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    marketValueBtn.titleLabel.font = FONT(12);
    marketValueBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [marketValueBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
        [marketValueBtn setImage:kImage(@"箭头") forState:(UIControlStateNormal)];
    }];
    [headView addSubview:marketValueBtn];
    
    return topView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}



@end
