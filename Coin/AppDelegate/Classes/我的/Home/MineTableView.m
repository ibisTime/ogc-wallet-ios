//
//  MineTableView.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/9.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "MineTableView.h"
#import "MyCell1.h"
#import "MineHeadCell.h"
@interface MineTableView ()<UITableViewDataSource, UITableViewDelegate,MineHeadDelegate>

@end

@implementation MineTableView

static NSString *Cell1 = @"MyCell1";
static NSString *Cell2 = @"MyCell2";
static NSString *Cell3 = @"MyCell3";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[MyCell1 class] forCellReuseIdentifier:Cell1];
        [self registerClass:[MineHeadCell class] forCellReuseIdentifier:@"MineHeadCell"];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 7;
    }
//    if (section == 2) {
//        return 3;
//    }
    return 1;
    
}

-(void)MineHeadDelegateSelectBtn:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag - 100];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        MineHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHeadCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    MyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:Cell1 forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kClearColor;
    
    if (indexPath.section == 1) {
        NSArray *array = @[@"账户与安全",@"我的收益",@"金米福分",@"地址本",@"帮助中心",@"问题反馈",@"设置"];
        [cell.iconImg theme_setImageIdentifier:array[indexPath.row] moduleName:ImgAddress];
        cell.iconLbl.text = array[indexPath.row];
        [cell.iconLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    }
//    if (indexPath.section == 2) {
//        NSArray *array = @[@"地址本",@"帮助中心",@"问题反馈"];
//        [cell.iconImg theme_setImageIdentifier:array[indexPath.row] moduleName:ImgAddress];
//        cell.iconLbl.text= array[indexPath.row];
//        [cell.iconLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
//    }
//    if (indexPath.section == 3) {
//        NSArray *array = @[@"设置"];
//        [cell.iconImg theme_setImageIdentifier:array[indexPath.row] moduleName:ImgAddress];
//        cell.iconLbl.text= array[indexPath.row];
//        [cell.iconLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
//    }
    
    return cell;
}

-(void)MyCellButtonSelectTag:(NSString *)btnStr
{
    [self.refreshDelegate refreshTableView:self setCurrencyModel:nil setTitle:btnStr];
}

-(void)BtnClick:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag - 100];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        if (self.dataArray.count >= 1) {
//            return 60;
//        }else
//        {
//            return 0.1;
//        }
//
//    }
//    if (indexPath.section == 1) {
//        if (self.dataArray.count >= 3) {
//            return 120;
//        }else
//        {
//            return 60;
//        }
//    }
//
//    if (self.dataArray.count == 4) {
//        return 60;
//    }
//    if (self.dataArray.count == 5) {
//        return 120;
//    }
//    if (self.dataArray.count == 6) {
//        return 180;
//    }

    if (indexPath.section == 0) {
        return 90;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

@end
