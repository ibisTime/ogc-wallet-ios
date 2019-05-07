//
//  SwitchPurseTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/6.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SwitchPurseTableView.h"
#import "SwitchPurseCell.h"

//#import "AccountMoneyCellTableViewCell.h"
@interface SwitchPurseTableView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arr;
}

@end

@implementation SwitchPurseTableView

static NSString *MyAsstes = @"MyAsstesCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[SwitchPurseCell class] forCellReuseIdentifier:MyAsstes];
    }
    return self;
}

#pragma mark - UITableViewDataSource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchPurseCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

-(void)createAndUpdateBtn:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *headView = [UIView new];
    
    UIButton *createBtn = [UIButton buttonWithTitle:@"创建钱包" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:16];
    createBtn.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 50);
    kViewBorderRadius(createBtn, 4, 1, kTabbarColor);
    [createBtn addTarget:self action:@selector(createAndUpdateBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    createBtn.tag = 100;
    [headView addSubview:createBtn];
    
    UIButton *updateBtn = [UIButton buttonWithTitle:@"导入钱包" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16];
    updateBtn.frame = CGRectMake(15, 85, SCREEN_WIDTH - 30, 50);
    kViewRadius(updateBtn, 5);
    [updateBtn addTarget:self action:@selector(createAndUpdateBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    updateBtn.tag = 101;
    [headView addSubview:updateBtn];
    
    return headView;
}


@end
