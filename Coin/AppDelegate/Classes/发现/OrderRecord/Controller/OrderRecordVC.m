//
//  OrderRecordVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "OrderRecordVC.h"
#import "OrderRecordTableView.h"
#import "PayTreasureVC.h"
#import "BnakCardVC.h"
#import "PayFailureVC.h"
#import "OrderRecordModel.h"
@interface OrderRecordVC ()<RefreshDelegate>

@property (nonatomic , strong)OrderRecordTableView *tableView;

@property (nonatomic , strong)NSMutableArray <OrderRecordModel *>*models;

@end

@implementation OrderRecordVC

- (OrderRecordTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[OrderRecordTableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight) style:UITableViewStylePlain];
        
        _tableView.refreshDelegate = self;
        _tableView.backgroundColor = kBackgroundColor;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = [LangSwitcher switchLang:@"订单记录" key:nil];
    self.titleText.font = FONT(18);
    self.navigationItem.titleView = self.titleText;
    [self LoadData];
    [self.view addSubview:self.tableView];
}

-(void)LoadData
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    helper.code = @"625287";
    helper.parameters[@"userId"] = [TLUser user].userId;
    [helper modelClass:[OrderRecordModel class]];
    
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
    if (indexPath.row  == 0) {
        PayTreasureVC *vc = [PayTreasureVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        BnakCardVC *vc = [BnakCardVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        PayFailureVC *vc = [PayFailureVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
