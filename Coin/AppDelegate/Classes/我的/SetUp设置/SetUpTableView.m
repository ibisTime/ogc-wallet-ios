//
//  SetUpTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SetUpTableView.h"
#import "SettingCell.h"

@interface SetUpTableView ()<UITableViewDataSource, UITableViewDelegate>

@end
static NSString *identifierCell = @"SettingCell";

@implementation SetUpTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[SettingCell class] forCellReuseIdentifier:identifierCell];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (section == 0) {
//        return 5;
//    }
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    
    //    self.group.items = self.group.sections[indexPath.section];
    //    SettingModel *settingModel = self.group.items[indexPath.row];
    
    //    CoinWeakSelf;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.switchHidden = YES;
    //    cell.iconImageView.hidden = YES;
    
    NSArray *nameArray1 = @[@"本地货币",@"版本更新"];
    cell.titleLbl.text = [LangSwitcher switchLang:nameArray1[indexPath.row] key:nil];
    
    
   
    cell.titleLbl.textColor = kTextColor;
    cell.titleLbl.font = Font(15.0);
    [cell.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(20);
        
        make.centerY.equalTo(cell.mas_centerY);
        make.right.lessThanOrEqualTo(cell.accessoryImageView.mas_left);
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
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

@end
