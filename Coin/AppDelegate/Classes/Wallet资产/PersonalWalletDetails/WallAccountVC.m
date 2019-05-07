//
//  WallAccountVC.m
//  Coin
//
//  Created by shaojianfei on 2018/6/6.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WallAccountVC.h"
#import "RechargeCoinVC.h"
#import "ZMAuthVC.h"
#import "WallAccountHeadView.h"
#import "WithdrawalsCoinVC.h"
#import "Masonry.h"
#import "TLUser.h"
#import "BillTableView.h"
#import "BillModel.h"
#import "NSString+Check.h"
#import "FilterView.h"
#import "UIBarButtonItem+convience.h"
#import "BillVC.h"
#import "BillDetailVC.h"
@interface WallAccountVC ()<RefreshDelegate>
@property (nonatomic, strong) BillTableView *tableView;

@property (nonatomic,strong) NSMutableArray <BillModel *>*bills;

@property (nonatomic, strong) TLPageDataHelper *helper;
//筛选
@property (nonatomic, strong) FilterView *filterPicker;
//暂无推荐历史
@property (nonatomic, strong) UIView *placeHolderView;
@property (nonatomic , strong) WallAccountHeadView *headView;

@property (nonatomic , strong) UIView *bottomViw;
//充币
@property (nonatomic, strong) UIButton *rechargeBtn;
//提币
@property (nonatomic, strong) UIButton *withdrawalsBtn;
//账单
@property (nonatomic, strong) UIButton *billBtn;
@property (nonatomic , strong) UIScrollView *contentScrollView;

@property (nonatomic , strong)NSArray *dataArray;

@end

@implementation WallAccountVC




- (void)viewDidLoad {
    
  

    [super viewDidLoad];
  

    [self initHeadView];
    [self initTableView];
    [self initBottonView];
    
    [self ckey];
    //获取账单
    [self requestBillList];

}



