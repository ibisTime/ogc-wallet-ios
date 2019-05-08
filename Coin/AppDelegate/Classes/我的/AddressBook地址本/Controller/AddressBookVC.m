//
//  AddressBookVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AddressBookVC.h"
#import "AddressBookTableView.h"
#import "AddAddressVC.h"
@interface AddressBookVC ()<RefreshDelegate>



@property (nonatomic , strong)AddressBookTableView *tableView;

@end
@implementation AddressBookVC



-(AddressBookTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[AddressBookTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.showsHorizontalScrollIndicator = YES;
        self.tableView.refreshDelegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"地址本" key:nil];
    self.navigationItem.titleView = self.titleText;
    [self.view addSubview:self.tableView];
    
    [self.RightButton theme_setTitleIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    [self.RightButton setTitle:@"添加" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(RightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    
}

-(void)RightButtonClick
{
    AddAddressVC *vc = [AddAddressVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
