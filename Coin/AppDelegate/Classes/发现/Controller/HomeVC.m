//
//  HomeVC.m
//  OGC
//
//  Created by 蔡卓越 on 2018/3/13.
//  Copyright © 2018年  tianlei. All rights reserved.
//

#import "HomeVC.h"

#import "CountInfoModel.h"

#import "HomeHeaderView.h"
#import "TLProgressHUD.h"

#import "PosMiningVC.h"
#import "RateDescVC.h"
#import "RedEnvelopeVC.h"

#import "HomeTbleView.h"
#import "WebVC.h"

#import "MnemonicUtil.h"
#import "UIBarButtonItem+convience.h"
#import "TLPwdRelatedVC.h"
#import "HTMLStrVC.h"
#import "HomeFindModel.h"

#import "BTC256+Tests.h"
#import "BTCData+Tests.h"
#import "BTCMnemonic+Tests.h"
#import "BTCBigNumber+Tests.h"
#import "BTCBase58+Tests.h"
#import "BTCAddress+Tests.h"
#import "BTCProtocolSerialization+Tests.h"
#import "BTCKey+Tests.h"
#import "BTCKeychain+Tests.h"
#import "BTCCurvePoint+Tests.h"
#import "BTCBlindSignature+Tests.h"
#import "BTCEncryptedBackup+Tests.h"
#import "BTCEncryptedMessage+Tests.h"
#import "BTCFancyEncryptedMessage+Tests.h"
#import "BTCScript+Tests.h"
#import "BTCTransaction+Tests.h"
#import "BTCBlockchainInfo+Tests.h"
#import "BTCPriceSource+Tests.h"
#import "BTCMerkleTree+Tests.h"
#import "BTCBitcoinURL+Tests.h"
#import "BTCCurrencyConverter+Tests.h"

#import "MnemonicUtil.h"
#import "BTCData.h"
#import "BTCNetwork.h"
#import "TLinviteVC.h"

#import "FoundHeadView.h"

@interface HomeVC ()<RefreshDelegate,UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) HomeTbleView *tableView;

//头部
@property (nonatomic, strong) FoundHeadView *headerView;
//
@property (nonatomic,strong) NSMutableArray <BannerModel *>*bannerRoom;
//@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic,strong) NSArray <HomeFindModel *>*findModels;

@end

@implementation HomeVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationNar];
    [self initTableView];
    self.view.backgroundColor = kWhiteColor;
}

-(void)initNavigationNar
{
//    self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.backButton.frame = CGRectMake(kScreenWidth-74, kStatusBarHeight, 44, 44);
//    [self.backButton setImage:kImage(@"消息") forState:(UIControlStateNormal)];
//    [self.backButton addTarget:self action:@selector(OpenMessage) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:self.backButton];

    
    [self.view addSubview:self.headerView];
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(54, kStatusBarHeight, kScreenWidth - 108, 44)];
    self.nameLable.text = [LangSwitcher switchLang:@"发现" key:nil];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.font = Font(16);
    self.nameLable.textColor = kWhiteColor;
    [self.view addSubview:self.nameLable];
    
    
    
}




- (void)initTableView {
    
    CoinWeakSelf;
    self.tableView = [[HomeTbleView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + 160, kScreenWidth, kScreenHeight - kStatusBarHeight - kTabBarHeight - 160) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
//    self.tableView.tableHeaderView = self.headerView;
    [self.tableView addRefreshAction:^{
        [CoinUtil refreshOpenCoinList:^{
            //获取banner列表
            [weakSelf requestBannerList];
//            [weakSelf reloadFindData];

        } failure:^{
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [weakSelf.tableView beginRefreshing];
}



-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeFindModel *model = self.findModels[indexPath.row];
    if ([model.action isEqualToString:@"red_packet"]) {
        RedEnvelopeVC *redEnvelopeVC = [RedEnvelopeVC new];
        redEnvelopeVC.hidesBottomBarWhenPushed = YES;
        [self showViewController:redEnvelopeVC sender:self];;
        return;

    }else if ([model.action isEqualToString:@"money_manager"])
    {
        PosMiningVC *vc = [PosMiningVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self showViewController:vc sender:self];;
        return;

    }else if ([model.action isEqualToString:@"invitation"])
    {
        TLinviteVC *settingVC = [TLinviteVC new];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self showViewController:settingVC sender:self];;
        return;

    }else if ([model.action isEqualToString:@"none"]) {
        HTMLStrVC *vc = [HTMLStrVC new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = model.name;
        vc.name = model.name;
        vc.des = model.Description;
        vc.type = HTMLTypeOther;
        [self showViewController:vc sender:self];
//        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}



#pragma mark - Init



- (void)OpenMessage
{
    RateDescVC *vc = [RateDescVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (FoundHeadView *)headerView {
    
    if (!_headerView) {
        
        //头部
        _headerView = [[FoundHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160 + kStatusBarHeight)];

    }
    return _headerView;
}



#pragma mark - HeaderEvents
//- (void)headerViewEventsWithType:(HomeEventsType)type index:(NSInteger)index  model:(HomeFindModel *)model{
//    NSString *url = [[self.bannerRoom objectAtIndex:index] url];
//    if (url && url.length > 0) {
//        WebVC *webVC = [[WebVC alloc] init];
//        webVC.url = url;
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
//}

#pragma mark - Data


- (void)requestBannerList {
    
//    [TLProgressHUD show];

    TLNetworking *http = [TLNetworking new];
//    http.showView = self.view;
    http.isUploadToken = NO;
    http.code = @"805806";
    http.parameters[@"location"] = @"app_home";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.bannerRoom = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        self.headerView.banners = self.bannerRoom;
        [self reloadFindData];
        //获取官方钱包总量，已空投量
//        [self.tableView endRefreshHeader];

    } failure:^(NSError *error) {
        
        [self.tableView endRefreshHeader];
        
    }];
    
}

#pragma mark - 获取发现列表数据
- (void)reloadFindData
{

    NSString *lang;

    LangType type = [LangSwitcher currentLangType];
    if (type == LangTypeSimple || type == LangTypeTraditional)
    {
        lang = @"ZH_CN";
    }else if (type == LangTypeKorean)
    {
        lang = @"KO";
    }else
    {
        lang = @"EN";

    }
    TLNetworking *http = [TLNetworking new];

    http.code = @"625412";
    http.parameters[@"language"] = lang  ;
    http.parameters[@"location"] = @"0";
    http.parameters[@"status"] = @"1"  ;

    [http postWithSuccess:^(id responseObject) {

        self.tableView.findModels = [HomeFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView endRefreshHeader];
        [self.tableView reloadData];
        if (self.findModels.count != self.tableView.findModels.count) {
            [TableViewAnimationKit showWithAnimationType:2 tableView:self.tableView];
        }
        self.findModels = [HomeFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

    } failure:^(NSError *error) {
        [self.tableView endRefreshHeader];
    }];
}



@end
