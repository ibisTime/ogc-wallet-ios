//
//  SmoothChartView1.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmoothChartView1 : UIView
/*
 * X 轴的刻度数字
 */
@property (nonatomic,strong)NSArray *arrX;

/*
 * Y 轴的刻度数字
 */
@property (nonatomic,strong)NSArray *arrY;

/*
 * 刷新数据 重新开始动画
 */
-(void)refreshChartAnmition;

/* 根据数据源画图
 *  pathX :横坐标数据
 *
 *  pathY :纵坐标数据源
 *  X:X轴需要切割的份数
 */
-(void)drawSmoothViewWithArrayX:(NSArray*)pathX andArrayY:(NSArray*)pathY andScaleX:(float)X andScalemax:(float)max andScalemin:(float)min;
@end

NS_ASSUME_NONNULL_END
