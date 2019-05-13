//
//  FindTheGameVC.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/4.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "FindTheGameVC.h"
#import "FindTheGameTableView.h"
#import "StrategyModel.h"
#import "HTMLStrVC.h"
#import "GeneralWebView.h"
#import "StrategyVC.h"
#import "PosMiningVC.h"
@interface FindTheGameVC ()<RefreshDelegate>

@property (nonatomic , strong)FindTheGameTableView *tableView;
@property (nonatomic , strong)NSMutableArray <StrategyModel *>*model;
@end

@implementation FindTheGameVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.topView theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    self.titleText.text = @"应用";
    self.navigationItem.titleView = self.titleText;
    
    [self initTableView];
    [self loadData];
    
    
    
}

-(void)initTableView
{
    self.tableView = [[FindTheGameTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight ) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    if ([TLUser isBlankString:self.url] == YES) {
        self.tableView.GameModel = self.GameModel;
    }
    
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    GeneralWebView *vc = [GeneralWebView new];
    vc.URL = _GameModel.url;
    vc.name = _GameModel.name;
    [self showViewController:vc sender:self];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        StrategyVC *vc = [StrategyVC new];
        vc.strategyID = self.model[indexPath.row].ID;
        [self showViewController:vc sender:self];
    }
}

-(void)loadData
{
    __weak typeof(self) weakSelf = self;
    
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.tableView = self.tableView;
    
    helper.code = @"625466";
    if ([TLUser isBlankString:self.url] == NO) {
        helper.parameters[@"dappId"] = self.url;
    }else
    {
        helper.parameters[@"dappId"] = _GameModel.ID;
    }
    
    [helper modelClass:[StrategyModel class]];
    
    [self.tableView addRefreshAction:^{
        [weakSelf details];
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (objs.count == 0) {
                [weakSelf addPlaceholderView];
                
            }
            
            weakSelf.model = objs;
            
            weakSelf.tableView.model = weakSelf.model;
            
//            weakSelf.tableView.ustds = objs;
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
            
            weakSelf.model = objs;
            
            weakSelf.tableView.model = weakSelf.model;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            [weakSelf addPlaceholderView];
            
        }];
        
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
    
}

-(void)details
{
    TLNetworking *http = [TLNetworking new];
    
    http.code = @"625457";
//    http.parameters[@"id"] = self.GameModel.ID;
    
    if ([TLUser isBlankString:self.url] == NO) {
        http.parameters[@"id"] = self.url;
    }else
    {
        http.parameters[@"id"] = _GameModel.ID;
    }
//    http.parameters[@"start"] = [NSString stringWithFormat:@"%ld",start];
//    http.parameters[@"limit"] = @"10"  ;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        self.GameModel = [FindTheGameModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.tableView.GameModel = self.GameModel;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
