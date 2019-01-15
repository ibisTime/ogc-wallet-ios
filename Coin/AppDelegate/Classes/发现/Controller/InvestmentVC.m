//
//  InvestmentVC.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/28.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "InvestmentVC.h"
#import "InvestmentTableView.h"
#import "OrderRecordVC.h"
#import "PaymentInstructionsView.h"
@interface InvestmentVC ()<RefreshDelegate>

@property (nonatomic , strong)InvestmentTableView *tableView;

@property (nonatomic , strong)PaymentInstructionsView *promptView;

@end

@implementation InvestmentVC


- (InvestmentTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[InvestmentTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight - 50 - kTabBarHeight) style:UITableViewStylePlain];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

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
    [self CustomNavigation];
    [self.view addSubview:self.tableView];
    
    UIButton *bottomBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"买入" key:nil] titleColor:kWhiteColor backgroundColor:kHexColor(@"#FA7D0E") titleFont:16];
    bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50 - kTabBarHeight, SCREEN_WIDTH, 50);
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:bottomBtn];
    
    
    _promptView = [[PaymentInstructionsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH - 40, 210)];
    _promptView.backgroundColor = kWhiteColor;
    [_promptView.IkonwBtn addTarget:self action:@selector(promptIkonwBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    kViewRadius(_promptView, 4);
    [self.view addSubview:_promptView];
    
    
}

-(void)CustomNavigation
{
    self.titleText.text = [LangSwitcher switchLang:@"BTC交易区" key:nil];
    self.titleText.font = FONT(18);
    self.navigationItem.titleView = self.titleText;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:[LangSwitcher switchLang:@"订单" key:nil] forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
}



-(void)myRecodeClick
{
    OrderRecordVC *vc = [OrderRecordVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)promptIkonwBtnClick
{
    OrderRecordVC *vc = [OrderRecordVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    [[UserModel user].cusPopView dismiss];
}


-(void)bottomBtnClick
{
    [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:self.promptView];
}






@end
