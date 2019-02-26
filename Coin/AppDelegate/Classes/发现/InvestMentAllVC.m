//
//  InvestMentAllVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/2/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "InvestMentAllVC.h"
#import "InvestmentVC.h"
#import "USDTInvestmentVC.h"
#import "OrderRecordVC.h"
@interface InvestMentAllVC ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic, assign)NSInteger currentPages;

@property (nonatomic, strong)UILabel *WeiGreLabel;
//@property (nonatomic, strong)MyOrderQBDDViewController *vc1;
@property (nonatomic, strong)InvestmentVC *vc1;
@property (nonatomic, strong)USDTInvestmentVC *vc2;


#define kPageCount 2

#define kMrg 10
#define kTag 10000000

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //设置可以左右滑动的ScrollView
    [self setupScrollView];
    //设置控制的每一个子控制器
    [self setupChildViewControll];
    //设置分页按钮
    [self setupPageButton];
    self.WeiGreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2 - 30 / 2, kNavigationBarHeight - 2 , 30, 2)];
    self.WeiGreLabel.backgroundColor = kTabbarColor;
    [self.view addSubview:self.WeiGreLabel];
    
    [self setupSelectBtn];
    [_scroll setContentOffset:CGPointMake(SCREEN_WIDTH * _currentPages, 0) animated:YES];
    
    
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightButton.frame = CGRectMake(SCREEN_WIDTH - 44-15, kStatusBarHeight, 44, 44);
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font = FONT(15);
    [rightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [rightButton setTitle:@"账单" forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:rightButton];
    
}


//我的订单
-(void)myRecodeClick
{
    OrderRecordVC *vc = [OrderRecordVC new];
    vc.hidesBottomBarWhenPushed = YES;
    if (self.currentPages == 0) {
        vc.symbol = @"BTC";
    }else
    {
        vc.symbol = @"USDT";
    }
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 设置可以左右滑动的ScrollView
- (void)setupScrollView{
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight , SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    //    _scroll.backgroundColor = [UIColor redColor];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.directionalLockEnabled = YES;
    
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * kPageCount, 0);
    [self.view addSubview:_scroll];
}

#pragma mark - 设置控制的每一个子控制器
- (void)setupChildViewControll{
    //    self.vc1 = [[MyOrderQBDDViewController alloc]init];
    self.vc1 = [[InvestmentVC alloc]init];
    self.vc2 = [[USDTInvestmentVC alloc]init];
    
    //指定该控制器为其子控制器
    //    [self addChildViewController:_vc1];
    [self addChildViewController:_vc1];
    [self addChildViewController:_vc2];
    
    //将视图加入ScrollView上
    //    [_scroll addSubview:_vc1.view];
    [_scroll addSubview:_vc1.view];
    [_scroll addSubview:_vc2.view];
    
    //设置两个控制器的尺寸
    _vc1.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc2.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //    _vc5.view.frame = CGRectMake(SCREEN_WIDTH*4, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
#pragma mark - 设置分页按钮
- (void)setupPageButton{
    //button的index值应当从0开始
    
    UIButton *btn = [self setupButtonWithTitle:@"BTC" Index:0];
    [self setupButtonWithTitle:@"USDT" Index:1];
    
    
    [btn setTitleColor:kTabbarColor forState:(UIControlStateNormal)];
    self.selectBtn = btn;
}
- (UIButton *)setupButtonWithTitle:(NSString *)title Index:(NSInteger)index{
    CGFloat y = 0;
    
    CGFloat w = 100;
//    CGFloat h = kButton_H;
    CGFloat x = SCREEN_WIDTH/2 - 100 + index * 100;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(x, kStatusBarHeight, w, 44);
    btn.titleLabel.font = FONT(16);
    btn.tag = index + kTag;
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(pageClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    return btn;
}

#pragma mark -- 按钮点击方法
- (void)pageClick:(UIButton *)btn
{
    self.currentPages = btn.tag - kTag;
    [self gotoCurrentPage];
//    [self setupSelectBtn];
}

#pragma mark - 设置选中button的样式
- (void)setupSelectBtn{
    UIButton *btn = [self.view viewWithTag:self.currentPages + kTag];
    if ([self.selectBtn isEqual:btn]) {
        return;
    }
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.selectBtn = btn;
    [btn setTitleColor:kTabbarColor forState:(UIControlStateNormal)];
    
    [UIView animateWithDuration:0.3 animations:^{
        _WeiGreLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 100/2 - 30 / 2 +  self.currentPages * 100, kNavigationBarHeight - 2 , 30, 2);
    }];
}

#pragma mark -   进入当前的选定页面
- (void)gotoCurrentPage{
//    [_scroll scrollRectToVisible:CGRectMake(self.currentPages * SCREEN_WIDTH, kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) animated:YES];
    
//    NSInteger page = (self.pageControl.currentPage + 1) % _scroll.subviews.count;
    // 计算偏移量，索引值和scrollView宽度的积
         CGPoint offset = CGPointMake(self.currentPages * _scroll.frame.size.width, 0);
         // 设置新的偏移量
         [_scroll setContentOffset:offset animated:YES];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    //设置选中button的样式
    [self setupSelectBtn];
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
