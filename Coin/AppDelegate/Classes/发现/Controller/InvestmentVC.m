//
//  InvestmentVC.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/28.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "InvestmentVC.h"
//折线图
#import "SJAxisView.h"
#import "SJChartLineView.h"
#import "SJLineChart.h"
@interface InvestmentVC ()
//折线图
@property (nonatomic, strong) SJLineChart *lineChart;
@end

@implementation InvestmentVC

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"BTC交易区" key:nil];
    self.titleText.font = FONT(18);
    self.navigationItem.titleView = self.titleText;
    [self createIncomeChartLineView];
}


/**创建“收益走势”图*/
-(void)createIncomeChartLineView{
    
    self.lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(0  , 10, SCREEN_WIDTH , 200)];
    // 设置折线图属性
    _lineChart.xScaleMarkLEN = 60;// 可以不设，会根据视图的宽度自适应,设置后如果折线图的宽度大于视图宽度，折线图可以滑动
//    self.lineChart.title = @"七日收益比"; // 折线图名称
    self.lineChart.maxValue = 0.5;   // 最大值
    self.lineChart.yMarkTitles = @[@"0.0",@"0.1",@"0.2",@"0.3",@"0.4",@"0.5"];
    [self.lineChart setXMarkTitlesAndValues:@[@{@"item":@"1.1",@"count":@(0.30)},@{@"item":@"1.1",@"count":@(0.40)},@{@"item":@"1.1",@"count":@(0.40)},@{@"item":@"1.1",@"count":@(0.00)},@{@"item":@"1.1",@"count":@(0.20)},@{@"item":@"1.1",@"count":@(0.40)},@{@"item":@"1.1",@"count":@(0.20)}] titleKey:@"item" valueKey:@"count"];
    [self.lineChart mapping];
    [self.view addSubview:_lineChart];
    
}




@end
