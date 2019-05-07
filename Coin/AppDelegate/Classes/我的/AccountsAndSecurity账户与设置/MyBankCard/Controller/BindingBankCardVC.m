//
//  BindingBankCardVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BindingBankCardVC.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
@interface BindingBankCardVC ()
{
    NSArray *dataArray;
    NSDictionary *bankCardDic;
}

@end

@implementation BindingBankCardVC

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"绑定我的收款账号" key:nil];
    [self initView];
    [self loadData];
    
}

-(void)loadData
{
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = weakSelf.view;
    http.code = @"802116";
    
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
        
        dataArray = responseObject[@"data"];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)initView
{
    NSArray *nameArray = @[@"姓名",@"收款方式",@"收款账号",@"收款账号"];
    NSArray *placArray = @[@"请输入姓名",@"请选择收款方式",@"请输入收款账号",@"请输入收款账号"];
    
    for (int i = 0; i < nameArray.count; i ++) {
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, i% 4 * 55, 70, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        nameLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
//        [nameLabel sizeToFit];
        nameLabel.tag = 100 + i;
//        nameLabel.frame = CGRectMake(15, i% 4 * 55, nameLabel.width, 55);
        [self.view addSubview:nameLabel];
        
        
        UITextField *nameTextFid = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.xx + 20, i% 4 * 55, SCREEN_WIDTH - nameLabel.xx - 20 - 30, 55)];
//        nameTextFid.placeholder = [LangSwitcher switchLang:@"请输入密码（6~16个字符或字母组成）" key:nil];
        [nameTextFid setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
        nameTextFid.font = FONT(15);
        nameTextFid.tag = 1000 + i;
        nameTextFid.placeholder = [LangSwitcher switchLang:placArray[i] key:nil];
        [self.view addSubview:nameTextFid];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, i% 4 * 55 + 54, SCREEN_WIDTH - 30, 1)];
        lineView.tag = 10000 + i;
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
        
        if (i == 1) {
            
            UIButton *BankCardBackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//            [chooseBankCardBtn setImage:kImage(@"发布文章-下拉") forState:(UIControlStateNormal)];
            BankCardBackBtn.frame = nameTextFid.frame;
            [BankCardBackBtn addTarget:self action:@selector(BankCardBackBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
            [self.view addSubview:BankCardBackBtn];
            
            nameTextFid.enabled = NO;
            UIButton *chooseBankCardBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [chooseBankCardBtn setImage:kImage(@"发布文章-下拉") forState:(UIControlStateNormal)];
            chooseBankCardBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - 9, 55, 39, 55);
            [self.view addSubview:chooseBankCardBtn];
        }
        
        if (i == 3) {
            nameLabel.hidden = YES;
            nameTextFid.hidden = YES;
            lineView.hidden = YES;
        }
        
        
    }
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认" key:nil] titleColor:kWhiteColor backgroundColor:kHexColor(@"#4064E6") titleFont:15];
    confirmBtn.frame = CGRectMake(15, 280, SCREEN_WIDTH - 30, 50);
    kViewRadius(confirmBtn, 4);
    [self.view addSubview:confirmBtn];
    
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
}

-(void)BankCardBackBtnClick
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < dataArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",dataArray[i][@"bankName"]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];

            bankCardDic = dataArray[model.sid];
            UITextField *textField1 = [self.view viewWithTag:1001];
            textField1.text = bankCardDic[@"bankName"];
            UILabel *label2 = [self.view viewWithTag:102];
            UILabel *label3 = [self.view viewWithTag:103];
            UITextField *textField2 = [self.view viewWithTag:1002];
            UITextField *textField3 = [self.view viewWithTag:1003];
            UIView *lineView = [self.view viewWithTag:10003];
            if ([bankCardDic[@"bankName"] isEqualToString:@"支付宝"]) {
                
                label2.text = @"收款账号";
                textField2.placeholder = @"请输入收款账号";
                label3.hidden = YES;
                textField3.hidden = YES;
                lineView.hidden = YES;
            }else
            {
                label2.text = @"开户支行";
                textField2.placeholder = @"请输入开户支行";
                label3.hidden = NO;
                textField3.hidden = NO;
                lineView.hidden = NO;
                label3.text = @"收款账号";
                textField3.placeholder = @"请输入收款账号";
            }
        }];
    };
    [LEEAlert alert].config
    .LeeTitle([LangSwitcher switchLang:@"选择" key:nil])
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}



-(void)confirmBtnClick
{
    UITextField *textField1 = [self.view viewWithTag:1000];
    UITextField *textField2 = [self.view viewWithTag:1001];
    UITextField *textField3 = [self.view viewWithTag:1002];
    UITextField *textField4 = [self.view viewWithTag:1003];
    
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入姓名" key:nil]];
        return ;
    }
    
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请选择收款方式" key:nil]];
        return ;
    }
    if ([bankCardDic[@"bankName"] isEqualToString:@"支付宝"]) {
        if ([textField3.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入收款账号" key:nil]];
            return ;
        }
    }else
    {
        if ([textField3.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入开户支行" key:nil]];
            return ;
        }
        if ([textField4.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入银行卡号" key:nil]];
            return ;
        }
    }
    
    
    
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = weakSelf.view;
    
    http.code = @"802024";

    http.parameters[@"realName"] = textField1.text;
    http.parameters[@"bankCode"] = bankCardDic[@"bankCode"];
    http.parameters[@"bankName"] = bankCardDic[@"bankName"];
    
    if ([bankCardDic[@"bankName"] isEqualToString:@"支付宝"]) {
        http.parameters[@"subbranch"] = @"支付宝";
        http.parameters[@"bankcardNumber"] = textField3.text;
    }else
    {
        http.parameters[@"subbranch"] = textField3.text;
        http.parameters[@"bankcardNumber"] = textField4.text;
    }
    
    http.parameters[@"type"] =@"0";
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"添加成功" key:nil]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BankCardLoadData" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
        
    } failure:^(NSError *error) {
        
    }];
}


@end
