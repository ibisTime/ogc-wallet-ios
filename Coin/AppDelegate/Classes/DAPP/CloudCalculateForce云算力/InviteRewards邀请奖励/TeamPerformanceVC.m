//
//  TeamPerformanceVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TeamPerformanceVC.h"
#import "TeamPerFormanceTableView.h"
#import "TeamPerformanceModel.h"
@interface TeamPerformanceVC ()<RefreshDelegate>
@property (nonatomic , strong)TeamPerFormanceTableView *tableView;


@property (nonatomic , strong)NSMutableArray <TeamPerformanceModel *>*models;
@end

@implementation TeamPerformanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [self LoadData];
}

- (void)initTableView {
    self.tableView = [[TeamPerFormanceTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - self.y) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    
}

-(void)LoadData
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    helper.code = @"610147";
    helper.parameters[@"userid"] = [TLUser user].userId;
    [helper modelClass:[TeamPerformanceModel class]];
    
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



@end
