//
//  AlertsTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "AlertsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlertsTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <AlertsModel *>*models;

@end

NS_ASSUME_NONNULL_END
