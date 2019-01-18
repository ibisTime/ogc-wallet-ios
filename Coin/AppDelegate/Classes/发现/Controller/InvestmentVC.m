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
//折线图
#import "SmoothChartView.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
#import "MyBankCardVC.h"
#import "MyBankCardModel.h"
#import "HBAlertPasswordView.h"
@interface InvestmentVC ()<RefreshDelegate,HBAlertPasswordViewDelegate>
{
    CGFloat sellerPrice;
    NSString *sellerFeeRate;
    CGFloat buyPrice;
    NSString *buyFeeRate;
    
    
    UILabel *sellLbl;
    UILabel *buyingLbl;
    UILabel *titleLbl;
    NSInteger indexBtnTag;
}

@property (nonatomic , strong)InvestmentTableView *tableView;
@property (nonatomic , strong)PaymentInstructionsView *promptView;
@property (nonatomic , strong)UIButton *bottomBtn;
@property (nonatomic , strong)MyBankCardModel *bankModel;
@property (nonatomic , strong)NSMutableArray <InvestmentModel *>*models;
//折线图
@property (nonatomic, strong)SmoothChartView *smoothView;;

@property (nonatomic , strong)NSArray *payWayArray;
@property (nonatomic , strong)NSDictionary *payWayDic;

@property (nonatomic , strong)HBAlertPasswordView *passWordView;
@end

@implementation InvestmentVC

-(HBAlertPasswordView *)passWordView
{
    if (!_passWordView) {
        _passWordView = [[HBAlertPasswordView alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT/2 - 590/2/2, SCREEN_WIDTH - 30, 590/2)];
        _passWordView.backgroundColor = kWhiteColor;
        kViewRadius(_passWordView, 8);
        _passWordView.delegate = self;
    }
    return _passWordView;
}

#pragma mark - <HBAlertPasswordViewDelegate>
- (void)sureActionWithAlertPasswordView:(HBAlertPasswordView *)alertPasswordView password:(NSString *)password {
    
    if (password.length != 6) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入密码" key:nil]];
        return;
    }
    if ([TLUser isBlankString:self.bankModel.code] == YES) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请选择银行卡" key:nil]];
        return ;
    }
    
    UITextField *textField1 = [self.view viewWithTag:10000];
    UITextField *textField2 = [self.view viewWithTag:10001];
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = weakSelf.view;
    http.code = @"625271";
    http.parameters[@"count"] = @([textField2.text floatValue] * 100000000);
    http.parameters[@"bankCardCode"] = self.bankModel.code;
    http.parameters[@"tradeAmount"] = textField1.text;
    http.parameters[@"tradeCurrency"] = @"CNY";
    http.parameters[@"tradePrice"] = @(sellerPrice);
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"tradePwd"] = password;
    [http postWithSuccess:^(id responseObject) {
        OrderRecordVC *vc = [OrderRecordVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        [[UserModel user].cusPopView dismiss];
    } failure:^(NSError *error) {
        
    }];
//    self.passwordLabel.text = [NSString stringWithFormat:@"输入的密码为:%@", password];
}

- (InvestmentTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[InvestmentTableView alloc] initWithFrame:CGRectMake(0, 220 , SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight - 50 - kTabBarHeight - 220) style:UITableViewStyleGrouped];
        
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
    indexBtnTag = 0;
    self.tableView.indexBtnTag = 0;
    [self makeSmoothChartView];
