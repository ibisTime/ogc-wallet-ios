//
//  MyMillVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillVC.h"
#import "MyMillTableView.h"
#import "MyMillDetailsVC.h"
@interface MyMillVC ()<RefreshDelegate>

@property (nonatomic , strong)MyMillTableView *tableView;

@end

@implementation MyMillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"我的矿机";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[MyMillTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight ) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    MyMillDetailsVC *vc = [MyMillDetailsVC new];
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
