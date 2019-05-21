//
//  TLBaseVC.m
//  WeRide
//
//  Created by  tianlei on 2016/11/25.
//  Copyright © 2016年 trek. All rights reserved.
//

#import "TLBaseVC.h"

#import "UIColor+theme.h"
#import "AppColorMacro.h"

@interface TLBaseVC ()<UIGestureRecognizerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation TLBaseVC {
    UILabel *_placeholderTitleLbl;
    UIButton *_opBtn;
}

-(UIButton *)LeftBackbButton
{
    if (!_LeftBackbButton) {
        _LeftBackbButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _LeftBackbButton.frame = CGRectMake(0, 0, 44, 44);
        [_LeftBackbButton setImage:kImage(@"返回") forState:(UIControlStateNormal)];
    }
    return _LeftBackbButton;
}

-(UIButton *)RightButton
{
    if (!_RightButton) {
        _RightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        _RightButton.frame = CGRectMake(0, 0, 44, 44);
        _RightButton.height = 44;
        _RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _RightButton.titleLabel.font = FONT(15);
//        [_RightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_RightButton theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
    }
    return _RightButton;
}


-(UILabel *)titleText
{
    if (!_titleText) {
        _titleText = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#333333")];
        [_titleText theme_setTextIdentifier:LabelColor moduleName:ColorName];
        _titleText.height = 44;
    }
    return _titleText;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
//    [self.navigationController.navigationBar setShadowImage:nil];


    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, kNavigationBarHeight)];
    [self.view addSubview:topView];
    self.topView = topView;

//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [self.view theme_setBackgroundColorIdentifier:BackColor moduleName:@"homepage"];]]
    [topView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    [self.view theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
//    topView.backgroundColor = kBackgroundColor;
//    topView.nightBackgroundColor = kNightBackgroundColor;
//    self.view.backgroundColor = kBackgroundColor;
//    self.view.nightBackgroundColor = kNightBackgroundColor;
    
}






- (void)viewWillAppear:(BOOL)animated
{
//    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
        
        NSString *path = [NSBundle mainBundle].bundlePath;
        path = [path stringByAppendingPathComponent:@"BlackTheme"];
        
        [MTThemeManager.manager setThemePath:path];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"white" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        
        self.navigationItem.backBarButtonItem = item;
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        [[NSUserDefaults standardUserDefaults] setObject:BLACK forKey:COLOR];
        
    }else
    {
        
        NSString *path = [NSBundle mainBundle].bundlePath;
        path = [path stringByAppendingPathComponent:@"WhiteTheme"];
        [MTThemeManager.manager setThemePath:path];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
        
        self.navigationItem.backBarButtonItem = item;
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        [[NSUserDefaults standardUserDefaults] setObject:WHITE forKey:COLOR];
        
    }
    
}
//
- (void)viewWillDisappear:(BOOL)animated
{
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
}

// 如果tableview在视图最底层 默认会偏移电池栏的高度
- (void)setViewEdgeInset {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//- (void)setTitle:(NSString *)title {
//
//    self.navigationItem.titleView = [UILabel labelWithNaTitle:title frame:CGRectMake(0, 0, 200, 44)];
////    self.titleStr = title;
//
//}
////隐藏底部横条
//- (BOOL)prefersHomeIndicatorAutoHidden {
//
//    return YES;
//}

- (void)removePlaceholderView {

    if (self.tl_placeholderView) {
        
        [self.tl_placeholderView removeFromSuperview];

    }
    
}

- (void)addPlaceholderView{

    if (self.tl_placeholderView) {
        
        [self.view addSubview:self.tl_placeholderView];
        
    }

}

- (void)setPlaceholderViewTitle:(NSString *)title  operationTitle:(NSString *)opTitle {

    if (self.tl_placeholderView) {
        
        _placeholderTitleLbl.text = title;
        [_opBtn setTitle:opTitle forState:UIControlStateNormal];
        
    } else {
    
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = self.view.backgroundColor;
        UILabel *lbl = [UILabel labelWithFrame:CGRectMake(0, 100, view.width, 50) textAligment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:15] textColor:[UIColor textColor]];
        [view addSubview:lbl];
        lbl.text = title;
        _placeholderTitleLbl = lbl;
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, lbl.yy + 10, 200, 40)];
        [self.view addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
        btn.centerX = view.width/2.0;
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor textColor].CGColor;
        [btn addTarget:self action:@selector(tl_placeholderOperation) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:opTitle forState:UIControlStateNormal];
        [view addSubview:btn];
        _opBtn = btn;
        _tl_placeholderView = view;
    
    }

}






#pragma mark- 站位操作
- (void)tl_placeholderOperation {

    if ([self isMemberOfClass:NSClassFromString(@"TLBaseVC")]) {

        NSLog(@"子类请重写该方法");

    }

}
#pragma mark - Setting

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    
//    return UIStatusBarStyleLightContent;
//    
//}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    NSLog(@"收到内存警告---%@",NSStringFromClass([self class]));
    
}

@end
