//
//  TeamPerFormanceTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "TeamPerformanceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TeamPerFormanceTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <TeamPerformanceModel *>*models;
@end

NS_ASSUME_NONNULL_END
