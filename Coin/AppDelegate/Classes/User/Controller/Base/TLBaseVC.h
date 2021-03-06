//
//  TLBaseVC.h
//  WeRide
//
//  Created by  tianlei on 2016/11/25.
//  Copyright © 2016年 trek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLUser.h"
#import "TLDataBase.h"
#import "TLNavigationController.h"
#import "TLWXManager.h"
#import "TLWBManger.h"
@interface TLBaseVC : UIViewController

@property (nonatomic,strong) UIView *tl_placeholderView;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic , strong)UILabel *titleText;

@property (nonatomic , strong)UIButton *LeftBackbButton;

@property (nonatomic , strong)UIButton *RightButton;

- (void)tl_placeholderOperation;



//导航栏设为透明
-(void)navigationTransparentClearColor;
//导航栏设为默认
-(void)navigationSetDefault;
//导航栏设为白色
-(void)navigationwhiteColor;



- (void)removePlaceholderView; //移除
- (void)addPlaceholderView; // 添加
//更新placeholderView
- (void)setPlaceholderViewTitle:(NSString *)title  operationTitle:(NSString *)optitle;

@end
