//
//  AddressBookTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AddressBookTableView.h"
#import "AddressBookCell.h"

@interface AddressBookTableView ()<UITableViewDataSource, UITableViewDelegate>

@end


@implementation AddressBookTableView

static NSString *MyFriendCell = @"MyFriendCellCell";


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[AddressBookCell class] forCellReuseIdentifier:@"AddressBookCell"];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressBookCell" forIndexPath:indexPath];
    [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.models[indexPath.row];
    return cell;
}


//1
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//2
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}
//3
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//4
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作

    

    
}
//5
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"802011";
        http.showView = self;
        http.parameters[@"id"] = self.models[indexPath.row].ID;
        
        [http postWithSuccess:^(id responseObject) {
            
            //        [self.navigationController popViewControllerAnimated:YES];
            //删除数据，和删除动画
            [self.models removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        } failure:^(NSError *error) {
            
        }];
    }];
    //编辑
    return @[deleteRowAction];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
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

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
