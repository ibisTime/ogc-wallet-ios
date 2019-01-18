//
//  PayFailureVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PayFailureVC.h"
#import "PayFailureView.h"
@interface PayFailureVC ()

@end

@implementation PayFailureVC

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

    
    PayFailureView *backView = [[PayFailureView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    backView.models = self.models;
    [self.view addSubview:backView];
    
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
