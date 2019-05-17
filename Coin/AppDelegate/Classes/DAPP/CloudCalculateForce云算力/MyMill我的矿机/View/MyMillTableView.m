//
//  MyMillTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillTableView.h"

#import "MyMillCell.h"
@interface MyMillTableView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arr;
}

@end

@implementation MyMillTableView

static NSString *MyAsstes = @"EggplantAccountCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyMillCell class] forCellReuseIdentifier:MyAsstes];
    }
    return self;
}

#pragma mark - UITableViewDataSource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMillCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    
    return cell;
}

-(void)MyAsstesButton:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 180;
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
