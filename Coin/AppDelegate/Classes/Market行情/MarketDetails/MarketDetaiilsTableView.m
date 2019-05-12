//
//  MarketDetaiilsTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MarketDetaiilsTableView.h"

#import "MarketDetaiilsCell.h"
#import "BriefCell.h"
@interface MarketDetaiilsTableView ()<UITableViewDataSource, UITableViewDelegate>
{
    MarketDetaiilsCell *cell;
    BriefCell *briefCell;
}
@end


@implementation MarketDetaiilsTableView



- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[MarketDetaiilsCell class] forCellReuseIdentifier:@"AlertsCell"];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.name isEqualToString:@"行情"]) {
        return 11;
    }else
    {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.name isEqualToString:@"行情"]) {
        static NSString *identifier = @"AlertsCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[MarketDetaiilsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *identifier = @"briefCell";
        briefCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!briefCell){
            briefCell = [[BriefCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        briefCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return briefCell;
    }
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.name isEqualToString:@"行情"]) {
        return 66;
    }
    return briefCell.IntroductionContactLbl.yy + 20;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.name isEqualToString:@"行情"]) {
        return 35;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([self.name isEqualToString:@"行情"]) {
        UIView *topView = [[UIView alloc]init];
        
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        [headView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [topView addSubview:headView];
        
        UILabel *currcuyLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/3 - 10 - 50, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        currcuyLbl.text = @"币种名称";
        [headView addSubview:currcuyLbl];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(currcuyLbl.xx, 0, SCREEN_WIDTH/3 - 10 - 50, 35) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        priceLbl.text = @"价格";
        [headView addSubview:priceLbl];
        
        UILabel *turnoverLbl = [UILabel labelWithFrame:CGRectMake(priceLbl.xx, 0, SCREEN_WIDTH/3 - 10 - 50, 35) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        turnoverLbl.text = @"24H成交额";
        [headView addSubview:turnoverLbl];
        
        return topView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
