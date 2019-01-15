//
//  InvestmentTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "InvestmentModel.h"
@interface InvestmentTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <InvestmentModel *>*models;

@property (nonatomic , assign)CGFloat price;

@end
