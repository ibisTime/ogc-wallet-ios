//
//  TLMeSetting.m
//  Coin
//
//  Created by shaojianfei on 2018/8/8.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLMeSetting.h"
#import "IdAuthVC.h"
#import "ZMAuthVC.h"
#import "TLChangeMobileVC.h"
#import "TLUserForgetPwdVC.h"
#import "HTMLStrVC.h"
#import "TLTabBarController.h"
#import "EditVC.h"
#import "GoogleAuthVC.h"
#import "CloseGoogleAuthVC.h"
#import "ChangeLoginPwdVC.h"
#import "SettingGroup.h"
#import "SettingModel.h"
#import "SettingTableView.h"
#import "SettingCell.h"
#import "AppMacro.h"
#import "APICodeMacro.h"
#import "EditEmailVC.h"
#import "TLAlert.h"
#import "NSString+Check.h"
#import "TLProgressHUD.h"
#import "LangChooseVC.h"
#import "TLUserLoginVC.h"
#import "ZLGestureLockViewController.h"
#import "LocalSettingTableView.h"
#import "ChangeLocalMoneyVC.h"
#import "TLAboutUsVC.h"
#import "GengXinModel.h"
#import "SetUpTableView.h"

@interface TLMeSetting ()<RefreshDelegate>

//@property (nonatomic, strong) SettingTableView *tableView;
@property (nonatomic, strong) SetUpTableView *tableView;



@end

@implementation TLMeSetting


//- (void)viewWillAppear:(BOOL)animated
//{
//    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController.navigationBar setShadowImage:nil];
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}


- (void)initTableView {
    
    
    
    self.tableView = [[SetUpTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    if (indexPath.row == 0) {
//        LangChooseVC *vc = [LangChooseVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    if (indexPath.row == 0) {
        ChangeLocalMoneyVC *vc = [ChangeLocalMoneyVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        TLAboutUsVC *vc = [TLAboutUsVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (NSString *)version {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
}

- (NSString *)current {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
}


@end
