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
@interface AIQuantitativeVC ()<RefreshDelegate>

@property (nonatomic , strong)AIQuantitativeTableView *tableView;

@end

@implementation AIQuantitativeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"搬砖生息";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    
}

- (void)initTableView {
    self.tableView = [[AIQuantitativeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight ) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    
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
