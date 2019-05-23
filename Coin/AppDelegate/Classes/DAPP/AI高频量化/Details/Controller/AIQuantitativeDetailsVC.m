//
//  AIQuantitativeDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeDetailsVC.h"
#import "AIQuantitativeDetailsTableView.h"
@interface AIQuantitativeDetailsVC ()

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
    self.tableView = [[AIQuantitativeDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight ) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    
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
