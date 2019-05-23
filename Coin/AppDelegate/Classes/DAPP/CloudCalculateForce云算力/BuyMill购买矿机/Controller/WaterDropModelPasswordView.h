//
//  WaterDropModelPasswordView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/23.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WaterDropModelPasswordView;

@protocol HBAlertPasswordViewDelegate <NSObject>

/**
 确定按钮的执行方法
 */
- (void)sureActionWithAlertPasswordView:(WaterDropModelPasswordView *)alertPasswordView password:(NSString *)password;




@end

@interface WaterDropModelPasswordView : UIView

/** 协议 */
@property (nonatomic, assign) id<HBAlertPasswordViewDelegate> delegate;

@property (nonatomic , strong)UILabel *priceLabel;

@property (nonatomic , strong)UIButton *forgotPassword;

-(void)clearUpPassword;


@end

NS_ASSUME_NONNULL_END