//    kHexColor(@"#FA7D0E")
    _bottomBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"买入" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16];
    _bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50 - kTabBarHeight, SCREEN_WIDTH, 50);
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_bottomBtn];
    
    
    _promptView = [[PaymentInstructionsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH - 40, 210)];
    _promptView.backgroundColor = kWhiteColor;
    [_promptView.IkonwBtn addTarget:self action:@selector(promptIkonwBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    kViewRadius(_promptView, 4);
    [self.view addSubview:_promptView];
    
    CoinWeakSelf;
    [self.tableView addRefreshAction:^{
        [weakSelf loadData];
        [weakSelf loadDataPrice];
        [weakSelf payWay];
        
    }];
    [self.tableView beginRefreshing];
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField1 = [self.view viewWithTag:10000];
    UITextField *textField2 = [self.view viewWithTag:10001];
    
    
    if (index == 10000) {
        if (indexBtnTag == 0) {
            [self chooseMethodOfPayment];
        }else
        {
            MyBankCardVC *vc = [[MyBankCardVC alloc]init];
            vc.choose = @"选择";
            vc.hidesBottomBarWhenPushed = YES;
            CoinWeakSelf
            vc.returnValueBlock = ^(MyBankCardModel *model) {
                weakSelf.bankModel = model;
                weakSelf.tableView.PaymentMethods = weakSelf.bankModel.bankcardNumber;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (index == 0) {
        indexBtnTag = index;
        [_bottomBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
        [_bottomBtn setTitle:[LangSwitcher switchLang:@"买入" key:nil] forState:(UIControlStateNormal)];
        textField1.text = @"";
        textField2.text = @"";
    }else
    {
        indexBtnTag = index;
        [_bottomBtn setBackgroundColor:kHexColor(@"#FA7D0E") forState:(UIControlStateNormal)];
        [_bottomBtn setTitle:[LangSwitcher switchLang:@"卖出" key:nil] forState:(UIControlStateNormal)];
        textField1.text = @"";
        textField2.text = @"";
    }
    self.tableView.indexBtnTag = indexBtnTag;
    [self.tableView reloadData];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexBtnTag == 0) {
            [self chooseMethodOfPayment];
        }else
        {
            MyBankCardVC *vc = [[MyBankCardVC alloc]init];
            vc.choose = @"选择";
            vc.hidesBottomBarWhenPushed = YES;
            CoinWeakSelf
            vc.returnValueBlock = ^(MyBankCardModel *model) {
                weakSelf.bankModel = model;
                weakSelf.tableView.PaymentMethods = weakSelf.bankModel.bankcardNumber;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }
    }
}



//选择支付方式
-(void)chooseMethodOfPayment
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < self.payWayArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_payWayArray[i][@"name"]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];
            _payWayDic = _payWayArray[model.sid];
            self.tableView.payWayDic = self.payWayDic;
            [self.tableView reloadData];
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
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



//我的订单
-(void)myRecodeClick
{
    OrderRecordVC *vc = [OrderRecordVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


// 买卖
-(void)promptIkonwBtnClick
{
    
    UITextField *textField1 = [self.view viewWithTag:10000];
    UITextField *textField2 = [self.view viewWithTag:10001];
    
    if ([textField1.text floatValue] == 0) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"购买金额必须大于0" key:nil]];
        return ;
    }
    
    if ([textField2.text floatValue] == 0) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"购买数量必须大于0" key:nil]];
        return ;
    }
    
    
    if (indexBtnTag == 0) {
        CoinWeakSelf;
        TLNetworking *http = [[TLNetworking alloc] init];
        http.showView = weakSelf.view;
        http.code = @"625270";
        http.parameters[@"count"] = @([textField2.text floatValue] * 100000000);
        http.parameters[@"receiveType"] = _payWayDic[@"type"];
        http.parameters[@"tradeAmount"] = textField1.text;
        http.parameters[@"tradeCurrency"] = @"CNY";
        http.parameters[@"tradePrice"] = @(buyPrice);
        http.parameters[@"userId"] = [TLUser user].userId;
        [http postWithSuccess:^(id responseObject) {
            OrderRecordVC *vc = [OrderRecordVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            [[UserModel user].cusPopView dismiss];
        } failure:^(NSError *error) {
            
        }];
    }else
    {
        [[UserModel user].cusPopView dismiss];
        self.passWordView.priceLabel.text = [NSString stringWithFormat:@"%@ BTC",textField2.text];
        [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:self.passWordView];
        

    }
    

}

-(void)payWay
{
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = self.view;
    http.code = @"802034";
    http.parameters[@"symbol"] = @"BTC";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.payWayArray = responseObject[@"data"];
        self.payWayDic = self.payWayArray[0];
        self.tableView.payWayDic = self.payWayDic;
        [self.tableView reloadData];
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
        [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:self.promptView];
    }
}

-(void)loadData
{
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    
    http.showView = weakSelf.view;
    http.code = @"650200";
    http.parameters[@"period"] = @"1";
    
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
        
        NSMutableArray *arrayX = [NSMutableArray array];
        NSMutableArray *arrayY = [NSMutableArray array];
        if (_models.count == 1) {
            [arrayX addObjectsFromArray:@[@"1",@"2",@"3"]];
            [arrayY addObjectsFromArray:@[_models[0].price,_models[0].price,_models[0].price]];
        }else
        {
            
            for (int i = 0; i < _models.count; i ++) {
                if (i <= 30) {
                    [arrayX addObject:@(i + 1)];
                    [arrayY addObject:_models[i].price];
                }
            }
        }
        
        CGFloat maxPrice = ([[arrayY valueForKeyPath:@"@max.floatValue"] floatValue] + 100);
        CGFloat minPrice = ([[arrayY valueForKeyPath:@"@min.floatValue"] floatValue] - 100);
        
        _smoothView.arrY = @[[NSString stringWithFormat:@"%.0f",minPrice] ,[NSString stringWithFormat:@"%.0f",(maxPrice - minPrice)/4 + minPrice],[NSString stringWithFormat:@"%.0f",(maxPrice - minPrice)/4*2 + minPrice],[NSString stringWithFormat:@"%.0f",(maxPrice - minPrice)/4*3 + minPrice],[NSString stringWithFormat:@"%.0f",(maxPrice - minPrice)/4*4 + minPrice]];
        [_smoothView drawSmoothViewWithArrayX:arrayX andArrayY:arrayY andScaleX:(maxPrice - minPrice) andScalemax:maxPrice andScalemin:minPrice];
        [_smoothView refreshChartAnmition];
        
//        [self.tableView reloadxData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
}


