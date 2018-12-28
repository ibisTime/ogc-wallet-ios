//
//  InvestmentVC.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/28.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "InvestmentVC.h"

@interface InvestmentVC ()

@end

@implementation InvestmentVC


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"交易" key:nil];
    self.titleText.font = FONT(18);
    self.navigationItem.titleView = self.titleText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
