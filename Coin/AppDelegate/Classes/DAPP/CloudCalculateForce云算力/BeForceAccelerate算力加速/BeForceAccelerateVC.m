//
//  BeForceAccelerateVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BeForceAccelerateVC.h"
#import "TLQrCodeVC.h"
@interface BeForceAccelerateVC ()

@end

@implementation BeForceAccelerateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = @"算力加速";
    self.navigationItem.titleView = self.titleText;
    
    
    [self initView];
}

-(void)initView
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 145)];
    
    [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
    backView.layer.cornerRadius=4;
    backView.layer.shadowOpacity = 0.22;// 阴影透明度
    backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的backView
    backView.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
    backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self.view addSubview:backView];
    
    UILabel *calculateNameLbl = [UILabel labelWithFrame:CGRectMake(0, 31, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    [calculateNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    calculateNameLbl.text = @"当前算力";
    [backView addSubview:calculateNameLbl];
    
    UILabel *calculateNumberLbl = [UILabel labelWithFrame:CGRectMake(0, calculateNameLbl.yy + 9, SCREEN_WIDTH - 30, 33.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(24) textColor:nil];
    calculateNumberLbl.text = @"0";
    [backView addSubview:calculateNumberLbl];
    
    UILabel *directDriveNameLbl = [UILabel labelWithFrame:CGRectMake(0, calculateNumberLbl.yy + 14, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    [directDriveNameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    directDriveNameLbl.text = @"当前购买矿机的直推用户：0";
    [backView addSubview:directDriveNameLbl];
    
    UILabel *introduceLbl1 = [UILabel labelWithFrame:CGRectMake(15, backView.yy + 17, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    [introduceLbl1 theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    introduceLbl1.text = @"每2个直推用户购买矿机，获得1天加速";
    [self.view addSubview:introduceLbl1];
    
    UILabel *introduceLbl2 = [UILabel labelWithFrame:CGRectMake(15, backView.yy + 42, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
    [introduceLbl2 theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    introduceLbl2.text = @"*加速仅针对30天（含）以上的矿机类型";
    [self.view addSubview:introduceLbl2];
    
    UIButton *buyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    buyBtn.frame = CGRectMake(15, introduceLbl2.yy + 62.5, SCREEN_WIDTH - 30, 48);
    [buyBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
    [buyBtn setTitle:@"推荐" forState:(UIControlStateNormal)];
    buyBtn.titleLabel.font = FONT(16);
    kViewRadius(buyBtn, 4);
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buyBtn];
    
}

-(void)buyBtnClick
{
    TLQrCodeVC *vc = [TLQrCodeVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
