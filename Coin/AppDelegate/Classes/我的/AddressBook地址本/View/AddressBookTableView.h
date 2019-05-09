//
//  AddressBookTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressBookTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <AddressModel *>*models;
@end

NS_ASSUME_NONNULL_END
