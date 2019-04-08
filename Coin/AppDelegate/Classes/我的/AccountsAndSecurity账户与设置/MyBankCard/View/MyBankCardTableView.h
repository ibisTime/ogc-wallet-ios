//
//  MyBankCardTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "MyBankCardModel.h"
@interface MyBankCardTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <MyBankCardModel *>*models;

@end
