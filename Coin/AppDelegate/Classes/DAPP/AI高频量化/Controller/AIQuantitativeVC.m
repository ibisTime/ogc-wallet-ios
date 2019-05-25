//
//  AIQuantitativeVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeVC.h"
#import "AIQuantitativeTableView.h"
#import "AIQuantitativeDetailsVC.h"
#import "AIQuantitativeModel.h"
@interface AIQuantitativeVC ()<RefreshDelegate>

@property (nonatomic , strong)AIQuantitativeTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AIQuantitativeModel *>*models;

@end

@implementation AIQuantitativeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"搬砖生息";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    [self LoadData];
    
}

- (void)initTableView {
    self.tableView = [[AIQuantitativeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight ) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}


-(void)LoadData
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    helper.code = @"610305";
    [helper modelClass:[AIQuantitativeModel class]];
    
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

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AIQuantitativeDetailsVC *vc = [AIQuantitativeDetailsVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
