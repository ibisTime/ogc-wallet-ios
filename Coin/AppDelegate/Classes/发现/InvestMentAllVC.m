//
//  InvestMentAllVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/2/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "InvestMentAllVC.h"

#import "JXSegment.h"
#import "JXPageView.h"
#import "InvestmentVC.h"
#import "USDTInvestmentVC.h"
#import "OrderRecordVC.h"
#import "MLMSegmentHead.h"
#import "MLMSegmentScroll.h"
#import "MLMSegmentManager.h"
@interface InvestMentAllVC()<JXSegmentDelegate,JXPageViewDataSource,JXPageViewDelegate>
{
    JXPageView *pageView;
    JXSegment *segment;
}

@property(nonatomic,strong) NSArray *channelArray;

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;

@property (nonatomic, assign) MLMSegmentHeadStyle style;
@property (nonatomic, assign) MLMSegmentLayoutStyle layout;
@end

@implementation InvestMentAllVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arr = [[CoinModel coin] getOpenCoinList];
    for (int i = 0; i < arr.count; i ++) {
        CoinModel *model = arr[i];
        if ([model.isAccept isEqualToString:@"1"]) {
            [array addObject:model.symbol];
        }
    }
    _channelArray = array;
    
    
    [self segmentStyle];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    segment = [[JXSegment alloc] initWithFrame:CGRectMake(70, kStatusBarHeight, SCREEN_WIDTH - 140, 44)];
//    [segment updateChannels:self.channelArray];
//
//    segment.delegate = self;
//    [self.view addSubview:segment];
//
//
//
//    pageView =[[JXPageView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
//    pageView.datasource = self;
//    pageView.delegate = self;
//
//    [pageView changeToItemAtIndex:0];
//    [self.view addSubview:pageView];
//    [pageView reloadData];
    
    
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightButton.frame = CGRectMake(SCREEN_WIDTH - 44-15, kStatusBarHeight , 44, 44);
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font = FONT(16);
    [rightButton setTitle:@"账单" forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:rightButton];
    [rightButton theme_setBackgroundImageIdentifier:BackColor forState:(UIControlStateNormal) moduleName:ColorName];
    [rightButton theme_setTitleIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    
//    self.RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.RightButton.titleLabel.font = FONT(16);
    
//    [self.RightButton setTitle:@"账单" forState:(UIControlStateNormal)];
//    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -10;
//    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    
}


- (void)segmentStyle {
//    _channelArray = @[@"推荐",
//             @"美容瘦身",
//                      @"科技",@"推荐",
//                      @"美容瘦身",
//                      @"科技",@"推荐",
//                      @"美容瘦身",
//                      @"科技"
//             ];
    
    _style = SegmentHeadStyleLine;
    _layout = MLMSegmentLayoutCenter;
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(70, kStatusBarHeight, SCREEN_WIDTH - 140, 44) titles:_channelArray headStyle:_style layoutStyle:_layout];
    _segHead.headColor = [UIColor clearColor];
    _segHead.fontScale = .85;
    _segHead.fontSize = 15;
    _segHead.lineScale = .5;
    _segHead.equalSize = YES;
    _segHead.lineColor = kTabbarColor;
    _segHead.bottomLineHeight = 0;
    _segHead.lineHeight = 2;
    _segHead.selectColor = kTabbarColor;
    
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH , SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) vcOrViews:[self vcArr:_channelArray.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
//    _segScroll.contentMode = UIViewContentModeScaleToFill;
//    _segScroll.userInteractionEnabled = YES;
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        [self.view addSubview:_segHead];
        [self.view addSubview:_segScroll];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
        InvestmentVC *vc = [[InvestmentVC alloc]init];
        vc.symbol = _channelArray[i];
        [arr addObject:vc];
    }
    return arr;
}


-(void)myRecodeClick
{
    OrderRecordVC *vc = [OrderRecordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

//#pragma mark - JXPageViewDataSource
//-(NSInteger)numberOfItemInJXPageView:(JXPageView *)pageView{
//    return self.channelArray.count;
//}
//
//-(UIView*)pageView:(JXPageView *)pageView viewAtIndex:(NSInteger)index{
//    UIView *view = [[UIView alloc] init];
//    InvestmentVC *vc = [[InvestmentVC alloc]init];
//    vc.symbol = _channelArray[index];
//    [self addChildViewController:vc];
//    [view addSubview:vc.view];
//
//    return view;
//}
//
//#pragma mark - JXSegmentDelegate
//- (void)JXSegment:(JXSegment*)segment didSelectIndex:(NSInteger)index{
//    [pageView changeToItemAtIndex:index];
//}
//
//#pragma mark - JXPageViewDelegate
//- (void)didScrollToIndex:(NSInteger)index{
//    [segment didChengeToIndex:index];
//}
//
//
//- (UIColor *) randomColor
//{
//    CGFloat hue = ( arc4random() % 256 / 256.0 );
//    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
//    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
//    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
//}

@end
