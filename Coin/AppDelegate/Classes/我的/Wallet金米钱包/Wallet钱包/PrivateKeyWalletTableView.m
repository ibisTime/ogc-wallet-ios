//
//  PrivateKeyWalletTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/3/23.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PrivateKeyWalletTableView.h"

//V
#import "PrivateKeyWalletCell.h"
//#import "AccountMoneyCellTableViewCell.h"
@interface PrivateKeyWalletTableView()<UITableViewDelegate, UITableViewDataSource,MyAsstesDelegate>
{
    NSMutableArray *arr;
}

@end

@implementation PrivateKeyWalletTableView

static NSString *MyAsstes = @"MyAsstesCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[PrivateKeyWalletCell class] forCellReuseIdentifier:MyAsstes];
        //        [self registerClass:[AccountMoneyCellTableViewCell class] forCellReuseIdentifier:platformCell1];
        
    }
    
    return self;
}


#pragma mark - UITableViewDataSource;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivateKeyWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.platforms.count> 0) {
        return self.platforms.count * 80 + 20;
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
