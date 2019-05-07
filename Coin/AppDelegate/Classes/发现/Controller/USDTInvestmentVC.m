//
//  USDTInvestmentVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/2/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "USDTInvestmentVC.h"
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

#import "SellDetalisVC.h"

#import "BnakCardVC.h"

#import "PayTreasureVC.h"
#import "OrderRecordModel.h"
#import "CurrencyModel.h"
#import "MyBankCardModel.h"
#import "ZQFaceAuthEngine.h"
#import "ZQOCRScanEngine.h"
#import "TLUploadManager.h"
@interface USDTInvestmentVC ()<RefreshDelegate,HBAlertPasswordViewDelegate,ZQFaceAuthDelegate,ZQOcrScanDelegate>
{
    CGFloat sellerPrice;
    NSString *sellerFeeRate;
    CGFloat buyPrice;
    NSString *buyFeeRate;
    
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    
    UILabel *sellLbl;
    UILabel *buyingLbl;
    UILabel *titleLbl;
    NSInteger indexBtnTag;
    
    NSString *type;
    
    NSInteger isRefresh;
    //    最大额度
    NSString *accept_order_max_cny_amount;
    //    最小额度
    NSString *accept_order_min_cny_amount;
    
}
@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*platforms;
@property (nonatomic, strong) NSTimer *timer;

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

@property (nonatomic , strong)NSMutableArray <MyBankCardModel *>*bankCardModels;


@end

@implementation USDTInvestmentVC

