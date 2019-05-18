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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"订单详情" key:nil];
    self.titleText.font = FONT(18);
    
    self.navigationItem.titleView = self.titleText;
    
    
    
    FinancialDetailsView *backView = [[FinancialDetailsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    backView.model = self.model;
//    [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
    [self.view addSubview:backView];
    
}
@end
