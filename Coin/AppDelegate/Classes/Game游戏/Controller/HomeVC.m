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
//#import "RedEnvelopeVC.h"

#import "HomeTbleView.h"
#import "WebVC.h"

#import "MnemonicUtil.h"
#import "UIBarButtonItem+convience.h"
//#import "TLPwdRelatedVC.h"
#import "HTMLStrVC.h"
#import "HomeFindModel.h"

#import "MnemonicUtil.h"
#import "BTCData.h"
#import "BTCNetwork.h"
#import "TLinviteVC.h"
#import "GeneralWebView.h"


#import "IconCollCell.h"
#import "TheGameCollCell.h"
#import "ClassificationCollCell.h"

#import "FindTheGameVC.h"
#import "FindTheGameModel.h"

@interface HomeVC ()<RefreshDelegate,UIViewControllerPreviewingDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ClassificationDelegate>
{
    NSInteger start;
    NSInteger category;
}

@property (nonatomic , strong)UICollectionView *collectionView;
//头部
@property (nonatomic, strong) HomeHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray <BannerModel *>*bannerRoom;
//@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic,strong) NSArray <HomeFindModel *>*findModels;
@property (nonatomic , strong)NSMutableArray <FindTheGameModel *>*GameModel;
@property (nonatomic , strong)NSMutableArray *GameModelArray;
@property (nonatomic , strong)NSArray *dataArray;
@end

@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self navigationSetDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self navigationwhiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}



-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight- kTabBarHeight) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[IconCollCell class] forCellWithReuseIdentifier:@"IconCollCell"];
        [_collectionView registerClass:[ClassificationCollCell class] forCellWithReuseIdentifier:@"ClassificationCollCell"];
        [_collectionView registerClass:[TheGameCollCell class] forCellWithReuseIdentifier:@"TheGameCollCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1"];
    }
    return _collectionView;
}

#pragma mark -- 下拉刷新
- (void)DownRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    _collectionView.mj_header = header;
    [_collectionView.mj_header beginRefreshing];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFooter)];
    footer.arrowView.hidden = YES;
    footer.stateLabel.hidden = YES;
    _collectionView.mj_footer = footer;
}

-(void)loadNewData
{
    start = 1;
    self.GameModelArray = [NSMutableArray array];
    [self requestBannerList];
    [self reloadFindData];
    [self loadData];
}

-(void)loadNewDataFooter
{
    start ++;
    [self loadData];
}

-(void)loadData
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
    
    http.code = @"625456";
    http.parameters[@"language"] = lang;
    http.parameters[@"start"] = [NSString stringWithFormat:@"%ld",start];
    http.parameters[@"limit"] = @"10";
    http.parameters[@"category"] = @(category);
    
    [http postWithSuccess:^(id responseObject) {
        
        [self.GameModelArray addObjectsFromArray:responseObject[@"data"][@"list"]];
        self.GameModel = [FindTheGameModel mj_objectArrayWithKeyValuesArray:self.GameModelArray];
        
        [_collectionView reloadData];
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationNar];
//    [self initTableView];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = kWhiteColor;
    [self DownRefresh];
    category = 0;
}

-(void)initNavigationNar
{
    self.nameLable = [[UILabel alloc]init];
    self.nameLable.text = [LangSwitcher switchLang:@"应用" key:nil];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.font = Font(18);
    self.nameLable.textColor = kWhiteColor;
//    [self.view addSubview:self.nameLable];
    self.navigationItem.titleView = self.nameLable;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//测试账号判断
    if ([[TLUser user].mobile isEqualToString:@"15268501481"]) {
        return 1;
    }
    else
    {
        return 3;
    }
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    }
    if (section == 1) {
        return 1;
    }
    return self.GameModel.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        IconCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IconCollCell" forIndexPath:indexPath];
        //    cell.backgroundColor = [UIColor redColor];
