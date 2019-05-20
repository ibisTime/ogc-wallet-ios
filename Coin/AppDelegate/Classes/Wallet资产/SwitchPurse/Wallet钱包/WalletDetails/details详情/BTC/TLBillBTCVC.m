//
//  TLBillBTCVC.m
//  Coin
//
//  Created by shaojianfei on 2018/8/11.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLBillBTCVC.h"
#import "BillDetailTableView.h"
#import "LocalBillDetailTableView.h"
#import "WalletLocalWebVC.h"
#import "TLBTCtableView.h"

@interface TLBillBTCVC ()<RefreshDelegate>
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) TLBTCtableView *tableView;


@end

@implementation TLBillBTCVC
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"交易详情" key:nil];

    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    [self initHeaderView];
    
}

#pragma mark - Init
- (void)initHeaderView {
    UIView *topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@45);
    }];
    
    self.headerView = [[UIView alloc] init];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.height.equalTo(@110);
    }];
    UIImageView *icImage = [[UIImageView alloc] init];
    icImage.contentMode = UIViewContentModeScaleToFill;
    [self.headerView addSubview:icImage];
    [icImage theme_setImageIdentifier:@"BTC背景" moduleName:ImgAddress];
    
    [icImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headerView.mas_top);
        make.left.equalTo(self.headerView.mas_left);
        make.right.equalTo(self.headerView.mas_right);
        make.bottom.equalTo(self.headerView.mas_bottom);
        
    }];
    
    //账单类型
    UILabel *textLbl = [UILabel labelWithBackgroundColor:kClearColor
                                               textColor:kTextColor
                                                    font:16.0];
    textLbl.textAlignment = NSTextAlignmentCenter;
    textLbl.numberOfLines = 0;
    [icImage addSubview:textLbl];
    //    textLbl.text = _bill.bizNote;
    
    NSString *onlyCountStr;
    if (![_bill.value valid]) {
       onlyCountStr = @"正在打包中,即将到账";

    }else{
        onlyCountStr = [CoinUtil convertToRealCoin:_bill.value coin:_currentModel.symbol];

        
    }
    NSString *moneyStr = @"";
    //
    if ([_bill.direction isEqualToString:@"1"]) {
        if (![_bill.value valid]) {
            onlyCountStr = @"正在打包中,即将到账";
            moneyStr = [NSString stringWithFormat:@"%@", onlyCountStr];

        }else{
            moneyStr = [NSString stringWithFormat:@"+%@ %@", onlyCountStr, _currentModel.symbol];
        }
    } else  {
        if (![_bill.value valid]) {
            onlyCountStr = @"正在打包中,即将到账";
            moneyStr = [NSString stringWithFormat:@"%@", onlyCountStr];

        }else{
            moneyStr = [NSString stringWithFormat:@"-%@ %@", onlyCountStr, _currentModel.symbol];

        }
        
    }
    
    
    //金额
    UILabel *amountLbl = [UILabel labelWithBackgroundColor:kClearColor
                                                 textColor:kAppCustomMainColor
                                                      font:20.0];
    amountLbl.text = moneyStr;
    [icImage addSubview:amountLbl];
    
    //分割线
    //    UIView *line = [[UIView alloc] init];
    //    line.backgroundColor = kLineColor;
    //    [self.headerView addSubview:line];
    
    
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(icImage.mas_top).offset(30);
        make.centerX.equalTo(icImage.mas_centerX);
        
    }];
    if ([_bill.direction isEqualToString:@"0"]) {
        textLbl.text = [LangSwitcher switchLang:@"转出" key:nil];
        
        self.titleText.text =  [LangSwitcher switchLang:@"转出" key:nil];
    } else
    {
        
        textLbl.text = [LangSwitcher switchLang:@"转入" key:nil];
        self.titleText.text =  [LangSwitcher switchLang:@"转入" key:nil];
        
    }
    self.navigationItem.titleView = self.titleText;
    //
    [amountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(textLbl.mas_bottom).offset(10);
        make.centerX.equalTo(icImage.mas_centerX);
        
    }];
    
    [self.headerView layoutIfNeeded];
     
}

- (void)initTableView {
    
    self.tableView = [[TLBTCtableView alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, SCREEN_HEIGHT - 110 - kNavigationBarHeight) style:UITableViewStylePlain];
    self.tableView.bill = self.bill;
    self.tableView.address = self.address;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kNavigationBarHeight, 0);
    self.tableView.refreshDelegate = self;
    self.tableView.currentModel = self.currentModel;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row != 6) {
        return;
    }
    WalletLocalWebVC *webVC = [WalletLocalWebVC new];
    webVC.urlString = self.bill.txHash;
    webVC.currentModel = self.currentModel;
    [self.navigationController pushViewController:webVC animated:YES];
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
