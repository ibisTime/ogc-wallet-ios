//
//  QuestionListTableView.h
//  Coin
//
//  Created by shaojianfei on 2018/8/4.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "BillModel.h"
#import "QuestionModel.h"
typedef void(^WalletAddBlock)(void);

@interface QuestionListTableView : TLTableView
@property (nonatomic,strong) NSMutableArray <BillModel *>*bills;
@property (nonatomic,strong) NSArray <QuestionModel *>*questions;

@property (nonatomic,copy) WalletAddBlock addBlock;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
@end
