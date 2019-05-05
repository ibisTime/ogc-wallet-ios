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
        [_RightButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    return _RightButton;
}

-(UILabel *)titleText
{
    if (!_titleText) {
        _titleText = [[UILabel alloc] init];
        _titleText.textAlignment = NSTextAlignmentCenter;
        _titleText.backgroundColor = [UIColor clearColor];
        _titleText.textColor=[UIColor blackColor];
        [_titleText setFont:[UIFont systemFontOfSize:16.0]];
        _titleText.height = 44;
    }
    return _titleText;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.translucent = NO; self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回1"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回1"];
    self.navigationItem.backBarButtonItem = item;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.view theme_setBackgroundColorIdentifier:BackColor moduleName:@"homepage"];
}

-(void)navigationwhiteColor
{
    self.navigationController.navigationBar.translucent = NO; self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回1-1"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回1-1"];
    self.navigationItem.backBarButtonItem = item;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)navigationTransparentClearColor
{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回1-1"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回1-1"];
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)navigationSetDefault
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回1-1"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回1-1"];
    self.navigationController.navigationBar.barTintColor = kTabbarColor;
    self.navigationItem.backBarButtonItem = item;
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}





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
