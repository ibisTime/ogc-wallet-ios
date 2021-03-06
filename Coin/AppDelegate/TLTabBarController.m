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

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation TLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CoinWeakSelf;
//    NSMutableArray *titleArray = [NSMutableArray array];
//    NSMutableArray *VCNamesArray = [NSMutableArray array];
//    NSMutableArray *imageNamesArray = [NSMutableArray array];
//    NSMutableArray *selectedImageNames = [NSMutableArray array];
//    if (self.dataArray.count > 0) {
//        NSArray *dataArray = self.dataArray;
//        self.delegate = self;
//        for (int i = 0; i < dataArray.count; i ++) {
//            [titleArray addObject:dataArray[i][@"name"]];
//            if ([dataArray[i][@"name"] isEqualToString:@"投资"]) {
//                [VCNamesArray addObject:@"PosMiningVC"];
//            }
//            if ([dataArray[i][@"name"] isEqualToString:@"交易"]) {
//                [VCNamesArray addObject:@"InvestMentAllVC"];
//            }
//            if ([dataArray[i][@"name"] isEqualToString:@"资产"]) {
//                [VCNamesArray addObject:@"TLWalletVC"];
//            }
//            if ([dataArray[i][@"name"] isEqualToString:@"我的"]) {
//                [VCNamesArray addObject:@"TLMineVC"];
//            }
//            [imageNamesArray addObject:[dataArray[i][@"pic"] convertImageUrl]];
//            [selectedImageNames addObject:[dataArray[i][@"enPic"] convertImageUrl]];
//        }
//        for (int i = 0; i < titleArray.count; i++) {
//            if (i == 0 && [AppConfig config].isUploadCheck) {
//                continue;
//            }
//            [self addChildVCWithTitle:titleArray[i]
//                           controller:VCNamesArray[i]
//                          normalImage:imageNamesArray[i]
//                        selectedImage:selectedImageNames[i]];
//        }
//
//        UIView *tabBarBgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
//        tabBarBgView.backgroundColor = [UIColor whiteColor];
//        //        //判断点击的Controller是不是需要登录，如果是，那就登录
//
//        self.tabBar.backgroundColor = [UIColor whiteColor];
//    }else
//    {
//
//
//          CoinWeakSelf;
//
////        [self.navigationController pushViewController:tab animated:YES];
////        self.delegate = self;
////        for (int i = 0; i < dataArray.count; i ++) {
////            [titleArray addObject:dataArray[i][@"name"]];
////            if ([dataArray[i][@"name"] isEqualToString:@"投资"]) {
////                [VCNamesArray addObject:@"PosMiningVC"];
////            }
////            if ([dataArray[i][@"name"] isEqualToString:@"交易"]) {
////                [VCNamesArray addObject:@"InvestMentAllVC"];
////            }
////            if ([dataArray[i][@"name"] isEqualToString:@"资产"]) {
////                [VCNamesArray addObject:@"TLWalletVC"];
////            }
////            if ([dataArray[i][@"name"] isEqualToString:@"我的"]) {
////                [VCNamesArray addObject:@"TLMineVC"];
////            }
////
////            [imageNamesArray addObject:[dataArray[i][@"pic"] convertImageUrl]];
////            [selectedImageNames addObject:[dataArray[i][@"enPic"] convertImageUrl]];
////        }
////
////        for (int i = 0; i < titleArray.count; i++) {
////
////            if (i == 0 && [AppConfig config].isUploadCheck) {
////
////                continue;
////            }
////
////
////            [self addChildVCWithTitle:titleArray[i]
////                    controller:VCNamesArray[i]
////                    normalImage:imageNamesArray[i]
////                    selectedImage:selectedImageNames[i]];
////        }
////
////        UIView *tabBarBgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
////        tabBarBgView.backgroundColor = [UIColor whiteColor];
////        //        //判断点击的Controller是不是需要登录，如果是，那就登录
////
////        self.tabBar.backgroundColor = [UIColor whiteColor];
//
//
//
//    }

