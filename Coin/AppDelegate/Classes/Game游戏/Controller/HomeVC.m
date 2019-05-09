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

@interface HomeVC ()<RefreshDelegate,UIViewControllerPreviewingDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ClassificationDelegate,IconCollDelegate>
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
@property (nonatomic , strong)NSMutableArray <FindTheGameModel *>*dataArray;
@property (nonatomic , strong)NSArray *dvalueArray;
@end

@implementation HomeVC




-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight- kTabBarHeight) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
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
    [self classification];
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
    [self.topView theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    [self DownRefresh];
    category = 1;
}

-(void)initNavigationNar
{
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, kStatusBarHeight, 100, 44)];
    nameLable.text = [LangSwitcher switchLang:@"DAPP" key:nil];
    nameLable.textAlignment = NSTextAlignmentLeft;
    self.nameLable = nameLable;
    nameLable.font = Font(24);
    [nameLable theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
    [self.topView addSubview:nameLable];
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
        return 1;
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
        [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];

        cell.dataArray = self.dataArray;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        ClassificationCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassificationCollCell" forIndexPath:indexPath];
        cell.delegate = self;
        [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
        cell.dvalueArray = self.dvalueArray;
        return cell;
    }
    TheGameCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TheGameCollCell" forIndexPath:indexPath];
    [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    cell.GameModel = self.GameModel[indexPath.row];
    return cell;
}

-(void)IconCollDelegateSelectBtn:(NSInteger)tag
{
//    PosMiningVC *vc = [PosMiningVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    if ([self.dataArray[tag].action isEqualToString:@"0"]) {
        GeneralWebView *vc = [GeneralWebView new];
        vc.URL = self.dataArray[tag].url;
        [self showViewController:vc sender:self];
    }
    if ([self.dataArray[tag].action isEqualToString:@"1"])
    {

    }
    if ([self.dataArray[tag].action isEqualToString:@"2"])
    {
        GeneralWebView *vc = [GeneralWebView new];
        vc.URL = self.dataArray[tag].url;
        [self showViewController:vc sender:self];
    }
    if ([self.dataArray[tag].action isEqualToString:@"3"])
    {
        FindTheGameVC *vc = [FindTheGameVC new];
        vc.url = self.dataArray[tag].url;

        [self showViewController:vc sender:self];
    }
    if ([self.dataArray[tag].action isEqualToString:@"4"])
    {

    }
}

-(void)classification
{
    if (_dvalueArray.count == 0) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"630036";
        
        http.parameters[@"parentKey"] = @"dopen_app_category";
        
        [http postWithSuccess:^(id responseObject) {
            //        [self LoadData];
            _dvalueArray = responseObject[@"data"];
            [self.collectionView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

-(void)ClassificationDelegateSelectBtn:(NSInteger)tag
{
    [TLProgressHUD show];
    category = [self.dvalueArray[tag][@"dkey"] integerValue];
    [self loadNewData];
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
        return CGSizeMake((SCREEN_WIDTH), 110);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(SCREEN_WIDTH, 55.5);
    }
    return CGSizeMake((SCREEN_WIDTH - 30)/2, 75);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH - 20)/690 * 320 + 10);
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
//    if (indexPath.section == 0) {
//        GeneralWebView *vc = [GeneralWebView new];
//        vc.URL = self.dataArray[indexPath.row][@"position"];
//        [self showViewController:vc sender:self];
//    }
    if (indexPath.section == 2) {
        if ([self.GameModel[indexPath.row].action isEqualToString:@"0"])
        {
            NSString *url = self.GameModel[indexPath.row].url;
            GeneralWebView *vc = [GeneralWebView new];
            vc.URL = url;
            [self showViewController:vc sender:self];
        }
        if ([self.GameModel[indexPath.row].action isEqualToString:@"1"])
        {
            
        }
        if ([self.GameModel[indexPath.row].action isEqualToString:@"2"])
        {
            NSString *url = self.GameModel[indexPath.row].url;
            GeneralWebView *vc = [GeneralWebView new];
            vc.URL = url;
            [self showViewController:vc sender:self];
        }
        if ([self.GameModel[indexPath.row].action isEqualToString:@"3"])
        {
            FindTheGameVC *vc = [FindTheGameVC new];
            vc.url = self.GameModel[indexPath.row].url;
            [self showViewController:vc sender:self];
        }
        if ([self.GameModel[indexPath.row].action isEqualToString:@"4"])
        {
            
        }
    }
}

//-(void)selectInRow:(NSInteger)index
//{
//    if ([self.dataArray[index].action isEqualToString:@"0"]) {
//        GeneralWebView *vc = [GeneralWebView new];
//        vc.URL = self.dataArray[index].url;
//        [self showViewController:vc sender:self];
//    }
//    if ([self.dataArray[index].action isEqualToString:@"1"])
//    {
//
//    }
//    if ([self.dataArray[index].action isEqualToString:@"2"])
//    {
//        GeneralWebView *vc = [GeneralWebView new];
//        vc.URL = self.dataArray[index].url;
//        [self showViewController:vc sender:self];
//    }
//    if ([self.dataArray[index].action isEqualToString:@"3"])
//    {
//        FindTheGameVC *vc = [FindTheGameVC new];
//        vc.url = self.dataArray[index].url;
//
//        [self showViewController:vc sender:self];
//    }
//    if ([self.dataArray[index].action isEqualToString:@"4"])
//    {
//
//    }
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0,0, 0, 0);
    }
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}



#pragma mark - Init



- (void)OpenMessage
{
    
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
    
    NSString *url = [[self.bannerRoom objectAtIndex:index] url];
    GeneralWebView *vc = [GeneralWebView new];
    vc.URL = url;
    [self showViewController:vc sender:self];
    
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

        self.dataArray = [FindTheGameModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        self.dataArray = responseObject[@"data"];
        [self.collectionView reloadData];

    } failure:^(NSError *error) {
//        [self.collectionView endRefreshHeader];
    }];
}



@end
