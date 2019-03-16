//
//  PlatformTableView.m
//  ljs
//
//  Created by 蔡卓越 on 2018/3/21.
//  Copyright © 2018年 caizhuoyue. All rights reserved.
//

#import "PlatformTableView.h"
//V
#import "MyAsstesCell.h"
//#import "AccountMoneyCellTableViewCell.h"
@interface PlatformTableView()<UITableViewDelegate, UITableViewDataSource,MyAsstesDelegate>
{
    NSMutableArray *arr;
}

@end

@implementation PlatformTableView

static NSString *MyAsstes = @"MyAsstesCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyAsstesCell class] forCellReuseIdentifier:MyAsstes];
//        [self registerClass:[AccountMoneyCellTableViewCell class] forCellReuseIdentifier:platformCell1];

    }
    
    return self;
}


#pragma mark - UITableViewDataSource;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAsstesCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.delegate = self;
    if (self.platforms.count > 0) {
        cell.platforms = self.platforms;
    }
    
    return cell;
    
}

-(void)MyAsstesButton:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
}

//-(void)intoBtnClick:(UIButton *)sender
//{
//    [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[sender.tag] setTitle:@"转入"];
//}
//
//-(void)rollOutBtnClick:(UIButton *)sender
//{
//    [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[sender.tag] setTitle:@"转出"];
//}
//
//-(void)billBtnClick:(UIButton *)sender
//{
//    [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[sender.tag] setTitle:@"账单"];
//}

//设置cell可编辑状态
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
////定义编辑样式为删除样式
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleNone;
//}
//
////设置返回存放侧滑按钮数组
//-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    //这是iOS8以后的方法
//    UITableViewRowAction *transferBtn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[LangSwitcher switchLang:@"转账" key:nil] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:setCurrencyModel:setTitle:)]) {
//            if (self.isLocal == YES) {
//                [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[indexPath.row] setTitle:@"转账"];
////                [self WhetherOrNotShown];
////                for (int j = 0; j<self.platforms.count; j++) {
////                    if ([arr[indexPath.row][@"symbol"] isEqualToString:self.platforms[j].symbol]) {
////                        [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[j] setTitle:@"转账"];
////                    }
////                }
//            }else
//            {
//                [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[indexPath.row] setTitle:@"转账"];
//            }
//
//        }
//    }];
//
//
//    UITableViewRowAction *collectionBtn = [UITableViewRowAction  rowActionWithStyle:UITableViewRowActionStyleNormal title:[LangSwitcher switchLang:@"收款" key:nil] handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:setCurrencyModel:setTitle:)]) {
//            if (self.isLocal == YES) {
//                [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[indexPath.row] setTitle:@"收款"];
////                [self WhetherOrNotShown];
////                for (int j = 0; j<self.platforms.count; j++) {
////                    if ([arr[indexPath.row][@"symbol"] isEqualToString:self.platforms[j].symbol]) {
////                        [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[j] setTitle:@"收款"];
////                    }
////                }
//            }else
//            {
//                [self.refreshDelegate refreshTableView:self setCurrencyModel:self.platforms[indexPath.row] setTitle:@"收款"];
//            }
//
//        }
//
//    }];
////    transferBtn.backgroundColor = [UIColor blueColor];
////
////    collectionBtn.backgroundColor = [UIColor orangeColor];
//    return @[transferBtn,collectionBtn];
//
//}



#pragma mark - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    self.selectBlock(indexPath.row);
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.platforms.count> 0) {
        return self.platforms.count * 100 + 20;
    }
    return 0.01;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