//    self.delegate = self;
//
//    NSArray *titles = @[
//                        [LangSwitcher switchLang:@"投资" key:nil],
//                        [LangSwitcher switchLang:@"交易" key:nil],
//                        [LangSwitcher switchLang:@"资产" key:nil],
//                        [LangSwitcher switchLang:@"我的" key:nil]
//                        ];
//    NSArray *VCNames = @[@"PosMiningVC",@"InvestMentAllVC",@"TLWalletVC", @"TLMineVC"];
//
//    NSArray *imageNames = @[@"投资（未选中）", @"交易（未选中）", @"钱包（未选中）",@"我的（未选中）"];
//    NSArray *selectedImageNames = @[@"投资（选中）",@"交易（选中）",  @"钱包（选中）",@"我的（选中）"];
//
//    for (int i = 0; i < imageNames.count; i++) {
//
//        if (i == 0 && [AppConfig config].isUploadCheck) {
//
//            continue;
//        }
//
//        [self addChildVCWithTitle:titles[i]
//                       controller:VCNames[i]
//                      normalImage:imageNames[i]
//                    selectedImage:selectedImageNames[i]];
//    }
//
////    self.selectedIndex =[AppConfig config].isUploadCheck ? 1 : 2;
//
//    //
//    UIView *tabBarBgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
//    tabBarBgView.backgroundColor = [UIColor whiteColor];
//    //        //判断点击的Controller是不是需要登录，如果是，那就登录
//
//    self.tabBar.backgroundColor = [UIColor whiteColor];
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
//    if (self.dataArray.count > 0) {
    
        
        
        self.delegate = self;
        for (int i = 0; i < dataArray.count; i ++) {
            
            if ([dataArray[i][@"name"] isEqualToString:@"应用"]) {
                [VCNamesArray addObject:@"HomeVC"];
                [titleArray addObject:@"应用"];
                [imageNamesArray addObject:@"应用（未选中）"];
                [selectedImageNames addObject:@"应用（选中）"];
            }
            
            if ([dataArray[i][@"name"] isEqualToString:@"投资"]) {
                [VCNamesArray addObject:@"PosMiningVC"];
                [titleArray addObject:@"投资"];
                [imageNamesArray addObject:@"投资（未选中）"];
                [selectedImageNames addObject:@"投资（选中）"];
            }
            
            if ([dataArray[i][@"name"] isEqualToString:@"交易"]) {
                [VCNamesArray addObject:@"InvestMentAllVC"];
                [imageNamesArray addObject:@"交易（未选中）"];
                [selectedImageNames addObject:@"交易（选中）"];
                [titleArray addObject:@"交易"];
            }
            if ([dataArray[i][@"name"] isEqualToString:@"资产"]) {
                [VCNamesArray addObject:@"TLWalletVC"];
                [imageNamesArray addObject:@"钱包（未选中）"];
                [selectedImageNames addObject:@"钱包（选中）"];
                [titleArray addObject:@"资产"];
            }
            if ([dataArray[i][@"name"] isEqualToString:@"我的"]) {
                [VCNamesArray addObject:@"TLMineVC"];
                [imageNamesArray addObject:@"我的（未选中）"];
                [selectedImageNames addObject:@"我的（选中）"];
                [titleArray addObject:@"我的"];
            }
            [self addChildVCWithTitle:titleArray[i]
                           controller:VCNamesArray[i]
                          normalImage:imageNamesArray[i]
                        selectedImage:selectedImageNames[i]];
        }
//        for (int i = 0; i < titleArray.count; i++) {
////            if (i == 0 && [AppConfig config].isUploadCheck) {
////                continue;
////            }
//
//
//        }
    
        UIView *tabBarBgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
        tabBarBgView.backgroundColor = [UIColor whiteColor];
        //        //判断点击的Controller是不是需要登录，如果是，那就登录
        
        self.tabBar.backgroundColor = [UIColor whiteColor];
//    }
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
    //    tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    //    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 100);
    
    //title颜色
    [tabBarItem setTitleTextAttributes:@{
                                         NSForegroundColorAttributeName : [UIColor textColor]
                                         } forState:UIControlStateSelected];
    [tabBarItem setTitleTextAttributes:@{
                                         NSForegroundColorAttributeName : [UIColor textColor]
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

#pragma mark - IM
//- (void)pushToChatViewControllerWith:(IMAUser *)user
//{
//    NavigationViewController *curNav = (NavigationViewController *)[[self viewControllers] objectAtIndex:self.selectedIndex];
//    if (self.selectedIndex == 2)
//    {
//        // 选的中会话tab
//        // 先检查当前栈中是否聊天界面
//        NSArray *array = [curNav viewControllers];
//        for (UIViewController *vc in array)
//        {
//            if ([vc isKindOfClass:[IMAChatViewController class]])
//            {
//                // 有则返回到该界面
//                IMAChatViewController *chat = (IMAChatViewController *)vc;
//                [chat configWithUser:user];
//                //                chat.hidesBottomBarWhenPushed = YES;
//                [curNav popToViewController:chat animated:YES];
//                return;
//            }
//        }
////#if kTestChatAttachment
////        // 无则重新创建
////        ChatViewController *vc = [[CustomChatUIViewController alloc] initWith:user];
////#else
//        ChatViewController *vc = [[IMAChatViewController alloc] initWith:user];
////#endif
//        
//        if ([user isC2CType])
//        {
//            TIMConversation *imconv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:user.userId];
//            if ([imconv getUnReadMessageNum] > 0)
//            {
//                [vc modifySendInputStatus:SendInputStatus_Send];
//            }
//        }
//        
//        vc.hidesBottomBarWhenPushed = YES;
//        [curNav pushViewController:vc withBackTitle:@"返回" animated:YES];
//    }
//    else
//    {
//        NavigationViewController *chatNav = (NavigationViewController *)[[self viewControllers] objectAtIndex:0];
//        
////#if kTestChatAttachment
////        // 无则重新创建
////        ChatViewController *vc = [[CustomChatUIViewController alloc] initWith:user];
////#else
//        ChatViewController *vc = [[IMAChatViewController alloc] initWith:user];
////#endif
//        vc.hidesBottomBarWhenPushed = YES;
//        [chatNav pushViewController:vc withBackTitle:@"返回" animated:YES];
//        
//        [self setSelectedIndex:2];
//        self.currentIndex = 2;
//        
//        if (curNav.viewControllers.count != 2)
//        {
//            [curNav popToRootViewControllerAnimated:YES];
//        }
//        
//    }
//}
@end
