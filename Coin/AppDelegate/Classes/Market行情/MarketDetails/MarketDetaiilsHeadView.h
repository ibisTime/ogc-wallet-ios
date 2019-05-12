//
//  MarketDetaiilsHeadView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmoothChartView1.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MarketDetaiilsHeadDelegate <NSObject>

-(void)MarketDetaiilsHeadButton:(UIButton *)sender;

@end
@interface MarketDetaiilsHeadView : UIView
@property (nonatomic , strong)SmoothChartView1 *smoothView;
@property (nonatomic, assign) id <MarketDetaiilsHeadDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
