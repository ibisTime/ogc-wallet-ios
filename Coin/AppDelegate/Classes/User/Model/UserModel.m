//
//  UserModel.m
//  Coin
//
//  Created by 郑勤宝 on 2018/11/6.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (instancetype)user {
    
    static UserModel *user = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        user = [[UserModel alloc] init];
        
    });
    
    return user;
}

//设置行间距
+(NSMutableAttributedString *)ReturnsTheDistanceBetween:(NSString *)str
{
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置为30
    [paragraphStyle  setLineSpacing:8];
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:str];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    return setString;
}

-(void)phoneCode:(UIButton *)sender
{
    __block NSInteger time = 59;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [sender setTitle:[LangSwitcher switchLang:@"重新发送" key:nil] forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                kViewBorderRadius(sender, 2, 1, kTabbarColor);
                [sender setTitleColor:kTabbarColor forState:(UIControlStateNormal)];
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [sender setTitle:[NSString stringWithFormat:@"%@(%.2d)",[LangSwitcher switchLang:@"重新发送" key:nil], seconds] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                [sender setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                kViewBorderRadius(sender, 2, 1, [UIColor grayColor]);
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)showPopAnimationWithAnimationStyle:(NSInteger)style showView:(UIView *)showView
{
    ZJAnimationPopStyle popStyle = (style == 8) ? ZJAnimationPopStyleCardDropFromLeft : (ZJAnimationPopStyle)style;
    ZJAnimationDismissStyle dismissStyle = (ZJAnimationDismissStyle)style;
    // 1.初始化
    ZJAnimationPopView *_popView = [[ZJAnimationPopView alloc] initWithCustomView:showView popStyle:popStyle dismissStyle:dismissStyle];
    self.cusPopView = _popView;
    _popView.isClickBGDismiss = ![showView isKindOfClass:[UIView class]];
    //    移除
    _popView.isClickBGDismiss = YES;
    // 2.2 显示时背景的透明度
    _popView.popBGAlpha = 0.5f;
    
    // 2.3 显示时是否监听屏幕旋转
    _popView.isObserverOrientationChange = YES;
    // 2.6 显示完成回调
    _popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    _popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };
    // 4.显示弹框
    [_popView pop];
}



- (void)showPopAnimationWithAnimationStyle1:(NSInteger)style showView:(UIView *)showView
{
    ZJAnimationPopStyle popStyle = (style == 8) ? ZJAnimationPopStyleCardDropFromLeft : (ZJAnimationPopStyle)style;
    ZJAnimationDismissStyle dismissStyle = (ZJAnimationDismissStyle)style;
    // 1.初始化
    ZJAnimationPopView *_popView = [[ZJAnimationPopView alloc] initWithCustomView:showView popStyle:popStyle dismissStyle:dismissStyle];
    self.cusPopView = _popView;
    _popView.isClickBGDismiss = ![showView isKindOfClass:[UIView class]];
    //    移除
    _popView.isClickBGDismiss = YES;
    // 2.2 显示时背景的透明度
    _popView.popBGAlpha = 0;
    
    // 2.3 显示时是否监听屏幕旋转
    _popView.isObserverOrientationChange = YES;
    _popView.popAnimationDuration = 0.5;
    // 2.6 显示完成回调
    _popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    _popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };
    // 4.显示弹框
    [_popView pop];
}

@end