#pragma mark - Init
- (FilterView *)filterPicker {
    
    if (!_filterPicker) {
        
        CoinWeakSelf;
        
//        NSArray *textArr = @[[LangSwitcher switchLang:@"全部" key:nil],
//                             [LangSwitcher switchLang:@"充币" key:nil],
//                             [LangSwitcher switchLang:@"提币" key:nil],
//                             [LangSwitcher switchLang:@"取现手续费" key:nil],
//                             [LangSwitcher switchLang:@"红包退回" key:nil],
//                             [LangSwitcher switchLang:@"抢红包" key:nil],
//                             [LangSwitcher switchLang:@"发红包" key:nil],
//                             [LangSwitcher switchLang:@"量化理财投资" key:nil],
//                             [LangSwitcher switchLang:@"量化理财还款" key:nil],
//                             [LangSwitcher switchLang:@"积分抽奖" key:nil]
//                             ];
//
//        NSArray *typeArr = @[@"",
//                             @"charge",
//                             @"withdraw",
//                             @"withdrawfee",
//                             @"redpacket_back",
//                             @"sendredpacket_in",
//                             @"sendredpacket_out",
//                             @"lhlc_invest",
//                             @"lhlc_repay",
//                             @"jf_lottery_in"
//
//                             ];
        NSMutableArray *textArr = [NSMutableArray array];
        NSMutableArray *typeArr = [NSMutableArray array];
        
        for (int i = 0; i < self.dataArray.count; i ++) {
            [textArr addObject:[LangSwitcher switchLang:self.dataArray[i][@"dvalue"] key:nil]];
            [typeArr addObject:self.dataArray[i][@"dkey"]];
        }
        
        
        _filterPicker = [[FilterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _filterPicker.selectBlock = ^(NSInteger index) {
            
            weakSelf.helper.parameters[@"bizType"] = typeArr[index];
            
            [weakSelf.tableView beginRefreshing];
        };
        
        _filterPicker.tagNames = textArr;
        
    }
    
    return _filterPicker;
}


- (void)initTableView {
    
    self.tableView = [[BillTableView alloc]
                      initWithFrame:CGRectMake(0, self.headView.yy , kScreenWidth, SCREEN_HEIGHT - self.headView.yy - kNavigationBarHeight - 80)
                      style:UITableViewStyleGrouped];
   
    
    self.tableView.refreshDelegate = self;

    self.tableView.defaultNoDataImage = kImage(@"暂无订单");
    self.tableView.defaultNoDataText = [LangSwitcher switchLang:@"暂无明细" key:nil];
    
    [self.view addSubview:self.tableView];
    CoinWeakSelf;
    self.tableView.addBlock = ^{
        [weakSelf clickFilter];
    };
    
}

-(void)ckey
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    
    http.parameters[@"parentKey"] = @"app_jour_biz_type_user";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.dataArray = responseObject[@"data"];
        
        //        [self shoreButtonClick];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Events
- (void)clickFilter{
    [self.filterPicker show];
}

#pragma mark - Data
- (void)requestBillList {
    
    //--//
    __weak typeof(self) weakSelf = self;
    
//    NSString *bizType = @"";
//
//    if (self.billType == CurrentTypeRecharge) {
//
//        bizType = @"charge";
//
//    } else if (self.billType == CurrentTypeWithdraw) {
//
//        bizType = @"withdraw";
//
//    } else if (self.billType == CurrentTypeFrozen) {
//
//        bizType = @"";
//    }
//
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.tableView = self.tableView;
    self.helper = helper;
    
    helper.code = @"802320";
    helper.start = 1;
    helper.limit = 10;
    helper.parameters[@"type"] = @"0";
    helper.parameters[@"accountNumber"] = self.currency.accountNumber;

    
    [helper modelClass:[BillModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.bills = objs;
            
            weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
    }];
    
    [self.tableView beginRefreshing];
    
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.bills = objs;
            
            weakSelf.tableView.bills = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
}

- (void)initHeadView{

    WallAccountHeadView *headView = [[WallAccountHeadView alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight, kScreenWidth, 84 - 64 + kNavigationBarHeight - 10 + 110)];
    self.headView = headView;
    headView.currency = self.currency;
    [self.view addSubview:headView];


}

- (void)initBottonView{
    UIView *bottomView  = [[UIView alloc] init];
    self.bottomViw = bottomView;
//    bottomView.backgroundColor = [UIColor redColor];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 80 - kNavigationBarHeight, SCREEN_WIDTH, 80);
    [self.view addSubview:bottomView];

    [bottomView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    //底部操作按钮

    NSArray *textArr = @[
                         [LangSwitcher switchLang:@"转入" key:nil],
                         [LangSwitcher switchLang:@"转出" key:nil]
                         ];
    NSArray *imgArr = @[@"转入", @"转出"];


    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithTitle:textArr[i] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12.0];
        [btn addTarget:self action:@selector(btnClickCurreny:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 45)/2 + 15) , 15, SCREEN_WIDTH/2 - 45/2, 50);
        [btn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:3 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(imgArr[i]) forState:UIControlStateNormal];
        }];
        if (i == 0) {
            [btn setBackgroundColor:kHexColor(@"#77A4FF") forState:(UIControlStateNormal)];
            
        }else
        {
            [btn setBackgroundColor:kHexColor(@"#F4AC71") forState:(UIControlStateNormal)];
        }

        btn.tag = 201806+i;
        [bottomView addSubview:btn];
    }



}

- (void)btnClickCurreny: (UIButton *)btn{
    NSInteger tag = btn.tag-201806;
    RechargeCoinVC *coinVC = [RechargeCoinVC new];

    switch (tag) {
        case 0:
            coinVC.currency = self.currency;
            [self.navigationController pushViewController:coinVC animated:YES];
            break;
        case 1:
            [self clickWithdrawWithCurrency:self.currency];

            break;

        default:
            break;
    }

}

- (void)clickWithdrawWithCurrency:(CurrencyModel *)currencyModel {

    CoinWeakSelf;
//    实名认证成功后，判断是否设置资金密码
    if ([[TLUser user].tradepwdFlag isEqualToString:@"0"]) {

        
        TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
        vc.titleString = @"设置交易密码";
        [self.navigationController pushViewController:vc animated:YES];
        return ;

    }

    WithdrawalsCoinVC *coinVC = [WithdrawalsCoinVC new];
    coinVC.currency = currencyModel;
    [self.navigationController pushViewController:coinVC animated:YES];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BillDetailVC *billVC = [BillDetailVC new];
    billVC.bill =  self.bills[indexPath.row];
    [self.navigationController pushViewController:billVC animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