//        NSArray *imgArray = @[@"top1",@"top1",@"top1",@"top1"];
//        NSArray *array = @[@"肥猪",@"皮卡丘",@"大熊猫",@"大熊猫"];
        
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[self.dataArray[indexPath.row][@"icon"] convertImageUrl]]];
        cell.nameLbl.text = self.dataArray[indexPath.row][@"name"];
        return cell;
    }
    if (indexPath.section == 1) {
        ClassificationCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassificationCollCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    TheGameCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TheGameCollCell" forIndexPath:indexPath];
    [cell.actionBtn addTarget:self action:@selector(iconButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.actionBtn.tag = 400 + indexPath.row;
    cell.GameModel = self.GameModel[indexPath.row];
    return cell;
}

-(void)ClassificationDelegateSelectBtn:(NSInteger)tag
{
    [TLProgressHUD show];
    category = tag;
    [self loadNewData];
}

-(void)iconButtonClick:(UIButton *)sender{
//    [self loginTheWhether];
    switch (sender.tag - 300) {
        case 0:
        {
//            RedEnvelopeVC *redEnvelopeVC = [RedEnvelopeVC new];
//            [self showViewController:redEnvelopeVC sender:self];
        }
            break;
        case 1:
        {
            PosMiningVC *vc = [PosMiningVC new];
            [self showViewController:vc sender:self];
        }
            break;
        case 2:
        {
            TLinviteVC *settingVC = [TLinviteVC new];
            [self showViewController:settingVC sender:self];
        }
            break;
        case 3:
        {
            PosMiningVC *vc = [PosMiningVC new];
//            vc.url = @"WAN";
            [self showViewController:vc sender:self];
        }
            break;
            
        default:
            break;
    }
    if (sender.tag >= 400) {
        
        GeneralWebView *vc = [GeneralWebView new];
        vc.URL = self.GameModel[sender.tag - 400].url;
        vc.name = self.GameModel[sender.tag - 400].name;
        [self showViewController:vc sender:self];
        
//        FindTheGameVC *vc = [FindTheGameVC new];
//        vc.GameModel = self.GameModel[sender.tag - 400];
//        [self showViewController:vc sender:self];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 0.01;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake((SCREEN_WIDTH - 20)/3, 110);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(SCREEN_WIDTH, 55.5);
    }
    return CGSizeMake((SCREEN_WIDTH - 30)/2, (SCREEN_WIDTH - 30)/2/336 * 160);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH - 20)/702 * 310 + 10);
    }
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView addSubview:self.headerView];
        return headerView;
    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1" forIndexPath:indexPath];
    return headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GeneralWebView *vc = [GeneralWebView new];
        vc.URL = self.dataArray[indexPath.row][@"position"];
        [self showViewController:vc sender:self];
    }
    if (indexPath.section == 2) {
        FindTheGameVC *vc = [FindTheGameVC new];
        vc.GameModel = self.GameModel[indexPath.row];
        [self showViewController:vc sender:self];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}




//-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([TLUser isBlankString:[TLUser user].userId] == YES)
//
//    {
//        [TLAlert alertWithTitle:[LangSwitcher switchLang:@"提示" key:nil] msg:[LangSwitcher switchLang:@"您还未登录，是否前去登录" key:nil] confirmMsg:[LangSwitcher switchLang:@"确认" key:nil] cancleMsg:[LangSwitcher switchLang:@"取消" key:nil] cancle:^(UIAlertAction *action) {
//
//        } confirm:^(UIAlertAction *action) {
//            TheInitialVC *vc = [[TheInitialVC alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//            [rootViewController presentViewController:nav animated:YES completion:nil];
//        }];
//
//        return;
//    }
//    HomeFindModel *model = self.findModels[indexPath.row];
//    if ([model.action isEqualToString:@"red_packet"]) {
//        RedEnvelopeVC *redEnvelopeVC = [RedEnvelopeVC new];
//        [self showViewController:redEnvelopeVC sender:self];;
//        return;
//
//    }else if ([model.action isEqualToString:@"money_manager"])
//    {
//        PosMiningVC *vc = [PosMiningVC new];
//        [self showViewController:vc sender:self];;
//        return;
//
//    }else if ([model.action isEqualToString:@"invitation"])
//    {
//        TLinviteVC *settingVC = [TLinviteVC new];
//        [self showViewController:settingVC sender:self];;
//        return;
//
//    }else if ([model.action isEqualToString:@"none"]) {
//        HTMLStrVC *vc = [HTMLStrVC new];
//        vc.title = model.name;
//        vc.name = model.name;
//        vc.des = model.Description;
//        vc.type = HTMLTypeOther;
//        [self showViewController:vc sender:self];
////        [self.navigationController pushViewController:vc animated:YES];
//        return;
//    }
//}



#pragma mark - Init