//买入价   卖出价
-(void)loadDataPrice
{
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    
    http.showView = weakSelf.view;
    http.code = @"650201";
    http.parameters[@"symbol"] = @"BTC";
    http.parameters[@"type"] = @"0";
    [http postWithSuccess:^(id responseObject) {
        
        NSString *sell = [LangSwitcher switchLang:@"卖出价" key:nil];
        NSString *sellPrice = responseObject[@"data"][@"sellerPrice"];
        NSString *sellAll = [NSString stringWithFormat:@"%@ %@",sell,sellPrice];
        NSMutableAttributedString *sellAttrStr = [[NSMutableAttributedString alloc] initWithString:sellAll];
        [sellAttrStr addAttribute:NSFontAttributeName value:HGboldfont(16) range:NSMakeRange(sell.length,sellAll.length - sell.length)];
        [sellAttrStr addAttribute:NSForegroundColorAttributeName value:kHexColor(@"#E15E5E") range:NSMakeRange(sell.length,sellAll.length - sell.length)];
        sellLbl.attributedText = sellAttrStr;
        [sellLbl sizeToFit];
        sellLbl.frame = CGRectMake(SCREEN_WIDTH - 15 - sellLbl.width, 22, sellLbl.width, 16.5);
        
        NSString *buying = [LangSwitcher switchLang:@"买入价" key:nil];
        NSString *buyingPrice = responseObject[@"data"][@"buyPrice"];
        NSString *buyingAll = [NSString stringWithFormat:@"%@ %@",buying,buyingPrice];
        NSMutableAttributedString *buyingAttrStr = [[NSMutableAttributedString alloc] initWithString:buyingAll];
        [buyingAttrStr addAttribute:NSFontAttributeName value:HGboldfont(16) range:NSMakeRange(buying.length,buyingAll.length - buying.length)];
        [buyingAttrStr addAttribute:NSForegroundColorAttributeName value:kHexColor(@"#0EC55B") range:NSMakeRange(buying.length,buyingAll.length - buying.length)];
        buyingLbl.attributedText = buyingAttrStr;
        [buyingLbl sizeToFit];
        buyingLbl.frame = CGRectMake(SCREEN_WIDTH - 15 - sellLbl.width - 30 - buyingLbl.width, 22, buyingLbl.width, 16.5);
        
        titleLbl.frame = CGRectMake(15, 22, SCREEN_WIDTH - 60 - sellLbl.width - buyingLbl.width - 10, 16.5);

        
        buyPrice = [responseObject[@"data"][@"buyPrice"] floatValue];
        sellerPrice = [responseObject[@"data"][@"sellerPrice"] floatValue];
        
        buyFeeRate = responseObject[@"data"][@"buyFeeRate"];
        sellerFeeRate = responseObject[@"data"][@"sellerFeeRate"];
        if (indexBtnTag == 0) {
            self.tableView.price =  buyPrice;
            self.tableView.Rate = buyFeeRate;
        }else
        {
            self.tableView.price =  sellerPrice;
            self.tableView.Rate = sellerFeeRate;
        }
        
        [self.tableView reloadData];
        
        [weakSelf.tableView endRefreshHeader];
    } failure:^(NSError *error) {
        
        [weakSelf.tableView endRefreshHeader];
    }];
}

-(void)makeSmoothChartView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    topView.backgroundColor = kWhiteColor;
    [self.view addSubview:topView];
    
    titleLbl = [UILabel labelWithFrame:CGRectMake(15, 22, 0, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
    titleLbl.text = [LangSwitcher switchLang:@"近30日走势图" key:nil];
    [topView addSubview:titleLbl];
    
    
    sellLbl = [UILabel labelWithFrame:CGRectMake(0, 22, 0, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
    [topView addSubview:sellLbl];
    
    
    buyingLbl = [UILabel labelWithFrame:CGRectMake(0, 22, 0, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
    [topView addSubview:buyingLbl];
    titleLbl.frame = CGRectMake(15, 22, SCREEN_WIDTH - 60 - sellLbl.width - buyingLbl.width - 10, 16.5);
    
    _smoothView = [[SmoothChartView alloc] initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH - 30,149)];
    _smoothView.backgroundColor = [UIColor whiteColor];
    [topView addSubview:_smoothView];
    [_smoothView refreshChartAnmition];
    [self.view addSubview:topView];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 50, 40, 149)];
    rightView.backgroundColor = kWhiteColor;
    [self.view addSubview:rightView];
}

@end
