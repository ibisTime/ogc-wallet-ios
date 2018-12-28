//
//  JoinMineVc.m
//  Coin
//
//  Created by shaojianfei on 2018/6/7.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "JoinMineVc.h"
#import "JoinMineTableView.h"
#import "JoinModel.h"
@interface JoinMineVc ()<RefreshDelegate>
@property (nonatomic , strong) JoinMineTableView *tableView;
@property (nonatomic , strong) NSMutableArray <JoinModel *>*models;
@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic, strong) UIButton *showView;

@end

@implementation JoinMineVc
-(UIButton *)showView
{
    
    if (!_showView) {
        _showView = [[UIButton alloc] init];
        [_showView setBackgroundColor:kBlackColor];
        [_showView setTitleColor:kWhiteColor forState:UIControlStateNormal];
        
    }
    return _showView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self requestInfo];
    
    self.titleText.text = [LangSwitcher switchLang:@"加入社群" key:nil];
    self.titleText.textColor = kTextBlack;
    self.navigationItem.titleView = self.titleText;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)requestInfo
{
    TLNetworking *http = [[TLNetworking alloc] init];
    http.code = @"600115";
    http.showView = self.view;
    http.parameters[@"type"] = @"followUs";
    [http postWithSuccess:^(id responseObject) {
        self.models = [JoinModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        self.tableView.models = self.models;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    
    }];
}

- (void)initTableView
{
    self.tableView = [[JoinMineTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStylePlain];
    //    self.tableView.tableHeaderView = self.headerView;
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    //    [self.tableView adjustsContentInsets];
    [self.view addSubview:self.tableView];
}

- (void)buttonClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    NSString *address ;
    address = self.tableView.models[indexPath.row].cvalue;
    pasteBoard.string = address;
    if (pasteBoard == nil) {
        [self.view addSubview:self.showView];
        [self.showView setTitle:[LangSwitcher switchLang:@"复制失败, 请重新复制" key:nil] forState:UIControlStateNormal];
        self.showView.hidden = NO;
        [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.tableView.mas_centerX);
            make.centerY.equalTo(self.tableView.mas_centerY);
            make.width.equalTo(@114);
            make.height.equalTo(@53);
        }];
        //            [TLAlert alertWithError:@"复制失败, 请重新复制"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.showView.hidden = YES;
            [self.showView removeFromSuperview];
        });
    } else {
        [self.view addSubview:self.showView];
        self.showView.hidden = NO;
        
        [self.showView setTitle:[LangSwitcher switchLang:@"复制成功" key:nil] forState:UIControlStateNormal];
        [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.tableView.mas_centerX);
            make.centerY.equalTo(self.tableView.mas_centerY);
            make.width.equalTo(@114);
            make.height.equalTo(@53);
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.showView.hidden = YES;
            [self.showView removeFromSuperview];
        });
        //            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功" key:nil]];
    }
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
