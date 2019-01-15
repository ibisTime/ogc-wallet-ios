//
//  OrderRecordTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "OrderRecordModel.h"
@interface OrderRecordTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <OrderRecordModel *>*models;
@end
