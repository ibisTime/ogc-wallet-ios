//
//  SmoothChartView.m
//  AseanData
//
//  Created by 陈小明 on 2017/4/24.
//  Copyright © 2017年 wanshenglong. All rights reserved.
//平滑的曲线

#import "SmoothChartView.h"
#import "UIBezierPath+curved.h"
#import "UIColor+Extra.h"

@interface SmoothChartView ()
{
    CAShapeLayer *anmitionLayer;
    CAGradientLayer *gradientLayer;
    NSMutableArray *_pointArr;
    
    //X轴
    CAShapeLayer *layerX;
    
    //纵坐标轴
    CAShapeLayer *layerY;
    
    CAShapeLayer *_bottomLayer;
    
}
@end
//#define  VIEW_WIDTH  self.frame.size.width //底图的宽度
//#define  VIEW_HEIGHT self.frame.size.height//底图的高度

#define  LABLE_WIDTH  self.frame.size.width //表的宽度
#define  LABLE_HEIGHT 149 //表的高度

@implementation SmoothChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        // X轴
        [self makeChartXView];
        // Y轴
        [self makeChartYView];
        // 承载曲线图的View
        [self makeBottomlayer];
        
    }
    return self;
}
-(void)initData{

    _pointArr = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)makeChartXView{

    //X轴
    layerX = [CAShapeLayer layer];
    layerX.frame = CGRectMake(35,LABLE_HEIGHT, LABLE_WIDTH, 1);
    layerX.backgroundColor = kClearColor.CGColor;
    [self.layer addSublayer:layerX];
    
}

-(void)makeChartYView{

    //左侧纵坐标轴
//    layerY = [CAShapeLayer layer];
//    layerY.frame = CGRectMake(45, 0, 1, LABLE_HEIGHT);
//    layerY.backgroundColor = [kClearColor CGColor];
//    [self.layer addSublayer:layerY];
    
    float height= LABLE_HEIGHT/5;
    // 纵坐标上的横线
    for (int i=0; i<5; i++) {
        if (i!=5) {
            CAShapeLayer *layer5 = [CAShapeLayer layer];
            layer5.frame = CGRectMake(45,height + i*height,LABLE_WIDTH - 45, 0.5f);
            layer5.backgroundColor = [kHexColor(@"#EBEBEB") CGColor];
//            layer5.backgroundColor = [[UIColor blackColor] CGColor];
            [self.layer addSublayer:layer5];
        }
    }
    
    // 右侧侧纵轴线
//    CAShapeLayer *layerLeft = [CAShapeLayer layer];
//    layerLeft.frame = CGRectMake(VIEW_WIDTH-2,25, 0.5f, LABLE_HEIGHT);
//    layerLeft.backgroundColor = [[UIColor colorFromHexCode:@"d8d8d8"] CGColor];
//    [self.layer addSublayer:layerLeft];

}

-(void)makeBottomlayer{

    _bottomLayer = [CAShapeLayer layer];
    _bottomLayer.backgroundColor = kClearColor.CGColor;
    _bottomLayer.frame = CGRectMake(60, LABLE_HEIGHT/5, SCREEN_WIDTH - 80, 147 - LABLE_HEIGHT/5);
    [self.layer addSublayer:_bottomLayer];
}


