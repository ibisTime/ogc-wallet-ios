//
//  SellDetalisVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/17.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SellDetalisVC.h"
#import "SellDetalisView.h"
@interface SellDetalisVC ()

@end

@implementation SellDetalisVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"订单详情" key:nil];

    self.navigationItem.titleView = self.titleText;
    
    
    SellDetalisView *backView = [[SellDetalisView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
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
