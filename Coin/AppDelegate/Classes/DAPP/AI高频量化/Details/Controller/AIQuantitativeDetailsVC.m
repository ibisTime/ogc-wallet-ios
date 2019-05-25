//
//  AIQuantitativeDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeDetailsVC.h"
#import "AIQuantitativeDetailsTableView.h"
@interface AIQuantitativeDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)AIQuantitativeDetailsTableView *tableView;

@end

@implementation AIQuantitativeDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"项目详情";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    
}

- (void)initTableView {
    self.tableView = [[AIQuantitativeDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - 90) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - 90, SCREEN_WIDTH, 1)];
    [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [self.view addSubview:lineView];
    
    UIButton *shoppingBtn = [UIButton buttonWithTitle:@"购买" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16 cornerRadius:2];
    shoppingBtn.frame = CGRectMake(15, lineView.yy + 20, SCREEN_WIDTH - 30, 50);
    [shoppingBtn addTarget:self action:@selector(shoppingBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shoppingBtn];
    
    
    
}

-(void)shoppingBtnClick
{
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
