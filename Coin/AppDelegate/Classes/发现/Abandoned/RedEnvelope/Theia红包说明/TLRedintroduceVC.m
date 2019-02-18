//
//  TLRedintroduceVC.m
//  Coin
//
//  Created by shaojianfei on 2018/9/17.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLRedintroduceVC.h"
#import "RedIntroduceTB.h"
#import "RedModel.h"
#import "RedIntroduce.h"
#import "NewHtmlVC.h"
#import "H5DrtailVC.h"
@interface TLRedintroduceVC ()<RefreshDelegate>
@property (nonatomic, strong) NSMutableArray <RedModel *>*redModels;
@property (nonatomic, strong) RedIntroduceTB *tableView;

@property (nonatomic, strong) RedIntroduce *headView;

@end

@implementation TLRedintroduceVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;


}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = kTabbarColor;
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}


-(RedIntroduce *)headView
{
    if (!_headView) {
        _headView = [[RedIntroduce alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(190))];
        
    }
    return _headView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[RedIntroduceTB alloc]
                          initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight - 70)
                          style:UITableViewStyleGrouped];
        
        _tableView.backgroundColor = kWhiteColor;
        _tableView.sectionHeaderHeight = 22;
        
        _tableView.refreshDelegate = self;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  kWhiteColor;


    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(kScreenWidth/2-60, 0, 120, 50)];
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=kTextColor;
    [titleText setFont:[UIFont systemFontOfSize:17.0]];
    [titleText setText:[LangSwitcher switchLang:@"MooreBit红包说明" key:nil]];
    self.navigationItem.titleView=titleText;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    
    TLNetworking *net = [TLNetworking new];
    net.code = @"625413";
    net.parameters[@"code"] = @"dapp20180809001";
    [net postWithSuccess:^(id responseObject) {
        [self.headView.contentWeb loadHTMLString:responseObject[@"data"][@"dapp"][@"description"] baseURL:nil];
        self.redModels = [RedModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"helpList"]];
        self.tableView.redModels = self.redModels;
        [self.tableView reloadData];
        if (self.redModels.count > 0) {
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)backbuttonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RedModel *model = self.redModels[indexPath.row];
    H5DrtailVC *detail = [[H5DrtailVC alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
    
}


@end
