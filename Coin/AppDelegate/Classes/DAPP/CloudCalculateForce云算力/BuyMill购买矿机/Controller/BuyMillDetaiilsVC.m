//
//  BuyMillDetaiilsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BuyMillDetaiilsVC.h"
#import "BuyMillBuyVC.h"
@interface BuyMillDetaiilsVC ()

@end

@implementation BuyMillDetaiilsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"水滴详情";
    self.navigationItem.titleView = self.titleText;
    
    [self.topView theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [backView theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    [self.view addSubview:backView];
    
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 100)];
    [backView1 theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    [self.view addSubview:backView1];
    
    
    NSArray *leftArray = @[@"水滴",@"每日产能",@"锁仓期限",@"总产能"];
    NSArray *rightArray = @[_model.name,
                            [NSString stringWithFormat:@"%.2f%%",[_model.dailyOutput floatValue] * 100],
                            [NSString stringWithFormat:@"%@天",_model.daysLimit],
                            [NSString stringWithFormat:@"%.2f%%",[_model.dailyOutput floatValue] * [_model.daysLimit integerValue] * 100]];
    for (int i = 0; i < 4; i ++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, i % 4 * 50, SCREEN_WIDTH, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [backView addSubview:lineView];
        
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectMake(15, i % 4 * 50, 100, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [leftLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        leftLbl.text = leftArray[i];
        [backView addSubview:leftLbl];
        
        UILabel *rightLbl = [UILabel labelWithFrame:CGRectMake(leftLbl.xx, i % 4 * 50, SCREEN_WIDTH - leftLbl.xx, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        rightLbl.text = rightArray[i];
        [backView addSubview:rightLbl];
    }
    
    
    NSArray *leftArray1 = @[@"总水滴数量",@"剩余水滴数量"];
    NSArray *rightArray1 = @[[NSString stringWithFormat:@"%ld滴",[_model.stockTotal integerValue]],
                             [NSString stringWithFormat:@"%ld滴",[_model.stockTotal integerValue] - [_model.stockOut integerValue]]];
    for (int i = 0; i < 2; i ++) {
        if (i == 1) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, i % 2 * 50, SCREEN_WIDTH, 0.5)];
            [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
            [backView1 addSubview:lineView];
        }
        
        
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectMake(15, i % 2 * 50, 120, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [leftLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        leftLbl.text = leftArray1[i];
        [backView1 addSubview:leftLbl];
        
        UILabel *rightLbl = [UILabel labelWithFrame:CGRectMake(leftLbl.xx, i % 2 * 50, SCREEN_WIDTH - leftLbl.xx, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        rightLbl.text = rightArray1[i];
        [backView1 addSubview:rightLbl];
    }
    
    UIButton *buyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    buyBtn.frame = CGRectMake(15, 310 + 65, SCREEN_WIDTH - 30, 48);
    [buyBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
    [buyBtn setTitle:@"购买" forState:(UIControlStateNormal)];
    kViewRadius(buyBtn, 4);
    buyBtn.titleLabel.font = FONT(16);
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buyBtn];
}

-(void)buyBtnClick
{
    BuyMillBuyVC *vc = [BuyMillBuyVC new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
