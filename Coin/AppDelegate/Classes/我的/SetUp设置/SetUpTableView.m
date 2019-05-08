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
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    
    cell.SwitchBlock = ^(NSInteger switchBlock) {
        if (self.SwitchBlock) {
            self.SwitchBlock(switchBlock);
        }
    };
    
    
    if (indexPath.row == 0) {
        
        
        if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
            cell.switchHidden = NO;
            cell.arrowHidden = YES;
            cell.sw.on = YES;
        }else{
            cell.switchHidden = NO;
            cell.arrowHidden = YES;
            cell.sw.on = NO;
            
        }
        
        
    }else
    {
        cell.switchHidden = YES;
    }
    //    self.group.items = self.group.sections[indexPath.section];
    //    SettingModel *settingModel = self.group.items[indexPath.row];
    
    //    CoinWeakSelf;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.iconImageView.hidden = YES;
    
    NSArray *nameArray1 = @[@"切换皮肤",@"本地货币",@"版本更新"];
    cell.titleLbl.text = [LangSwitcher switchLang:nameArray1[indexPath.row] key:nil];
    
    

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
