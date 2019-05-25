//
//  AIQuantitativeRecordDetailsVC.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/26.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLBaseVC.h"
#import "AIQuantitativeRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AIQuantitativeRecordDetailsVC : TLBaseVC
@property (nonatomic , strong)AIQuantitativeRecordModel *model;
@property (nonatomic , strong)NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
