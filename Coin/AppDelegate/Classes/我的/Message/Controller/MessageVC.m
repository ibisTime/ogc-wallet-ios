//
//  MessageVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MessageVC.h"
#import "AllMessageVC.h"
#import "AnnouncementVC.h"
#import "TodoViewController.h"
@interface MessageVC ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic, assign)NSInteger currentPages;

@property (nonatomic, strong)UILabel *WeiGreLabel;
@property (nonatomic,strong) AllMessageVC * vc1;
@property (nonatomic,strong) TodoViewController * vc2;
@property (nonatomic,strong) AnnouncementVC * vc3;
#define kPageCount 3
#define kButton_H 50
#define kMrg 10
#define kTag 1000
@end

@implementation MessageVC


- (void)viewDidLoad {

    self.titleText.text = [LangSwitcher switchLang:@"消息" key:nil];
    self.navigationItem.titleView = self.titleText;
    
    [self.view theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49 + kNavigationBarHeight, SCREEN_WIDTH, 1)];
    [lineView theme_setTintColorIdentifier:LineViewColor moduleName:ColorName];
    [self.view addSubview:lineView];
    
    self.WeiGreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/kPageCount/2 - 12, 46 + kNavigationBarHeight , 24, 3)];
    self.WeiGreLabel.backgroundColor = kTabbarColor;
    [self.view addSubview:self.WeiGreLabel];
    
    //设置可以左右滑动的ScrollView
    [self setupScrollView];
    //设置控制的每一个子控制器
    [self setupChildViewControll];
    //设置分页按钮
    [self setupPageButton];
    //选择状态
    [self setupSelectBtn];
    [_scroll setContentOffset:CGPointMake(SCREEN_WIDTH * _currentPages, 0) animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - 设置可以左右滑动的ScrollView
- (void)setupScrollView{
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kButton_H+ kNavigationBarHeight , SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    self.scroll.backgroundColor = [UIColor redColor];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.bounces = NO;
    //    _scroll.backgroundColor = [UIColor redColor];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.directionalLockEnabled = YES;
    
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * kPageCount, 0);
    [self.view addSubview:_scroll];
}

#pragma mark - 设置控制的每一个子控制器
- (void)setupChildViewControll{
    self.vc1 = [[AllMessageVC alloc]init];
    self.vc2 = [[TodoViewController alloc]init];
    self.vc3 = [[AnnouncementVC alloc]init];
    
    //指定该控制器为其子控制器
    [self addChildViewController:_vc1];
    [self addChildViewController:_vc2];
    [self addChildViewController:_vc3];
    
    
    //将视图加入ScrollView上
    [_scroll addSubview:_vc1.view];
    [_scroll addSubview:_vc2.view];
    [_scroll addSubview:_vc3.view];
    
    //设置两个控制器的尺寸
    _vc1.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc2.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc3.view.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
}
#pragma mark - 设置分页按钮
- (void)setupPageButton{
    //button的index值应当从0开始
    
    UIButton *btn = [self setupButtonWithTitle:@"全部" Index:0];
    [self setupButtonWithTitle:@"待办事项" Index:1];
    [self setupButtonWithTitle:@"系统公告" Index:2];
//    [self setupButtonWithTitle:@"系统公告" Index:2];
    
    [btn setTitleColor:kTabbarColor forState:(UIControlStateNormal)];
    self.selectBtn = btn;
}
- (UIButton *)setupButtonWithTitle:(NSString *)title Index:(NSInteger)index{
    CGFloat y =  kNavigationBarHeight;
    
    CGFloat w = SCREEN_WIDTH / kPageCount;
    CGFloat h = kButton_H ;
    CGFloat x = index * w;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(x, y, w, h);
    btn.titleLabel.font = HGboldfont(15);
    btn.tag = index + kTag;
    [btn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    [btn addTarget:self action:@selector(pageClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    return btn;
}

#pragma mark -- 按钮点击方法
- (void)pageClick:(UIButton *)btn
{
    self.currentPages = btn.tag - kTag;
    [self gotoCurrentPage];
    [self setupSelectBtn];
}
#pragma mark - 设置选中button的样式
- (void)setupSelectBtn{
    UIButton *btn = [self.view viewWithTag:self.currentPages + kTag];
    if ([self.selectBtn isEqual:btn]) {
        return;
    }
    [self.selectBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    self.selectBtn = btn;
    [btn setTitleColor:kTabbarColor forState:(UIControlStateNormal)];
    
    [UIView animateWithDuration:0.3 animations:^{
        _WeiGreLabel.frame = CGRectMake((self.currentPages + 1)*SCREEN_WIDTH/kPageCount - SCREEN_WIDTH/kPageCount/2 - 15, 46 + kNavigationBarHeight, 30, 3);
    }];
}

#pragma mark -   进入当前的选定页面
- (void)gotoCurrentPage{
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * self.currentPages;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    //设置选中button的样式
    [self setupSelectBtn];
}


@end
