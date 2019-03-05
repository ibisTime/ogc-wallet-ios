//
//  InvestmentHeadCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
//折线图
#import "SmoothChartView.h"
#import "BrokenChartView.h"
#import "InvestmentModel.h"
@interface InvestmentHeadCell : UITableViewCell
@property (nonatomic , strong)NSMutableArray <InvestmentModel *>*models;
//折线图
@property (nonatomic, strong)SmoothChartView *smoothView;;

@property (nonatomic , copy)NSString *symbol;

@end
