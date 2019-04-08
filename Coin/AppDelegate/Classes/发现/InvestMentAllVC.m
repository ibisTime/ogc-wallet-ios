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

@interface InvestMentAllVC()<JXSegmentDelegate,JXPageViewDataSource,JXPageViewDelegate>
{
    JXPageView *pageView;
    JXSegment *segment;
}

@property(nonatomic,strong) NSArray *channelArray;

@end

@implementation InvestMentAllVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    segment = [[JXSegment alloc] initWithFrame:CGRectMake(70, kStatusBarHeight, SCREEN_WIDTH - 140, 44)];
    [segment updateChannels:self.channelArray];
    
    segment.delegate = self;
    [self.view addSubview:segment];
    
    
    
    pageView =[[JXPageView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    pageView.datasource = self;
    pageView.delegate = self;
    [pageView reloadData];
    [pageView changeToItemAtIndex:0];
    [self.view addSubview:pageView];
    
    
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightButton.frame = CGRectMake(SCREEN_WIDTH - 44-15, kStatusBarHeight, 44, 44);
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font = FONT(15);
    [rightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [rightButton setTitle:@"账单" forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:rightButton];
    
}

-(void)myRecodeClick
{
    OrderRecordVC *vc = [OrderRecordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray*)channelArray{
    if (_channelArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *arr = [[CoinModel coin] getOpenCoinList];
        for (int i = 0; i < arr.count; i ++) {
            CoinModel *model = arr[i];
            if ([model.isAccept isEqualToString:@"1"]) {
                [array addObject:model.symbol];
            }
        }
        _channelArray = array;
    }
    return _channelArray;
}

#pragma mark - JXPageViewDataSource
-(NSInteger)numberOfItemInJXPageView:(JXPageView *)pageView{
    return self.channelArray.count;
}

-(UIView*)pageView:(JXPageView *)pageView viewAtIndex:(NSInteger)index{
    UIView *view = [[UIView alloc] init];
    InvestmentVC *vc = [[InvestmentVC alloc]init];
    vc.symbol = _channelArray[index];
    [self addChildViewController:vc];
    [view addSubview:vc.view];

    return view;
}

#pragma mark - JXSegmentDelegate
- (void)JXSegment:(JXSegment*)segment didSelectIndex:(NSInteger)index{
    [pageView changeToItemAtIndex:index];
}

#pragma mark - JXPageViewDelegate
- (void)didScrollToIndex:(NSInteger)index{
    [segment didChengeToIndex:index];
}


- (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
