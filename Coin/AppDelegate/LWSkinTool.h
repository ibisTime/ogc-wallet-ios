//
//  LWSkinTool.h
//  简单换肤
//
//  Created by 枫林晚 on 16/3/26.
//  Copyright © 2016年 枫林晚. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LWSkinTool : NSObject

/**
 *  获取图片
 */
+ (UIImage *)imageName:(NSString *)name;


/**
 *  设置颜色的方法
 */
+ (UIColor *)colorWithName:(NSString *)colorName;

/**
 *  设置皮肤主题   一般在设置皮肤主题的时候调用
 */
+ (void) setSkinName:(NSString *)skinName;


@end

//通知
UIKIT_EXTERN NSString *const LWSkinDidChangeFrameNotification;

UIKIT_EXTERN NSString *const LWBackgroudColor;
UIKIT_EXTERN NSString *const LWTitleColor;
