//
//  MyFriendTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2018/12/29.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "MyFriendModel.h"
@interface MyFriendTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <MyFriendModel *>*models;
@end
