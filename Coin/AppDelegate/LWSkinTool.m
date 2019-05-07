//
//  LWSkinTool.m
//  简单换肤
//
//  Created by 枫林晚 on 16/3/26.
//  Copyright © 2016年 枫林晚. All rights reserved.
//

#import "LWSkinTool.h"


/**
 *  皮肤名称
 */
static NSString * LWSkinName;
/**
 *  对应皮肤的颜色 组织方式 name:UIcolor对象
 */
static NSMutableDictionary *LWSkinColors;
/**
 *  保存皮肤主题偏好设置的主题
 */
NSString *const LWSkinNameKey = @"LWSkinNameKey";
/** 文字在plist中对应的key */
NSString *const LWBackgroudColor = @"backgroudColor";
NSString *const LWTitleColor = @"titleColor";

NSString *const LWSkinDidChangeFrameNotification = @"SkinDidChange";

@implementation LWSkinTool

+ (void)load
{
    //1. 读取偏好设置中的皮肤名称
    LWSkinName = [[NSUserDefaults standardUserDefaults] objectForKey:LWSkinNameKey];
    if (LWSkinName == nil) {
        LWSkinName = @"Theme1";
    }
    
    //初始化颜色缓存
    LWSkinColors = @{}.mutableCopy;
    
    //加载皮肤颜色
    [self loadSkinColor];
}

/**
 *  取图片
 */
+ (UIImage *)imageName:(NSString *)name
{
    
    //拼接图片名称
    NSString *skinImagePath = [NSString stringWithFormat:@"Theme/%@/untitled folder/%@",LWSkinName,name];
    

    return [UIImage imageNamed:skinImagePath];
}

+ (UIColor *)colorWithName:(NSString *)colorName
{
    return LWSkinColors[colorName];
}


/**
 *  设置皮肤类型
 */
+ (void) setSkinName:(NSString *)skinName
{
    if (skinName != nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:skinName forKey:LWSkinNameKey];
        LWSkinName = skinName;
        
        //每次更换皮肤颜色都要重新加载颜色缓存
        [self loadSkinColor];
        
        //发出皮肤改变的额通知  让没有销毁的控制器重新加载皮肤
        [[NSNotificationCenter defaultCenter] postNotificationName:LWSkinDidChangeFrameNotification object:nil];
    }
}


#pragma mark - ********* 私有方法 *********
+ (void)loadSkinColor
{
    //1. 读取plist
    NSString *colorPlistName = [NSString stringWithFormat:@"Theme/%@/homepage/color.plist",LWSkinName];
    
    NSString *colorPlistPath = [[NSBundle mainBundle] pathForResource:colorPlistName ofType:nil];
    
    //颜色字典
    NSDictionary *colorDict = [NSDictionary dictionaryWithContentsOfFile:colorPlistPath];
    
    //遍历
    [colorDict enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString* rgbaStr, BOOL * _Nonnull stop) {
        //解串   拆解RGBA
        
        //去空格
//        rgbaStr = [rgbaStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//        //截取RGBA
//        NSArray *rgbaStrs = [rgbaStr componentsSeparatedByString:@","];
//
//        //转换
//        CGFloat r = [rgbaStrs[0] doubleValue] / 255.0;
//        CGFloat g = [rgbaStrs[1] doubleValue] / 255.0;
//        CGFloat b = [rgbaStrs[2] doubleValue] / 255.0;
//        CGFloat a = [rgbaStrs[3] doubleValue];
        
        //根据rgba得到颜色
        UIColor *color = kHexColor(rgbaStr);
        
        //把转换后的rgba存入缓存
        [LWSkinColors setObject:color forKey:key];
    }];
}


@end
