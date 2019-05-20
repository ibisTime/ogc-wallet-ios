//
//  FeedBookDetailsTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/20.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FeedBookDetailsTableView.h"

#import "FeedBookDetailsCell.h"
@interface FeedBookDetailsTableView()<UITableViewDelegate, UITableViewDataSource>


@end
@implementation FeedBookDetailsTableView

static NSString *identifierCell = @"FeedBookDetailsCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        //        [self setContentInset:UIEdgeInsetsMake(5, 0.0, -5, 0.0)];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[FeedBookDetailsCell class] forCellReuseIdentifier:identifierCell];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        NSArray *arr = [self.questionModel.pic componentsSeparatedByString:@"||"];
        if (arr.count > 0) {
            for (int i = 0; i < arr.count; i ++) {
                UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15 + i % 4 * (SCREEN_WIDTH - 30)/4, 10 + i / 4 * (SCREEN_WIDTH - 30)/4, (SCREEN_WIDTH - 30 - 30)/4, (SCREEN_WIDTH - 30 - 30)/4)];
                [img sd_setImageWithURL:[NSURL URLWithString:[arr[i] convertImageUrl]]];
                kViewRadius(img , 4);
                [cell addSubview:img];
            }
        }
        return cell;
    }
    
    FeedBookDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *array = @[@"所在端",@"问题描述",@"复现步骤",@"",@"备注",@"提交时间",@"bug状态"];
    cell.nameLbl.text = array[indexPath.row];
    if (indexPath.row == 0) {
        cell.detailsLbl.text = self.questionModel.deviceSystem;
    }
    if (indexPath.row == 1) {
        cell.detailsLbl.text = self.questionModel.Description;
    }
    if (indexPath.row == 2) {
        cell.detailsLbl.text = self.questionModel.reappear;
    }
    if (indexPath.row == 4) {
        cell.detailsLbl.text = self.questionModel.commitNote;
    }
    if (indexPath.row == 5) {
        cell.detailsLbl.text = [self.questionModel.commitDatetime convertDate];
    }
    if (indexPath.row == 6) {
        if ([self.questionModel.status isEqualToString:@"0"]) {
            cell.detailsLbl.text = [LangSwitcher switchLang:@"待确认" key:nil];
        }else if ([self.questionModel.status isEqualToString:@"1"])
        {
            cell.detailsLbl.text = [LangSwitcher switchLang:@"问题解决中" key:nil];
        }else if ([self.questionModel.status isEqualToString:@"2"])
        {
            cell.detailsLbl.text = [LangSwitcher switchLang:@"反馈失败" key:nil];
        }else
        {
            cell.detailsLbl.text = [LangSwitcher switchLang:@"反馈成功" key:nil];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        NSArray *arr = [self.questionModel.pic componentsSeparatedByString:@"||"];
        if (arr.count > 0) {
            float numberToRound;
            int result;
            numberToRound = (arr.count)/4.0;
            result = (int)ceilf(numberToRound);
            return result * (SCREEN_WIDTH - 30)/4 + 10;
        }else
        {
            return 0;
        }
        
    }
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
