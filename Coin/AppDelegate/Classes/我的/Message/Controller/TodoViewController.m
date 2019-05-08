//
//  TodoViewController.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TodoViewController.h"
#import "MessageTableView.h"
#import "MessageDetailsVC.h"
#import "TodoModel.h"
@interface TodoViewController ()<RefreshDelegate>
@property (nonatomic , strong)MessageTableView *tableView;

@property (nonatomic , strong)NSMutableArray <TodoModel *>*models;
@end

@implementation TodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    if (self.bizTasks.count == 0) {
        [self loadData];
    }
    
}

-(void)initTableView
{
    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50- kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    if (self.bizTasks.count > 0) {
        self.title = @"代办事项";
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight );
        self.tableView.models = [TodoModel mj_objectArrayWithKeyValuesArray:self.bizTasks];
    }
    
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailsVC *vc = [MessageDetailsVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//code: 632911
//json: {"token":"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJVMjAxOTA0MTcxNDE0NDIwOTEyMjI4IiwiaXNzIjoiYWRtaW4iLCJhdWQiOiIiLCJpYXQiOjE1NTU0ODkwNTEsIm5iZiI6MTU1NTQ4OTA1MSwiZXhwIjoxNTU2MDkzODUxLCJqdGkiOiIifQ.5l_y4JDknsnju2BYyqVkgsQOUtqUXY7VWIESYEoZWNa3JMrp1p6LpyZZWfUySj3dJhmb0v9YA_QyGtThknD8XA","start":1,"limit":10,"roleCode":"RO201800000000000001","teamCode":null}

-(void)loadData{
    CoinWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632528";
    helper.parameters[@"operator"] = [TLUser user].userId;
//    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[TodoModel class]];
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <TodoModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TodoModel *model = (TodoModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <TodoModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                TodoModel *model = (TodoModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
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
