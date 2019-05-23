//
//  MyMillDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillDetailsVC.h"
#import "MyMillDetailsTableView.h"
#import "MyMillDetailsModel.h"

@interface MyMillDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)MyMillDetailsTableView *tableView;


@property (nonatomic , strong)NSMutableArray <MyMillDetailsModel *>*models;
@end

@implementation MyMillDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"水滴型号运行详情";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    [self loadData];
}

- (void)initTableView {
    self.tableView = [[MyMillDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight ) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
}


-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"610146";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"machineOrderCode"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        
        self.tableView.models = [MyMillDetailsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    

    
    
    
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