- (void)OpenMessage
{
//    if ([TLUser isBlankString:[TLUser user].userId] == YES)
//
//    {
//        [TLAlert alertWithTitle:[LangSwitcher switchLang:@"提示" key:nil] msg:[LangSwitcher switchLang:@"您还未登录，是否前去登录" key:nil] confirmMsg:[LangSwitcher switchLang:@"确认" key:nil] cancleMsg:[LangSwitcher switchLang:@"取消" key:nil] cancle:^(UIAlertAction *action) {
//
//        } confirm:^(UIAlertAction *action) {
//            TheInitialVC *vc = [[TheInitialVC alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//            [rootViewController presentViewController:nav animated:YES completion:nil];
//        }];
//
//        return;
//    }
//    RateDescVC *vc = [RateDescVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (HomeHeaderView *)headerView {
    
    if (!_headerView) {
        
        CoinWeakSelf;
        //头部
        _headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10 + (SCREEN_WIDTH - 20)/702 * 310 + 10)];
        
        _headerView.headerBlock = ^(HomeEventsType type, NSInteger index, HomeFindModel *find) {
            [weakSelf headerViewEventsWithType:type index:index model:find];
        };
         _headerView.scrollEnabled = NO;
    }
    return _headerView;
}



#pragma mark - HeaderEvents
- (void)headerViewEventsWithType:(HomeEventsType)type index:(NSInteger)index  model:(HomeFindModel *)model
{
//    if ([TLUser isBlankString:[TLUser user].userId] == YES)
//
//    {
//        [TLAlert alertWithTitle:[LangSwitcher switchLang:@"提示" key:nil] msg:[LangSwitcher switchLang:@"您还未登录，是否前去登录" key:nil] confirmMsg:[LangSwitcher switchLang:@"确认" key:nil] cancleMsg:[LangSwitcher switchLang:@"取消" key:nil] cancle:^(UIAlertAction *action) {
//
//        } confirm:^(UIAlertAction *action) {
//            TheInitialVC *vc = [[TheInitialVC alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//            [rootViewController presentViewController:nav animated:YES completion:nil];
//        }];
//        return;
//    }
    
    if ([self.bannerRoom[index].type isEqualToString:@"0"])
    {
        return;
    }
    
    if ([self.bannerRoom[index].type isEqualToString:@"1"])
    {
        NSString *url = [[self.bannerRoom objectAtIndex:index] url];
        if (url && url.length > 0) {
            GeneralWebView *vc = [GeneralWebView new];
            vc.URL = url;
            [self showViewController:vc sender:self];
        }
    }
    if ([self.bannerRoom[index].type isEqualToString:@"2"])
    {
        FindTheGameVC *vc = [FindTheGameVC new];
        vc.url = [[self.bannerRoom objectAtIndex:index] url];
        [self showViewController:vc sender:self];
    }
    
//    if ([url hasPrefix:@"http"]) {
//
//    }
//    if (url && url.length > 0) {
//        GeneralWebView *vc = [GeneralWebView new];
//        vc.URL = url;
//        [self showViewController:vc sender:self];
//
//    }
}

#pragma mark - Data
- (void)requestBannerList {
    
//    [TLProgressHUD show];

    TLNetworking *http = [TLNetworking new];
//    http.showView = self.view;
    http.isUploadToken = NO;
    http.code = @"630506";
    http.parameters[@"location"] = @"app_home";
    
    [http postWithSuccess:^(id responseObject) {
        
        self.bannerRoom = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.headerView.banners = self.bannerRoom;
//        [self reloadFindData];
        //获取官方钱包总量，已空投量
//        [_collectionView.mj_footer endRefreshing];
//        [_collectionView.mj_header endRefreshing];

    } failure:^(NSError *error) {
        
//        [_collectionView.mj_footer endRefreshing];
//        [_collectionView.mj_header endRefreshing];
        
    }];
    
}

#pragma mark - 获取发现列表数据
- (void)reloadFindData{

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
    http.parameters[@"language"] = lang;
    http.parameters[@"location"] = @"0";
    http.parameters[@"status"] = @"1";

    [http postWithSuccess:^(id responseObject) {

        self.dataArray = responseObject[@"data"];
        [self.collectionView reloadData];

    } failure:^(NSError *error) {
//        [self.collectionView endRefreshHeader];
    }];
}



@end
