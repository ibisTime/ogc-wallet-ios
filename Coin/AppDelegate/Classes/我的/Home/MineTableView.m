//
//  MineTableView.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/9.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "MineTableView.h"
#import "MyCell1.h"

@interface MineTableView ()<UITableViewDataSource, UITableViewDelegate,MyCellDelegate1>

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
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    MyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:Cell1 forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kClearColor;
    cell.delegate = self;
    NSArray *array = self.dataArray[indexPath.section];
    cell.dataArray = array;
    cell.blessing = self.blessing;
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
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];

//    self.mineGroup.items = self.mineGroup.sections[indexPath.section];
//
//    if (self.mineGroup.items[indexPath.row].action) {
//
//        self.mineGroup.items[indexPath.row].action();
//    }
    
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
    NSArray *array = self.dataArray[indexPath.section];
    return array.count * 60;
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
