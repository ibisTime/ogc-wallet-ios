//
//  SwitchPurseVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/6.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SwitchPurseVC.h"
#import "SwitchPurseTableView.h"
#import "SwitchPurseHeadView.h"
#import "BuildWalletMineVC.h"
#import "WalletImportVC.h"
@interface SwitchPurseVC ()<RefreshDelegate>
@property (nonatomic , strong)SwitchPurseHeadView *headView;
@property (nonatomic , strong)SwitchPurseTableView *tableView;
@end

@implementation SwitchPurseVC

-(SwitchPurseHeadView *)headView
{
    if (!_headView) {
        _headView = [[SwitchPurseHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    }
    return _headView;
}

- (void)initTableView {
    self.tableView = [[SwitchPurseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
 
    if (index == 100)
    {
        BuildWalletMineVC *vc = [BuildWalletMineVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        WalletImportVC *vc = [WalletImportVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.topView theme_setBackgroundColorIdentifier:TableViewColor moduleName:ColorName];
    [self initTableView];
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