-(void)setArrX:(NSArray *)arrX{
    _arrX = arrX;
    
    [layerX removeFromSuperlayer];
    [self makeChartXView];
    
//    CGFloat width = (VIEW_WIDTH-30)/3;
    
//    for (NSInteger i=0; i<arrX.count; i++) {
//
//        UILabel *label = (UILabel*)[self viewWithTag:5000+i];
//        [label removeFromSuperview];
//    }
    //横坐标上的数字
//    for (int i=0; i<arrX.count; i++) {
//
//        UILabel *layer3 = [UILabel new];
//        layer3.frame = CGRectMake((VIEW_WIDTH - LABLE_WIDTH)+i*width+25, VIEW_HEIGHT - 20, width, 20);
//        layer3.text = [NSString stringWithFormat:@"%@",_arrX[i]];
//        layer3.font = [UIFont systemFontOfSize:12];
//        layer3.textAlignment = NSTextAlignmentLeft;
//        layer3.tag = 5000+i;
//        layer3.textColor = [UIColor colorFromHexCode:@"999999"];
//        [self addSubview:layer3];
//
//
////        CATextLayer *layer3 = [CATextLayer layer];
////        layer3.frame = CGRectMake((VIEW_WIDTH - LABLE_WIDTH)+i*width, 5, width, 20);
////        layer3.string = [NSString stringWithFormat:@"%@",_arrX[i]];
////        layer3.fontSize = 12;
////        layer3.foregroundColor = [[UIColor colorFromHexCode:@"999999"] CGColor];
////        [layerX addSublayer:layer3];
//    }

}
-(void)setArrY:(NSArray *)arrY{
    _arrY = arrY;
    
    [layerY removeFromSuperlayer];
    [self makeChartYView];
    
    float height= LABLE_HEIGHT/arrY.count;


    for (NSInteger i=0; i<6; i++) {
        
        UILabel *label = (UILabel*)[self viewWithTag:4000+i];
        [label removeFromSuperview];
    }
    
    //纵坐标上的数字
    for (int i=0; i<arrY.count; i++) {
        
        UILabel *layer6 = [UILabel new];
        layer6.frame = CGRectMake(0,LABLE_HEIGHT-(i*height)-20, 60, 20);
        layer6.text = [NSString stringWithFormat:@"%@",_arrY[i]];
        layer6.font = [UIFont systemFontOfSize:11];
        layer6.textAlignment = NSTextAlignmentLeft;
        layer6.tag = 4000+i;
        layer6.textColor = kHexColor(@"#B3B3B3");
        [self addSubview:layer6];


    
    }
}
//画图
-(void)drawSmoothViewWithArrayX:(NSArray*)pathX andArrayY:(NSArray*)pathY andScaleX:(float)X andScalemax:(float)max andScalemin:(float)min{

    [_bottomLayer removeFromSuperlayer];
    [self makeBottomlayer];
    [_pointArr removeAllObjects];
    
    // 创建layer并设置属性
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  3.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = kHexColor(@"#9740E6").CGColor;
    [_bottomLayer addSublayer:layer];
    
    CGPoint point;
    // 创建贝塞尔路径~
    UIBezierPath *path = [UIBezierPath bezierPath];

    
    
    //X轴和Y轴的倍率
//    CGFloat BLX = (LABLE_WIDTH-15)/X;
//
    CGFloat BLY = LABLE_HEIGHT/5*4/X;
    
    for (int i= 0; i< pathY.count; i++) {
        
//        CGFloat X = i % pathY.count * ((SCREEN_WIDTH - 100)/pathY.count + (SCREEN_WIDTH - 100)/pathY.count );
        CGFloat X = i * (SCREEN_WIDTH - 100)/(pathY.count - 1);
        CGFloat Y =  BLY * (max - [pathY[i] floatValue]);//(VIEW_HEIGHT - LABLE_HEIGHT)/2是指图表在背景大图的的height

        
        
        
        
        
        
        point = CGPointMake(X, Y);

        [_pointArr addObject:[NSValue valueWithCGPoint:point]];
        
        if (i==0) {
            [path moveToPoint:point];//起点
        }
        
        [path addLineToPoint:point];
    }
    //平滑曲线
    path = [path smoothedPathWithGranularity:1];
    // 关联layer和贝塞尔路径~
    layer.path = path.CGPath;
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(3.0);
    animation.toValue = @(3.0);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    
    // 设置layer的animation
    [layer addAnimation:animation forKey:nil];
    
    layer.strokeEnd = 1;
    anmitionLayer = layer;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self drawGradient];
        
    });

}

#pragma mark 渐变阴影
- (void)drawGradient {
    
    [gradientLayer removeAllAnimations];
    [gradientLayer removeFromSuperlayer];
    
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 80), 147 - LABLE_HEIGHT/5);
    gradientLayer.colors =@[(__bridge id)[UIColor colorWithRed:151/255.0 green:64/255.0 blue:230/255.0 alpha:0.4].CGColor,(__bridge id)[UIColor colorWithRed:240/255.0 green:252/255.0 blue:254/255.0 alpha:0.4].CGColor];
    
//    151,64,230
//    [UIColor colorWithRed:140/255.0 green:70/255.0 blue:254/255.0 alpha:0.4]
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    
   // NSLog(@"Y====%lf",[[_pointArr firstObject] CGPointValue].y);

    CGPoint firstPoint = CGPointMake([[_pointArr firstObject] CGPointValue].x ,LABLE_HEIGHT - LABLE_HEIGHT/5) ;

    CGPoint lastPoint =  [[_pointArr lastObject] CGPointValue];
    
   // NSLog(@"firstPointX===%lf firstpointY==%lf",firstPoint.x,firstPoint.y);
    [gradientPath moveToPoint:firstPoint];
    
    for (int i = 0; i < _pointArr.count; i ++) {
        [gradientPath addLineToPoint:[_pointArr[i] CGPointValue]];
    }
    // 圆滑曲线
    gradientPath = [gradientPath smoothedPathWithGranularity:1];
    
    CGPoint endPoint = lastPoint;
    endPoint = CGPointMake(endPoint.x , (SCREEN_WIDTH - 80));
    [gradientPath addLineToPoint:endPoint];
    
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = gradientPath.CGPath;
    gradientLayer.mask = arc;
    [anmitionLayer addSublayer:gradientLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(3);
    animation.toValue = @(3);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    [gradientLayer addAnimation:animation forKey:nil];
    
}
-(void)refreshChartAnmition{
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(3.0);
    animation.toValue = @(3.0);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    
    // 设置layer的animation
    [anmitionLayer addAnimation:animation forKey:nil];
    
    anmitionLayer.strokeEnd = 1;
    
    [gradientLayer removeAllAnimations];
    [gradientLayer removeFromSuperlayer];
    
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [gradientLayer removeAllAnimations];
         [gradientLayer removeFromSuperlayer];
         
        [self drawGradient];
        
    });
}
@end
