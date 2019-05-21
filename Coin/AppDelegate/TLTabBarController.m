//
//  ZHTabBarController.m
//  ZHCustomer
//
//  Created by  tianlei on 2016/12/23.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLTabBarController.h"

#import "TLUserLoginVC.h"
#import "LangSwitcher.h"
#import "UIColor+theme.h"
#import "AppConfig.h"
#import "AppColorMacro.h"
#import "NSBundle+Language.h"
#import "InvestmentVC.h"
@interface TLTabBarController ()<UITabBarControllerDelegate>
{
    UIView *view;
}
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation TLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    view = [[UIView alloc]init];
    [view theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, kNavigationBarHeight);
    [[UITabBar appearance]insertSubview:view atIndex:0] ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"TABBAR" object:nil];
}


- (void)InfoNotificationAction:(NSNotification *)notification
{
    NSLog(@"%@",notification.object);
//    self.dataArray = notification.userInfo[@"data"];
    NSArray *dataArray = notification.object[@"data"][@"data"];
    NSMutableArray *titleArray = [NSMutableArray array];
    NSMutableArray *VCNamesArray = [NSMutableArray array];
    NSMutableArray *imageNamesArray = [NSMutableArray array];
    NSMutableArray *selectedImageNames = [NSMutableArray array];
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:dataArray];
    
    if (dataArray.count > 0) {
    
//    NSArray *array = @[@"首页",@"DAPP",@"行情",@"快讯",@"我的"];
    
        self.delegate = self;
        for (int i = 0; i < dataArray.count; i ++) {

            if ([dataArray[i][@"name"] isEqualToString:@"首页"]) {
                [VCNamesArray addObject:@"TLWalletVC"];
                [titleArray addObject:@"首页"];
                [imageNamesArray addObject:@"首页-未点击"];
                [selectedImageNames addObject:@"首页-点击"];
                [self addChildVCWithTitle:titleArray[i]
                               controller:VCNamesArray[i]
                              normalImage:imageNamesArray[i]
                            selectedImage:selectedImageNames[i]];
            }

            if ([dataArray[i][@"name"] isEqualToString:@"DAPP"]) {
                [VCNamesArray addObject:@"HomeVC"];
                [titleArray addObject:@"应用"];
                [imageNamesArray addObject:@"DAPP-未点击"];
                [selectedImageNames addObject:@"DAPP-点击"];
                [self addChildVCWithTitle:titleArray[i]
                               controller:VCNamesArray[i]
                              normalImage:imageNamesArray[i]
                            selectedImage:selectedImageNames[i]];
            }

            if ([dataArray[i][@"name"] isEqualToString:@"行情"]) {
                [VCNamesArray addObject:@"MarketVC"];
                [imageNamesArray addObject:@"行情-未点击"];
                [selectedImageNames addObject:@"行情-点击"];
                [titleArray addObject:@"行情"];

                [self addChildVCWithTitle:titleArray[i]
                               controller:VCNamesArray[i]
                              normalImage:imageNamesArray[i]
                            selectedImage:selectedImageNames[i]];
            }
            if ([dataArray[i][@"name"] isEqualToString:@"快讯"]) {
                [VCNamesArray addObject:@"AlertsVC"];
                [imageNamesArray addObject:@"快讯-未点击"];
                [selectedImageNames addObject:@"快讯-点击"];
                [titleArray addObject:@"快讯"];
                [self addChildVCWithTitle:titleArray[i]
                               controller:VCNamesArray[i]
                              normalImage:imageNamesArray[i]
                            selectedImage:selectedImageNames[i]];
            }
            if ([dataArray[i][@"name"] isEqualToString:@"我的"]) {
                [VCNamesArray addObject:@"TLMineVC"];
                [imageNamesArray addObject:@"我的-未点击"];
                [selectedImageNames addObject:@"我的-点击"];
                [titleArray addObject:@"我的"];
                [self addChildVCWithTitle:titleArray[i]
                               controller:VCNamesArray[i]
                              normalImage:imageNamesArray[i]
                            selectedImage:selectedImageNames[i]];
            }
            
            if ([dataArray[i][@"name"] isEqualToString:@"交易"]) {
                [VCNamesArray addObject:@"InvestMentAllVC"];
                [imageNamesArray addObject:@"交易-未点击"];
                [selectedImageNames addObject:@"交易-点击"];
                [titleArray addObject:@"交易"];
                [self addChildVCWithTitle:titleArray[i]
                               controller:VCNamesArray[i]
                              normalImage:imageNamesArray[i]
                            selectedImage:selectedImageNames[i]];
            }
            
        }
    }
    
    
    UIView *tabBarBgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    tabBarBgView.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
}


- (UIImage *)changImageColorWithImage:(UIImage *)image  color:(UIColor *)targetColor blendModel:(CGBlendMode)mode
{
    //获取画布
    UIGraphicsBeginImageContext(image.size);
    //画笔沾取颜色
    [targetColor setFill];
    
    CGRect drawRect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(drawRect);
    [image drawInRect:drawRect blendMode:mode alpha:1];
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



- (void)addChildVCWithTitle:(NSString *)title
                 controller:(NSString *)controllerName
                normalImage:(NSString *)normalImageName
              selectedImage:(NSString *)selectedImageName
{
    Class vcClass = NSClassFromString(controllerName);
    UIViewController *vc = [[vcClass alloc] init];
    //    vc.title = title;
    
    //获得原始图片
    UIImage *normalImage = [self getOrgImage:[UIImage imageNamed:normalImageName]];
    UIImage *selectedImage = [self getOrgImage:[UIImage imageNamed:selectedImageName]];
    
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:normalImage
                                                     selectedImage:selectedImage];
    
    //title颜色
    [tabBarItem setTitleTextAttributes:@{
                                         NSForegroundColorAttributeName : kTabbarColor
                                         } forState:UIControlStateSelected];
    [tabBarItem setTitleTextAttributes:@{
                                         NSForegroundColorAttributeName : kTextColor
                                         } forState:UIControlStateNormal];
    vc.tabBarItem = tabBarItem;
    TLNavigationController *navigationController = [[TLNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navigationController];
    
}

- (UIImage *)getOrgImage:(UIImage *)image {
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

#pragma mark 判断是否登录若没登录跳转到登录页面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController {
    
    //赋值更改前的index
    self.currentIndex = tabBarController.selectedIndex;
    return YES;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    CoinWeakSelf;
    
    NSInteger idx = tabBarController.selectedIndex;
    
    
    
    
    
    if ([AppConfig config].isUploadCheck) {
        
//        //判断点击的Controller是不是需要登录，如果是，那就登录
        if((idx == 0) && ![TLUser user].isLogin) {

            TLUserLoginVC *loginVC = [TLUserLoginVC new];

            loginVC.loginSuccess = ^{

                weakSelf.selectedIndex = idx;

            };

            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            self.selectedIndex = idx;
            
        }
        
    } else {
        
        
        if((idx == 0) && ![TLUser user].isLogin) {
            
            TLUserLoginVC *loginVC = [TLUserLoginVC new];
            
            loginVC.loginSuccess = ^{
                
                weakSelf.selectedIndex = idx;
                
            };
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            self.selectedIndex = idx;
            
        }
            
//        }
        
    }
    
}

@end
