//
//  BuyMillListTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "BuyMillListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuyMillListTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <BuyMillListModel *>*models;
@end

NS_ASSUME_NONNULL_END
