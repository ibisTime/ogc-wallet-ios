//
//  LocalSettingTableView.m
//  Coin
//
//  Created by shaojianfei on 2018/7/30.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "LocalSettingTableView.h"
#import "SettingCell.h"
#import "ZLGestureLockViewController.h"

@interface LocalSettingTableView ()<UITableViewDataSource, UITableViewDelegate>

@end
static NSString *identifierCell = @"SettingCell";

@implementation LocalSettingTableView
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
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 4;
    }

    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    
    cell.SwitchBlock = ^(NSInteger switchBlock) {
        if (self.SwitchBlock) {
            self.SwitchBlock(switchBlock);
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.switchHidden = YES;
//    cell.iconImageView.hidden = YES;
    
    NSArray *nameArray1 = @[@"交易密码",@"手势密码"];
    if (indexPath.section == 0) {
        cell.titleLbl.text = [LangSwitcher switchLang:nameArray1[indexPath.row] key:nil];
    }
    
    NSArray *nameArray2 = @[@"身份认证",@"绑定邮箱",@"绑定手机号",@"我的收款方式"];

    if (indexPath.section == 1) {
        cell.titleLbl.text = [LangSwitcher switchLang:nameArray2[indexPath.row] key:nil];

        if (indexPath.row == 0) {
            if ([TLUser isBlankString:[TLUser user].idNo] == NO)
            {
                cell.arrowHidden = YES;
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = [TLUser user].realName;
            }
            else
            {
                cell.arrowHidden = YES;
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = [LangSwitcher switchLang:@"未认证" key:nil];
            }
        }
        NSRange rang = NSMakeRange(3, 4);

        if (indexPath.row == 1) {
            if ([TLUser isBlankString:[TLUser user].email] == NO)
            {
                cell.arrowHidden = YES;
                cell.rightLabel.hidden = NO;

                
                if ([TLUser user].email.length>10) {
                    cell.rightLabel.text =[[TLUser user].email stringByReplacingCharactersInRange:rang withString:@"****"];
                }else
                {
                    cell.rightLabel.text = [TLUser user].email;
                }
            }
            else
            {
                cell.rightLabel.hidden = YES;
                cell.arrowHidden = NO;
            }
        }
        if (indexPath.row == 2) {
            if ([TLUser isBlankString:[TLUser user].mobile] == NO)
            {
                cell.arrowHidden = YES;
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = [[TLUser user].mobile stringByReplacingCharactersInRange:rang withString:@"****"];
            }
            else
            {
                cell.rightLabel.hidden = YES;
                cell.arrowHidden = NO;
            }
        }
    }
    
    
    
    NSArray *nameArray3;
    nameArray3 = @[@"修改邮箱",@"修改手机号",@"修改登录密码"];

    if (indexPath.section == 2) {
        cell.titleLbl.text = [LangSwitcher switchLang:nameArray3[indexPath.row] key:nil];
    }

    cell.titleLbl.textColor = kTextColor;
    cell.titleLbl.font = Font(15.0);
    [cell.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(20);
        
        make.centerY.equalTo(cell.mas_centerY);
        make.right.lessThanOrEqualTo(cell.accessoryImageView.mas_left);
    }];

    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            NSString *gesture =  [ZLGestureLockViewController gesturesPassword];
            if (gesture.length >0) {
                cell.switchHidden = NO;
                cell.arrowHidden = YES;
                cell.sw.on = YES;
            }else{
                cell.switchHidden = NO;
                cell.arrowHidden = YES;
                cell.sw.on = NO;

            }
        }
    }
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
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}


@end
