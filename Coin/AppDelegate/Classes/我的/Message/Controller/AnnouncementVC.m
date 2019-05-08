//
//  AnnouncementVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AnnouncementVC.h"
#import "MessageTableView.h"
#import "MessageDetailsVC.h"
#import "TodoModel.h"
@interface AnnouncementVC ()<RefreshDelegate>
@property (nonatomic , strong)MessageTableView *tableView;
@property (nonatomic , strong)NSMutableArray <TodoModel *>*models;
@end

@implementation AnnouncementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50 - kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    [self loadData];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailsVC *vc = [MessageDetailsVC new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = self.models[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)loadData{
    CoinWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"805305";

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
