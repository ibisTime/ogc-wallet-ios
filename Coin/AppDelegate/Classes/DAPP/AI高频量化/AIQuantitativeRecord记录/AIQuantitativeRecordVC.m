//
//  AIQuantitativeRecordVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeRecordVC.h"

#import "AIQuantitativeRecordTableView.h"
#import "AIQuantitativeRecordModel.h"
#import "PosMyInvestmentHeadView.h"
#import "AccumulatedEarningsVC.h"
#import "FinancialDetailsVC.h"
#import "AIQuantitativeRecordDetailsVC.h"
@interface AIQuantitativeRecordVC ()<RefreshDelegate,PosMyInvestmentDelegate>


@property (nonatomic , strong)AIQuantitativeRecordTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AIQuantitativeRecordModel *>*model;

@end

@implementation AIQuantitativeRecordVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleText.text = [LangSwitcher switchLang:@"我的投资详情" key:nil];
    
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    [self LoadData];
    
}

- (void)initTableView {
    self.tableView = [[AIQuantitativeRecordTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    
    [self.view addSubview:self.tableView];
    
}




-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AIQuantitativeRecordDetailsVC *vc = [AIQuantitativeRecordDetailsVC new];
//    vc.model = self.model[indexPath.row];
    vc.model = self.model[indexPath.row];
    vc.dataArray = self.tableView.dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)statusLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"pglh_order_status";
    [http postWithSuccess:^(id responseObject) {
        
        self.tableView.dataArray = responseObject[@"data"];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
    }];
}

-(void)LoadData
{
    CoinWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"610316";
    helper.parameters[@"userId"] = [TLUser user].userId;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[AIQuantitativeRecordModel class]];
    
    [self.tableView addRefreshAction:^{
        [weakSelf statusLoadData];
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//            NSMutableArray <AIQuantitativeRecordModel *> *shouldDisplayCoins = [[AIQuantitativeRecordModel alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                AIQuantitativeRecordModel *model = (AIQuantitativeRecordModel *)obj;
//                [shouldDisplayCoins addObject:model];
//            }];
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.model = objs;
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
//            NSMutableArray <AIQuantitativeRecordModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                AIQuantitativeRecordModel *model = (AIQuantitativeRecordModel *)obj;
//                [shouldDisplayCoins addObject:model];
//            }];
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            weakSelf.model = objs;
            
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}


@end
