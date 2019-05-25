//
//  FlashAgainstTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FlashAgainstTableView.h"
//#import "FlashAgainstCell.h"
#import "FlashAgainstRecordCell.h"
@interface FlashAgainstTableView()<UITableViewDelegate, UITableViewDataSource,UIViewControllerPreviewingDelegate>



@end
@implementation FlashAgainstTableView

static NSString *identifierCell = @"FlashAgainstCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
//        [self registerClass:[FlashAgainstCell class] forCellReuseIdentifier:identifierCell];
        [self registerClass:[FlashAgainstRecordCell class] forCellReuseIdentifier:@"FlashAgainstRecordCell"];
        
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FlashAgainstRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlashAgainstRecordCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
    cell.model = self.recordModels[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 111;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    
    UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
    titleLbl.text = @"兑换记录";
    [self addSubview:titleLbl];
    
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
