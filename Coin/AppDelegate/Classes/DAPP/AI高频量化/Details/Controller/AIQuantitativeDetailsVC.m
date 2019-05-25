//
//  AIQuantitativeDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeDetailsVC.h"
#import "AIQuantitativeDetailsTableView.h"
#import "BuyProfileView.h"
#import "ImportPurchaseAmountVC.h"
#import "WaterDropModelPasswordView.h"
#import "CurrencyModel.h"
#import "RechargeCoinVC.h"
#import "AIQuantitativeRecordVC.h"
@interface AIQuantitativeDetailsVC ()<RefreshDelegate,HBAlertPasswordViewDelegate>

@property (nonatomic , strong)AIQuantitativeDetailsTableView *tableView;


@property (nonatomic , strong)ImportPurchaseAmountVC *payOneView;

@property (nonatomic , strong)BuyProfileView *payTwoView;

@property (nonatomic , strong)WaterDropModelPasswordView *paytThreeView;

@property (nonatomic , strong)NSMutableArray <CurrencyModel *>*currencys;
@property (nonatomic , strong)CurrencyModel *currencyModel;
@property (nonatomic , strong)UILabel *timeLab;
@property (nonatomic , strong)UIView *view3;
@property (nonatomic , assign)NSInteger time;

@property (nonatomic , strong)NSTimer *timeOut;

@end

@implementation AIQuantitativeDetailsVC


-(void)viewWillAppear:(BOOL)animated
{
    [self getMySyspleList];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_paytThreeView clearUpPassword];
    [[UserModel user].cusPopView dismiss];
}

-(ImportPurchaseAmountVC *)payOneView
{
    if (!_payOneView) {
        _payOneView = [[ImportPurchaseAmountVC alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 340)];
        
        [_payOneView.confirm addTarget:self action:@selector(confirmClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _payOneView.confirm.tag = 1000;
        _payOneView.model = self.model;
        [_payOneView.intoBtn addTarget:self action:@selector(intoBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    }
    return _payOneView;
    
}

-(void)intoBtnClick
{
    RechargeCoinVC *coinVC = [RechargeCoinVC new];
    coinVC.currency = self.currencyModel;
    [self.navigationController pushViewController:coinVC animated:YES];
}

- (void)keyboardAction:(NSNotification*)sender{
    // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // <注意>具有约束的控件通过改变约束值进行frame的改变处理
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        _payOneView.frame = CGRectMake(30, 100, SCREEN_WIDTH - 60, 340 + 200);
//        self.toBottom.constant = [value CGRectValue].size.height;
    }else{
        _payOneView.frame = CGRectMake(30, SCREEN_HEIGHT/2 - 170, SCREEN_WIDTH - 60, 340 );
//        self.toBottom.constant = 0;
    }
}


-(BuyProfileView *)payTwoView
{
    if (!_payTwoView) {
        _payTwoView = [[BuyProfileView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 340)];
        
        [_payTwoView.confirm addTarget:self action:@selector(confirmClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _payTwoView.confirm.tag = 1001;
    }
    return _payTwoView;
    
}

-(WaterDropModelPasswordView *)paytThreeView
{
    if (!_paytThreeView) {
        _paytThreeView = [[WaterDropModelPasswordView alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT/2 - 240 - 100, SCREEN_WIDTH - 30, 240 + 200)];
        [_paytThreeView.forgotPassword addTarget:self action:@selector(forgotPasswordClick) forControlEvents:(UIControlEventTouchUpInside)];
        _paytThreeView.delegate = self;
    }
    return _paytThreeView;
}

-(void)forgotPasswordClick
{
    [[UserModel user].cusPopView dismiss];
    TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
    vc.titleString = @"修改交易密码";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <HBAlertPasswordViewDelegate>
- (void)sureActionWithAlertPasswordView:(WaterDropModelPasswordView *)alertPasswordView password:(NSString *)password {
    
    
    [[UserModel user].cusPopView dismiss];
    [self.paytThreeView clearUpPassword];
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"610310";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"productCode"] = self.model.code;
    http.parameters[@"investCount"] = self.payOneView.buyCreditsTf.text;
    http.parameters[@"tradePwd"] = password;
    [http postWithSuccess:^(id responseObject) {
        
//        [TLAlert alertWithSucces:@"购买成功"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //            [self.navigationController popViewControllerAnimated:YES];
//
//            AIQuantitativeRecordVC *vc = [AIQuantitativeRecordVC new];
//            [self.navigationController pushViewController:vc animated:YES];
//
//        });
        [self showBuySucess];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


- (void)showBuySucess
{
    UIView * view3 = [UIView new];
    self.view3 = view3;
    self.view3.hidden = NO;
    view3.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    view3.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.45];
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:view3];
    UIView *whiteView = [UIView new];
    [view3 addSubview:whiteView];
    
    whiteView.frame = CGRectMake(24, 194, kScreenWidth - 48, 300);
    whiteView.layer.cornerRadius=5;
    whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
    whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
    whiteView.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围
    [whiteView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setBackgroundImage:kImage(@"红包 删除") forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_top).offset(10);
        make.right.equalTo(whiteView.mas_right).offset(-15);
        make.width.height.equalTo(@22.5);
    }];
    
    UIImageView *bgImage = [[UIImageView alloc] init];
    [bgImage theme_setImageIdentifier:@"钱包新建成功" moduleName:ImgAddress];
    [whiteView addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(whiteView.mas_top).offset(35);
        make.centerX.equalTo(whiteView.mas_centerX);
        make.width.height.equalTo(@(kHeight(60)));
    }];
    
    UILabel *sureLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:20];
    [whiteView addSubview:sureLab];
    sureLab.text = [LangSwitcher switchLang:@"购买成功" key:nil];
    [sureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImage.mas_bottom).offset(18);
        
        make.centerX.equalTo(whiteView.mas_centerX);
        
    }];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    [whiteView addSubview:sureButton];
    sureButton.titleLabel.font = FONT(13);
    [sureButton setTitle:[LangSwitcher switchLang:@"查看购买记录" key:nil] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(payMoneyNowRecode) forControlEvents:UIControlEventTouchUpInside];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sureLab.mas_bottom).offset(18);
        make.centerX.equalTo(whiteView.mas_centerX);
        
        make.width.equalTo(@150);
        make.height.equalTo(@32);
        
    }];
    
    sureButton.layer.borderWidth = 0.5;
    sureButton.layer.borderColor = kPlaceholderColor.CGColor;
    sureButton.layer.cornerRadius = 4;
    sureButton.clipsToBounds = YES;
    self.time = 5;
    
    UILabel *timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kPlaceholderColor font:12];
    self.timeLab = timeLab;
    [whiteView addSubview:timeLab];
    NSString * t  = [NSString stringWithFormat:@"%ld",self.time];
    timeLab.text = [NSString stringWithFormat:@"%@%@",t,[LangSwitcher switchLang:@"秒钟自动跳转" key:nil]];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sureButton.mas_bottom).offset(18);
        
        make.centerX.equalTo(whiteView.mas_centerX);
        
    }];
    self.timeOut = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timeOut forMode:NSRunLoopCommonModes];
}