-(HBAlertPasswordView *)passWordView
{
    if (!_passWordView) {
        _passWordView = [[HBAlertPasswordView alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT/2 - 590/2/2 - 100, SCREEN_WIDTH - 30, 590/2 + 200)];
        
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
    http.parameters[@"tradeCoin"] = @"USDT";
    [http postWithSuccess:^(id responseObject) {
        
        
        
        CoinWeakSelf;
        TLNetworking *http1 = [[TLNetworking alloc] init];
        http1.showView = weakSelf.view;
        http1.code = @"625286";
        http1.parameters[@"code"] = responseObject[@"data"][@"code"];
        [http1 postWithSuccess:^(id responseObject) {
            
            SellDetalisVC *vc = [SellDetalisVC new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.models = [OrderRecordModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            
        }];
        
        textField1.text = @"";
        textField2.text = @"";
        [[UserModel user].cusPopView dismiss];
        
    } failure:^(NSError *error) {
        
    }];
    //    self.passwordLabel.text = [NSString stringWithFormat:@"输入的密码为:%@", password];
}

- (void)queryCenterTotalAmount {
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"802301";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    
    [http postWithSuccess:^(id responseObject) {
        
        self.platforms = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
        //        [self.tableView endRefreshHeader];
    } failure:^(NSError *error) {
        
        [self.tableView endRefreshHeader];
    }];
}

- (InvestmentTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[InvestmentTableView alloc] initWithFrame:CGRectMake(0, 220 , SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight - 50 - kTabBarHeight - 220) style:UITableViewStyleGrouped];
        _tableView.symbol = @"USDT";
        _tableView.refreshDelegate = self;
//        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(testTimerDeallo) userInfo:nil repeats:YES];
    [self queryCenterTotalAmount];
}

-(void)testTimerDeallo
{
    [self loadDataPrice];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    indexBtnTag = 0;
    self.tableView.indexBtnTag = 0;
    [self makeSmoothChartView];
    
    _bottomBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"买入USDT" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16];
    _bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 50 - kTabBarHeight, SCREEN_WIDTH, 50);
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_bottomBtn];
    
    
    _promptView = [[PaymentInstructionsView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH - 40, 210)];
    _promptView.backgroundColor = kWhiteColor;
    [_promptView.IkonwBtn addTarget:self action:@selector(promptIkonwBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    kViewRadius(_promptView, 4);
    [self.view addSubview:_promptView];
    type = @"0";
    CoinWeakSelf;
    [self.tableView addRefreshAction:^{
        [weakSelf loadData:type];
        [weakSelf loadDataPrice];
        [weakSelf payWay];
        [weakSelf ScopeOfPurchase];
        
    }];
    
    [self bankCard];
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
                weakSelf.tableView.bankModel = weakSelf.bankModel;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (index == 0) {
        indexBtnTag = index;
        [_bottomBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
        [_bottomBtn setTitle:[LangSwitcher switchLang:@"买入USDT" key:nil] forState:(UIControlStateNormal)];
        textField1.placeholder = [LangSwitcher switchLang:@"请输入买入金额" key:nil];
        textField2.placeholder = [LangSwitcher switchLang:@"请输入买入数量" key:nil];
        textField1.text = @"";
        textField2.text = @"";
        self.tableView.price =  buyPrice;
        self.tableView.Rate = buyFeeRate;
        self.tableView.balance = @"";
        type = @"0";
        
        [self loadData:type];
        
    }else
    {
        indexBtnTag = index;
        [_bottomBtn setBackgroundColor:kHexColor(@"#FA7D0E") forState:(UIControlStateNormal)];
        [_bottomBtn setTitle:[LangSwitcher switchLang:@"卖出USDT" key:nil] forState:(UIControlStateNormal)];
        textField1.text = @"";
        textField2.text = @"";
        textField1.placeholder = [LangSwitcher switchLang:@"请输入卖出金额" key:nil];
        textField2.placeholder = [LangSwitcher switchLang:@"请输入卖出数量" key:nil];
        self.tableView.price =  sellerPrice;
        self.tableView.Rate = sellerFeeRate;
        type = @"1";
        
        for (int i = 0; i < self.platforms.count; i ++) {
            CurrencyModel *model = self.platforms[i];
            
            if ([model.currency isEqualToString:@"USDT"]) {
                NSString *amount = [CoinUtil convertToRealCoin:model.amount coin:model.currency];
                
                NSString *frozenAmount = [CoinUtil convertToRealCoin:model.frozenAmount coin:model.currency];
                NSString *available = [amount subNumber:frozenAmount];
                
                self.tableView.balance = available;
            }
        }
        [self loadData:type];
    }
    self.tableView.indexBtnTag = indexBtnTag;
    [self.tableView reloadData];
}

-(void)bankCard
{
    __weak typeof(self) weakSelf = self;
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = weakSelf.view;
    
    http.code = @"802031";
    http.parameters[@"status"] = @"0";
    http.parameters[@"type"] = @"0";
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
        self.bankCardModels = [MyBankCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (self.bankCardModels.count > 0) {
            for (int i = 0; i < self.bankCardModels.count; i ++) {
                MyBankCardModel *model = self.bankCardModels[i];
                if ([model.isDefault isEqualToString:@"1"]) {
                    weakSelf.bankModel = model;
                    weakSelf.tableView.bankModel = model;
                    [weakSelf.tableView reloadData];
                }
                
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

//购买范围
-(void)ScopeOfPurchase
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"600115";
    http.parameters[@"type"] = @"accept_rule";
    [http postWithSuccess:^(id responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        for (int i = 0; i < dataArray.count ; i ++) {
            if ([dataArray[i][@"ckey"] isEqualToString:@"accept_order_max_cny_amount"]) {
                self.tableView.biggestLimit = dataArray[i][@"cvalue"];
                accept_order_max_cny_amount = dataArray[i][@"cvalue"];
            }
            if ([dataArray[i][@"ckey"] isEqualToString:@"accept_order_min_cny_amount"]) {
                self.tableView.smallLimit = dataArray[i][@"cvalue"];
                accept_order_min_cny_amount = dataArray[i][@"cvalue"];
            }
            
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
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
                weakSelf.tableView.bankModel = weakSelf.bankModel;
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



// 买卖
-(void)promptIkonwBtnClick
{
    
    UITextField *textField1 = [self.view viewWithTag:10000];
    UITextField *textField2 = [self.view viewWithTag:10001];
    
    
    
    if ([textField1.text floatValue] < [accept_order_min_cny_amount floatValue]) {
        [TLAlert alertWithInfo:[NSString stringWithFormat:@"%@%@",[LangSwitcher switchLang:@"购买金额必须大于" key:nil],accept_order_min_cny_amount]];
        return ;
    }
    if ([textField1.text floatValue] > [accept_order_max_cny_amount floatValue]) {
        [TLAlert alertWithInfo:[NSString stringWithFormat:@"%@%@",[LangSwitcher switchLang:@"购买金额不得大于" key:nil],accept_order_max_cny_amount]];
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
        http.parameters[@"tradeCoin"] = @"USDT";
        [http postWithSuccess:^(id responseObject) {
            
            
            CoinWeakSelf;
            TLNetworking *http1 = [[TLNetworking alloc] init];
            http1.showView = weakSelf.view;
            http1.code = @"625286";
            http1.parameters[@"code"] = responseObject[@"data"][@"code"];
            [http1 postWithSuccess:^(id responseObject) {
                
                if ([_payWayDic[@"name"] isEqualToString:@"支付宝"]) {
                    PayTreasureVC *vc = [PayTreasureVC new];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.models = [OrderRecordModel mj_objectWithKeyValues:responseObject[@"data"]];
                    [self.navigationController pushViewController:vc animated:YES];
                }else
                {
                    BnakCardVC *vc = [BnakCardVC new];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.models = [OrderRecordModel mj_objectWithKeyValues:responseObject[@"data"]];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                
            } failure:^(NSError *error) {
                
            }];
            
            
            
            
            textField1.text = @"";
            textField2.text = @"";
            [[UserModel user].cusPopView dismiss];
        } failure:^(NSError *error) {
            
        }];
    }else
    {
        if ([TLUser isBlankString:self.bankModel.code] == YES) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请选择收款方式" key:nil]];
            return ;
        }
        [[UserModel user].cusPopView dismiss];
        self.passWordView.priceLabel.text = [NSString stringWithFormat:@"%@ USDT",textField2.text];
        [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:self.passWordView];
        
        
    }
    
    
}


//支付方式
-(void)payWay
{
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = self.view;
    http.code = @"802034";
    http.parameters[@"symbol"] = @"USDT";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.payWayArray = responseObject[@"data"];
        if (self.payWayArray.count > 0) {
            self.payWayDic = self.payWayArray[0];
            self.tableView.payWayDic = self.payWayDic;
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
//购买
-(void)bottomBtnClick
{
    
    if ([TLUser isBlankString:[TLUser user].idNo] == YES)
    {
        
        [TLAlert alertWithTitle:@"提示" msg:@"您还未完成实名认证，是否前去认证" confirmMsg:@"确认" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            ZQOCRScanEngine *engine = [[ZQOCRScanEngine alloc] init];
            engine.delegate = self;
            engine.appKey = @"nJXnQp568zYcnBdPQxC7TANqakUUCjRZqZK8TrwGt7";
            engine.secretKey = @"887DE27B914988C9CF7B2DEE15E3EDF8";
            [engine startOcrScanIdCardInViewController:self];
        }];
    }
    else
    {
        if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {
            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
            vc.titleString = @"设置交易密码";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            
            
            
            UITextField *textField1 = [self.view viewWithTag:10000];
            UITextField *textField2 = [self.view viewWithTag:10001];
            
            
            
            if ([textField1.text floatValue] < [accept_order_min_cny_amount floatValue]) {
                [TLAlert alertWithInfo:[NSString stringWithFormat:@"%@%@",[LangSwitcher switchLang:@"购买金额必须大于" key:nil],accept_order_min_cny_amount]];
                return ;
            }
            if ([textField1.text floatValue] > [accept_order_max_cny_amount floatValue]) {
                [TLAlert alertWithInfo:[NSString stringWithFormat:@"%@%@",[LangSwitcher switchLang:@"购买金额不得大于" key:nil],accept_order_max_cny_amount]];
                return ;
            }
            if ([textField2.text floatValue] == 0) {
                [TLAlert alertWithInfo:[LangSwitcher switchLang:@"购买数量必须大于0" key:nil]];
                return ;
            }
            if (indexBtnTag == 0) {
                
            }else
            {
                
                if ([TLUser isBlankString:self.bankModel.code] == YES) {
                    [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请选择银行卡" key:nil]];
                    return ;
                }
            }
            
            [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:self.promptView];
        }
    }
    
    //    [[UserModel user] showPopAnimationWithAnimationStyle:1 showView:self.promptView];
}

-(void)loadData:(NSString *)type
{
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    
    http.showView = weakSelf.view;
    http.code = @"650200";
    http.parameters[@"period"] = @"1";
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    
    NSTimeInterval starttime =  24 * 60 * 60 * 30;
    NSTimeInterval endtime =  24 * 60 * 60 * 1;
    NSDate * startYear = [currentDate dateByAddingTimeInterval:-starttime];
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:startYear];
    
    NSDate * endYear = [currentDate dateByAddingTimeInterval:endtime];
    //转化为字符串
    NSString * endDate = [dateFormatter stringFromDate:endYear];
    
    http.parameters[@"startDatetime"] = startDate;
    http.parameters[@"endDatetime"] = endDate;
    http.parameters[@"symbol"] = @"USDT";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"type"] = type;
    [http postWithSuccess:^(id responseObject) {
        
        self.models = [InvestmentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.models = self.models;
        
        NSMutableArray *arrayX = [NSMutableArray array];
        NSMutableArray *arrayY = [NSMutableArray array];
        if (_models.count == 1)
        {
            [arrayX addObjectsFromArray:@[@"1",@"2"]];
            [arrayY addObjectsFromArray:@[_models[0].price,_models[0].price]];
        }
        else
        {
            for (int i = 0; i < _models.count; i ++) {
                if (i <= 30) {
                    [arrayX addObject:@(i + 1)];
                    [arrayY addObject:_models[i].price];
                }
            }
        }
        
        CGFloat maxPrice = ([[arrayY valueForKeyPath:@"@max.floatValue"] floatValue]+3);
        CGFloat minPrice = ([[arrayY valueForKeyPath:@"@min.floatValue"] floatValue]-3);
        
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
    
    //    http.showView = weakSelf.view;
    http.code = @"650201";
    http.parameters[@"symbol"] = @"USDT";
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
    
    //    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 50, 40, 149)];
    //    rightView.backgroundColor = kWhiteColor;
    //    [self.view addSubview:rightView];
}


- (void)faceAuthFinishedWithResult:(NSInteger)result userInfo:(id)userInfo
{
    NSLog(@"Swift authFinish");
}

- (void)idCardOcrScanFinishedWithResult:(ZQFaceAuthResult)result userInfo:(id)userInfo
{
    NSLog(@"OC OCR Finish");
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = @"即将进入活体识别";
    //    [SVProgressHUD showInfoWithStatus:@"正在认证中"];
    
    UIImage *frontcard = [userInfo objectForKey:@"frontcard"];
    UIImage *portrait = [userInfo objectForKey:@"portrait"];
    UIImage *backcard = [userInfo objectForKey:@"backcard"];
    if(result  == ZQFaceAuthResult_Done && frontcard != nil && portrait != nil && backcard !=nil)
    {
        NSData *imgData = UIImageJPEGRepresentation(frontcard, 0.6);
        NSData *imgData1 = UIImageJPEGRepresentation(backcard, 0.6);
        //进行上传
        [TLProgressHUD show];
        TLUploadManager *manager = [TLUploadManager manager];
        
        manager.imgData = imgData;
        manager.image = frontcard;
        [manager getTokenShowView:self.view succes:^(NSString *key) {
            
            str1 = key;
            //            [weakSelf changeHeadIconWithKey:key imgData:imgData];
            [TLProgressHUD show];
            TLUploadManager *manager1 = [TLUploadManager manager];
            
            manager1.imgData = imgData1;
            manager1.image = backcard;
            [manager1 getTokenShowView:self.view succes:^(NSString *key) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
                str2 = key;
                ZQFaceAuthEngine * engine = [[ZQFaceAuthEngine alloc]init];
                engine.delegate = self;
                engine.appKey = @"nJXnQp568zYcnBdPQxC7TANqakUUCjRZqZK8TrwGt7";
                engine.secretKey = @"887DE27B914988C9CF7B2DEE15E3EDF8";
                [engine startFaceAuthInViewController:self];
                //            [weakSelf changeHeadIconWithKey:key imgData:imgData];
                
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            }];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        }];
    }
    else
    {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

#pragma mark - ZQFaceAuthDelegate
- (void)faceAuthFinishedWithResult:(ZQFaceAuthResult)result UserInfo:(id)userInfo{
    
    UIImage * livingPhoto = [userInfo objectForKey:@"livingPhoto"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = @"正在认证中";
    if(result  == ZQFaceAuthResult_Done && livingPhoto !=nil){
        [TLProgressHUD show];
        TLUploadManager *manager = [TLUploadManager manager];
        NSData *imgData = UIImageJPEGRepresentation(livingPhoto, 0.6);
        manager.imgData = imgData;
        manager.image = livingPhoto;
        [manager getTokenShowView:self.view succes:^(NSString *key) {
            str3 = key;
            
            TLNetworking *http = [TLNetworking new];
            //            http.showView = self.view;
            http.code = @"805197";
            http.parameters[@"userId"] = [TLUser user].userId;
            http.parameters[@"frontImage"] = str1;
            http.parameters[@"backImage"] = str2;
            http.parameters[@"faceImage"] = str3;
            //
            [http postWithSuccess:^(id responseObject) {
                [TLAlert alertWithMsg:[LangSwitcher switchLang:@"实名认证成功" key:nil]];
                [self requesUserInfoWithResponseObject];
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            }];
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        }];
    }else
    {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

- (void)requesUserInfoWithResponseObject {
    
    //1.获取用户信息
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary *userInfo = responseObject[@"data"];
        //保存用户信息
        [[TLUser user] saveUserInfo:userInfo];
        //初始化用户信息
        [[TLUser user] setUserInfoWithDict:userInfo];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
