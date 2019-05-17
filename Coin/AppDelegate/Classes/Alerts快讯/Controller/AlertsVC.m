//
//  AlertsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/5.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AlertsVC.h"
#import "AlertsTableView.h"
#import "AlertsDetailsVC.h"
#import "AlertsModel.h"
@interface AlertsVC ()<RefreshDelegate>


@property (nonatomic , strong)AlertsTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AlertsModel *>*models;


@end

@implementation AlertsVC

-(AlertsTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[AlertsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStyleGrouped];
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.showsHorizontalScrollIndicator = YES;
        self.tableView.refreshDelegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, -44, 100, 44)];
    nameLable.text = [LangSwitcher switchLang:@"快讯" key:nil];
    nameLable.textAlignment = NSTextAlignmentLeft;
    
    nameLable.font = Font(24);
    [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
    [self.view addSubview:nameLable];
    [self LoadData];
}

-(void)LoadData
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    helper.code = @"628095";
//    helper.parameters[@"type"] = @"1";
    helper.parameters[@"status"] = @"1";
    [helper modelClass:[AlertsModel class]];
    
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
    AlertsDetailsVC *vc = [AlertsDetailsVC new];
    vc.model = self.models[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
