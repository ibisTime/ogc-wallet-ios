//
//  FinancialDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/9.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FinancialDetailsVC.h"
#import "FinancialDetailsView.h"
@interface FinancialDetailsVC ()

@end

@implementation FinancialDetailsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self navigationSetDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
}
//
//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self navigationwhiteColor];
    //    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"订单详情" key:nil];
    self.titleText.font = FONT(18);
    self.titleText.textColor = kWhiteColor;
    self.navigationItem.titleView = self.titleText;
    
    
    FinancialDetailsView *backView = [[FinancialDetailsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    [self.view addSubview:backView];
    
}
@end
