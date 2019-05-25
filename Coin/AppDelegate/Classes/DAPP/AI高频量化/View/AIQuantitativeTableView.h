//
//  AIQuantitativeTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "AIQuantitativeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AIQuantitativeTableView : TLTableView


@property (nonatomic , strong)NSMutableArray <AIQuantitativeModel *>*models;

@end

NS_ASSUME_NONNULL_END
