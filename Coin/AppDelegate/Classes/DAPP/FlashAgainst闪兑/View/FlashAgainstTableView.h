//
//  FlashAgainstTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "FlashAgainstModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FlashAgainstTableView : TLTableView

@property (nonatomic , strong)FlashAgainstModel *model;
@property (nonatomic , strong)NSMutableArray <FlashAgainstModel *>*recordModels;
@end

NS_ASSUME_NONNULL_END
