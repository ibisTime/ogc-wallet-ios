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
#import "InvestmentModel.h"
@interface InvestmentVC ()<RefreshDelegate>
{
    CGFloat price;
}

@property (nonatomic , strong)InvestmentTableView *tableView;

@property (nonatomic , strong)PaymentInstructionsView *promptView;

@property (nonatomic , strong)NSMutableArray <InvestmentModel *>*models;

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
    
    [self loadData];
    [self loadDataPrice];
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
    
    
    UITextField *textField1 = [self.view viewWithTag:10000];
    UITextField *textField2 = [self.view viewWithTag:10001];
    
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入购买金额" key:nil]];
        return ;
    }
    
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入购买数量" key:nil]];
        return ;
    }
    
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = weakSelf.view;
    http.code = @"625270";
    http.parameters[@"count"] = textField2.text;
    http.parameters[@"receiveType"] = @"0";
    http.parameters[@"tradeAmount"] = textField1.text;
    http.parameters[@"tradeCurrency"] = @"BTC";
    http.parameters[@"tradePrice"] = @(price);
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
        OrderRecordVC *vc = [OrderRecordVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        [[UserModel user].cusPopView dismiss];
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
}

//购买
-(void)bottomBtnClick
{
//    [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:self.promptView];
    if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {
        TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
        vc.titleString = @"设置交易密码";
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:self.promptView];
    }
    
    
    
    
}

-(void)loadData
{
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    
    http.showView = weakSelf.view;
    http.code = @"650200";
    http.parameters[@"period"] = @"0";
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSDate* theDate;
    NSTimeInterval oneDay = 24*60*60*1;
    theDate = [currentDate initWithTimeIntervalSinceNow:-oneDay*30];
    NSString *dateString1 = [dateFormatter stringFromDate:theDate];
    http.parameters[@"startDatetime"] = dateString1;
    http.parameters[@"endDatetime"] = dateString;
    http.parameters[@"symbol"] = @"BTC";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"type"] = @"0";
    [http postWithSuccess:^(id responseObject) {
        
        self.models = [InvestmentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.models = self.models;
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

-(void)loadDataPrice
{
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    
    http.showView = weakSelf.view;
    http.code = @"650201";
    http.parameters[@"symbol"] = @"BTC";
    http.parameters[@"type"] = @"0";
    [http postWithSuccess:^(id responseObject) {
        
//        self.models = [InvestmentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        self.tableView.models = self.models;
//        [self.tableView reloadData];
        price = [responseObject[@"data"][@"price"] floatValue];
        self.tableView.price = price;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        
    }];
}


@end
