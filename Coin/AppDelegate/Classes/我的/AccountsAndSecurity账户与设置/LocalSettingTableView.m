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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSArray *array = self.dataArray[section];
    return 5;
//    if (section == 0) {
//        if (self.dataArray.count >= 2) {
//            return 2;
//        }else
//        {
//            return self.dataArray.count;
//        }
//    }
//    if (section == 1) {
//        if (self.dataArray.count >= 6) {
//            return 4;
//        }else
//        {
//            return self.dataArray.count - 2;
//        }
//
//    }
//    return self.dataArray.count - 6;
    
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
//    NSArray *array = self.dataArray[indexPath.section];
//    NSString *name = array[indexPath.row][@"name"];
//    cell.titleLbl.text = [LangSwitcher switchLang:name key:nil];
//    name = array[indexPath.row][@"name"];
//    if (indexPath.section == 0) {
//
//        cell.titleLbl.text = [LangSwitcher switchLang:name key:nil];
//    }
//    if (indexPath.section == 1) {
//        name = array[indexPath.row + 2][@"name"];
//        cell.titleLbl.text = [LangSwitcher switchLang:name key:nil];
//    }
//    if (indexPath.section == 2) {
//         name = array[indexPath.row + 6][@"name"];
//
//    }
    
    NSArray *array = @[@"交易密码",@"手势密码",@"修改登录密码",@"绑定/修改邮箱",@"绑定/修改手机号"];
    NSString *name = array[indexPath.row];
    cell.titleLbl.text = [LangSwitcher switchLang:array[indexPath.row] key:nil];
    
    if ([name isEqualToString:@"手势密码"]) {
        
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
    if ([name isEqualToString:@"身份认证"]) {
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
    if ([name isEqualToString:@"绑定邮箱"]) {
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
    
    
    
    if ([name isEqualToString:@"绑定手机号码"]) {
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

    
    
//    NSArray *nameArray3;
//    nameArray3 = @[@"修改邮箱",@"修改手机号",@"修改登录密码"];

    

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
    NSString *name;
//    NSArray *array = self.dataArray[indexPath.section];
//    if (indexPath.section == 0) {
//    name = array[indexPath.row][@"name"];
//
//    }
//    if (indexPath.section == 1) {
//        name = self.dataArray[indexPath.row + 2][@"name"];
//    }
//    if (indexPath.section == 2) {
//        name = self.dataArray[indexPath.row + 6][@"name"];
//    }
//    [self.refreshDelegate refreshTableView:self setCurrencyModel:nil setTitle:name];
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
