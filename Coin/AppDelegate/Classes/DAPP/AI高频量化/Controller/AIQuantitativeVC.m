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
#import "AIQuantitativeRecordVC.h"
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

    [self.RightButton setTitle:@"我的投资" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(RightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    
}



-(void)RightButtonClick
{
    AIQuantitativeRecordVC *vc = [AIQuantitativeRecordVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
    helper.code = @"610306";
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
    vc.model = self.models[indexPath.row];
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
