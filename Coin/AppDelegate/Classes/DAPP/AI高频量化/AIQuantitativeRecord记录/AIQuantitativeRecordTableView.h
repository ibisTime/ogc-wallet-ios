//
//  AIQuantitativeRecordTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "AIQuantitativeRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AIQuantitativeRecordTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <AIQuantitativeRecordModel *>*models;

@property (nonatomic , strong)NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
