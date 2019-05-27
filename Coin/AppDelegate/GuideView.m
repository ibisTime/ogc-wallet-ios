//
//  GuideView.m
//  Welcome
//
//  Created by iOSCoderZhao on 2017/9/11.
//  Copyright © 2017年 iOSCoderZhao. All rights reserved.
//

#import "GuideView.h"
#import "UIImage+GIF.h"
#import "AppColorMacro.h"
#import "TLUserLoginVC.h"
//#import "MainViewController.h"
#define K_Screen_width [UIScreen mainScreen].bounds.size.width
#define K_Screen_height [UIScreen mainScreen].bounds.size.height


@interface GuideView ()<UIScrollViewDelegate>

/**
 滚动视图
 */
@property (nonatomic,strong)UIScrollView *imageScrollView;
/**
 圆点
 */
@property (nonatomic,strong) UIPageControl *pageControl;

/**
 跳过按钮
 */
@property (nonatomic,strong)UIButton *cancelButton;

/**
 跟控制器
 */
@property (nonatomic,strong)UIViewController *rootController;

@end

@implementation GuideView

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    img.image = kImage(@"1080.png");
    [self.view addSubview:img];
    
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"630047";
    http1.parameters[SYS_KEY] = @"qiniu_domain";
    [http1 postWithSuccess:^(id responseObject) {
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"http://%@", responseObject[@"data"][@"cvalue"]] forKey:Get_Seven_Cattle_Address];
        
        [AppConfig config].qiniuDomain = [NSString stringWithFormat:@"http://%@", responseObject[@"data"][@"cvalue"]];
        
    
    TLNetworking *http = [TLNetworking new];
    http.isUploadToken = NO;
    http.code = @"630506";
    http.parameters[@"location"] = @"app_guide";
    [TLProgressHUD dismiss];
    [http postWithSuccess:^(id responseObject) {
    
        [TLProgressHUD dismiss];
        
        NSArray *dataArray = responseObject[@"data"];
        
        if (dataArray.count == 0) {
            [self cancelButtonAction];
        }
        
        NSMutableArray *picAry = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i ++) {
            [picAry addObject:[dataArray[i][@"pic"] convertImageUrl]];
        }
        self.imageArray = picAry;
        [self createScrollView];
        [self createPageControl];
        [self createCancelButton];
        
        // 加载完毕开始倒计时
        [self startTimer];
        
    } failure:^(NSError *error) {
        [TLProgressHUD dismiss];
        [self cancelButtonAction];
    }];
        
    } failure:^(NSError *error) {
        [TLProgressHUD dismiss];
        [self cancelButtonAction];
    }];
    
}

- (void)createScrollView
{
    _imageScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _imageScrollView.delegate = self;
    _imageScrollView.bounces = YES;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.showsVerticalScrollIndicator = NO;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.backgroundColor = [UIColor whiteColor];
    _imageScrollView.contentSize = CGSizeMake(K_Screen_width *self.imageArray.count, K_Screen_height);
    [self.view addSubview:_imageScrollView];
    
    
    
//    TLNetworking *http = [TLNetworking new];
//    http.isUploadToken = NO;
//    http.code = @"630506";
//    http.parameters[@"location"] = @"app_guide";
//
//    [http postWithSuccess:^(id responseObject) {
    
        //        self.bannerRoom = [[BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //                           ]
        
    
    
        
        
        for (int i = 0; i < self.imageArray.count; i++) {
            NSString *imageName = self.imageArray[i];
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.userInteractionEnabled = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.frame = CGRectMake(K_Screen_width * i, 0, K_Screen_width, K_Screen_height);
            [_imageScrollView addSubview:imageView];
            // 判断是否为gif
            if ( [imageName.pathExtension.lowercaseString isEqualToString:@"gif"]) {
                // sd_animatedGIFNamed 不能带.gif 后缀否则只能加载第一张
                // 过滤掉 .gif
                NSString *tureName = [imageName substringToIndex:imageName.length - 4];
                imageView.image = [UIImage sd_animatedGIFNamed:tureName];
            }else{
                //            imageView.image = [UIImage imageNamed:imageName];
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
            }
        }
        
    
    
    
    UIButton *experienceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [experienceBtn setTitle:@"立即体验" forState:(UIControlStateNormal)];
    experienceBtn.frame = CGRectMake(kScreenWidth * 3 + kScreenWidth/2 - 86.5 ,kScreenHeight - kTabBarHeight + 50 - 44 - 20 , 173, 44);
    experienceBtn.titleLabel.font = Font(22);
    experienceBtn.backgroundColor = RGB(220, 90, 70);
    kViewRadius(experienceBtn, 22);
    [experienceBtn addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_imageScrollView addSubview:experienceBtn];
}

- (void)createPageControl
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight - kTabBarHeight + 50 - 44 - 20 + 7, K_Screen_width, 30)];
    _pageControl.hidden = _pageControlShow;
    _pageControl.pageIndicatorTintColor = _pageIndicatorColor;
    _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorColor;
    _pageControl.numberOfPages = self.imageArray.count;
    [self.view addSubview:_pageControl];
}

- (void)createCancelButton
{
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.layer.cornerRadius = 2;
    _cancelButton.hidden = _cancelButtonShow;
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    _cancelButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _cancelButton.frame = CGRectMake(K_Screen_width - 70, kNavigationBarHeight - 44 + 11, 60, 20);
    [_cancelButton setTitle:@"跳过" forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
}

- (void)startTimer
{
    __block NSInteger second = 10;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                [_cancelButton setTitle:[NSString stringWithFormat:@"跳过%ds",second] forState:UIControlStateNormal];
                second--;
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                [_cancelButton setTitle:@"跳过" forState:UIControlStateNormal];
                [self cancelButtonAction];
            }
        });
    });
    //启动源
    dispatch_resume(timer);
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
}

- (void)setCancelButtonShow:(BOOL)cancelButtonShow
{
    _cancelButtonShow = cancelButtonShow;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // pageControl 与 scrollView 联动
    CGFloat offsetWidth = scrollView.contentOffset.x;
    int pageNum = offsetWidth / [[UIScreen mainScreen] bounds].size.width;
    self.pageControl.currentPage = pageNum;
    if (scrollView.contentOffset.x > kScreenWidth * 2) {
        _pageControl.hidden = YES;
    }else
    {
        _pageControl.hidden = NO;
    }
}

- (void)showGuideViewWithImageArray:(NSArray *)imageArray WindowRootController:(UIViewController *)rootController
{
    _imageArray = imageArray;
    _rootController = rootController;
}

- (void)cancelButtonAction
{
    if ([TLUser user].isLogin == NO) {
        TLUserLoginVC *updateVC = [[TLUserLoginVC alloc] init];
        TLNavigationController *na = [[TLNavigationController alloc] initWithRootViewController:updateVC];
        
        self.view.window.rootViewController = na;
    }else{
        TLUpdateVC *tabBarCtrl = [[TLUpdateVC alloc] init];
        
        self.view.window.rootViewController = tabBarCtrl;
    }
//    self.view.window.rootViewController = _rootController;
}
@end