-(void)hideSelf
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view3.hidden = YES;
    }];
    
}

- (void)timeAction{
    
    self.time --;
    NSString * t  = [NSString stringWithFormat:@"%ld",self.time];
    _timeLab.text = [NSString stringWithFormat:@"%@%@",t,[LangSwitcher switchLang:@"秒钟自动跳转" key:nil]];
    
    if (self.time == 0) {
        
        [self.timeOut invalidate];
        self.timeOut = nil;
        self.view3.hidden = YES;
        AIQuantitativeRecordVC *vc = [AIQuantitativeRecordVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)payMoneyNowRecode
{
    [self.timeOut invalidate];
    self.timeOut = nil;
    self.view3.hidden = YES;
    AIQuantitativeRecordVC *vc = [AIQuantitativeRecordVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}




-(void)confirmClick:(UIButton *)sender
{
    [[UserModel user].cusPopView dismiss];
    if (sender.tag == 1000) {
        if ([self.payOneView.buyCreditsTf.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入购买额度"];
            return;
        }
        
        if ([self.payOneView.buyCreditsTf.text floatValue] > [self.model.buyMax floatValue] || [self.payOneView.buyCreditsTf.text floatValue] < [self.model.buyMin floatValue]) {
            [TLAlert alertWithInfo:[NSString stringWithFormat:@"购买范围为%@-%@",self.model.buyMin,self.model.buyMax]];
            return;
        }
        
        
        [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:self.payTwoView];
        
        self.payTwoView.model = self.model;
        self.payTwoView.price = self.payOneView.price;
        self.payTwoView.earnings = self.payOneView.buyCreditsTf.text;
        
    }else if (sender.tag == 1001)
    {
        [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:self.paytThreeView];
        
    }
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"项目详情";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    
    
}

- (void)getMySyspleList {
    
    CoinWeakSelf;
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"802301";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    
    [http postWithSuccess:^(id responseObject) {
        
        weakSelf.currencys = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"accountList"]];
        
        for (int i = 0; i < self.currencys.count; i++) {
            //
            if ([self.model.symbolBuy isEqualToString:self.currencys[i].currency]) {
                self.currencyModel = self.currencys[i];
                _payOneView.currencyModel = self.currencyModel;
            }
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
//        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)initTableView {
    self.tableView = [[AIQuantitativeDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - 90) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 90, SCREEN_WIDTH, 1)];
    [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [self.view addSubview:lineView];
    
    UIButton *shoppingBtn = [UIButton buttonWithTitle:@"购买" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16 cornerRadius:2];
    shoppingBtn.frame = CGRectMake(15, lineView.yy + 20, SCREEN_WIDTH - 30, 50);
    [shoppingBtn addTarget:self action:@selector(shoppingBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shoppingBtn];
    
    
    
}

-(void)shoppingBtnClick
{
    if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {
        TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
        vc.titleString = @"设置交易密码";
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    [[UserModel user] showPopAnimationWithAnimationStyle:3 showView:self.payOneView];
    if (self.currencys.count > 0) {
        _payOneView.currencyModel = self.currencyModel;
    }
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
