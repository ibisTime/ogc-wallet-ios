//
//  InvestmentHeadCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "InvestmentHeadCell.h"

@implementation InvestmentHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self makeSmoothChartView];
    }
    return self;
}

/**创建“收益走势”图*/
#pragma mark - 作图表


-(void)setModels:(NSMutableArray<InvestmentModel *> *)models
{
//    NSMutableArray *arrayX = [NSMutableArray array];
//    NSMutableArray *arrayY = [NSMutableArray array];
//    for (int i = 0; i < models.count; i ++) {
//        [arrayX addObject:@(i + 1)];
//        [arrayY addObject:models[i].price];
//    }
//    CGFloat maxPrice = [[arrayY valueForKeyPath:@"@max.floatValue"] floatValue] + 100;
////    CGFloat minPrice = [[arrayY valueForKeyPath:@"@min.floatValue"] floatValue] + 100;
//    
//    _smoothView.arrY = @[@"0",[NSString stringWithFormat:@"%.0f",maxPrice/4],[NSString stringWithFormat:@"%.0f",maxPrice/4*2],[NSString stringWithFormat:@"%.0f",maxPrice/4*3],[NSString stringWithFormat:@"%.0f",maxPrice/4*4]];
//    [_smoothView drawSmoothViewWithArrayX:arrayX andArrayY:arrayY andScaleX:arrayX.count];
//    [_smoothView refreshChartAnmition];
}

@end
