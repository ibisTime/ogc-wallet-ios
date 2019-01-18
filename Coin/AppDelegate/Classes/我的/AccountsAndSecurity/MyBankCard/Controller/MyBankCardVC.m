//
//  MyBankCardVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyBankCardVC.h"
#import "MyBankCardTableView.h"
#import "BindingBankCardVC.h"
#import "MyBankCardModel.h"
@interface MyBankCardVC ()<RefreshDelegate>

@property (nonatomic , strong)MyBankCardTableView *tableView;

@property (nonatomic , strong)NSMutableArray <MyBankCardModel *>*models;

@end

@implementation MyBankCardVC

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (MyBankCardTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[MyBankCardTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight) style:UITableViewStylePlain];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"我的银行卡" key:nil];
    self.navigationItem.titleView = self.titleText;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:[LangSwitcher switchLang:@"绑定" key:nil] forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.tableView];
    [self LoadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"BankCardLoadData" object:nil];
}


- (void)InfoNotificationAction:(NSNotification *)notification
{
    [self LoadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BankCardLoadData" object:nil];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.choose isEqualToString:@"选择"]) {
        CoinWeakSelf;
        if (weakSelf.returnValueBlock) {
            //将值传递出去
            weakSelf.returnValueBlock(self.models[indexPath.row]);
        }
        [self.navigationController popViewControllerAnimated:YES]; //返回A控制器
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index setTitle:(NSString *)title
{
    if ([title isEqualToString:@"删除"]) {
        CoinWeakSelf;
        TLNetworking *http = [[TLNetworking alloc] init];
        http.showView = weakSelf.view;
        
        http.code = @"802025";
        http.parameters[@"code"] =self.models[index].code;
        http.parameters[@"userId"] = [TLUser user].userId;
        [http postWithSuccess:^(id responseObject) {
            
            [self LoadData];
            
            
        } failure:^(NSError *error) {
            
        }];
    }else
    {
        CoinWeakSelf;
        TLNetworking *http = [[TLNetworking alloc] init];
        http.showView = weakSelf.view;
        http.code = @"802026";
        http.parameters[@"code"] =self.models[index].code;
        http.parameters[@"userId"] = [TLUser user].userId;
        [http postWithSuccess:^(id responseObject) {
            [self LoadData];
        } failure:^(NSError *error) {
            
        }];
    }
}



-(void)myRecodeClick
{
    BindingBankCardVC *vc = [BindingBankCardVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    helper.code = @"802030";
    helper.parameters[@"status"] = @"0";
    helper.parameters[@"type"] = @"0";
    helper.parameters[@"userId"] = [TLUser user].userId;
    [helper modelClass:[MyBankCardModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.models = objs;
            
            weakSelf.tableView.models = objs;
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
            
            weakSelf.models = objs;
            
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
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
