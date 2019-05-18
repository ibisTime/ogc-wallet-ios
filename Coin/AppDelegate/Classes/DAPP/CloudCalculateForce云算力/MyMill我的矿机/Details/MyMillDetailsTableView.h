//
//  MyMillDetailsTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "MyMillModel.h"
#import "MyMillDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyMillDetailsTableView : TLTableView
@property (nonatomic , strong)MyMillModel *model;
@property (nonatomic , strong)NSMutableArray <MyMillDetailsModel *>*models;
@end

NS_ASSUME_NONNULL_END
