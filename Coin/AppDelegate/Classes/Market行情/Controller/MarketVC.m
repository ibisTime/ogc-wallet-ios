//
//  MarketVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/5.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MarketVC.h"
#import "MarketTableView.h"
#import "MarketDetailsVC.h"
@interface MarketVC ()<RefreshDelegate>

@property (nonatomic ,strong)MarketTableView *tableView;

@end

@implementation MarketVC


-(MarketTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MarketTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStyleGrouped];
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.showsHorizontalScrollIndicator = YES;
        self.tableView.refreshDelegate = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, -44, 100, 44)];
    nameLable.text = [LangSwitcher switchLang:@"行情" key:nil];
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.font = Font(24);
    [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
    [self.view addSubview:nameLable];
    
    [self.view addSubview:self.tableView];
    
    
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketDetailsVC *vc = [MarketDetailsVC new];
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
