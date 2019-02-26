//
//  InvestmentTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"
#import "InvestmentModel.h"
#import "MyBankCardModel.h"
@interface InvestmentTableView : TLTableView


@property (nonatomic , copy)NSString *symbol;
@property (nonatomic , strong)NSMutableArray <InvestmentModel *>*models;
//余额
@property (nonatomic , assign)CGFloat price;
//支付防水
@property (nonatomic , strong)NSDictionary *payWayDic;
//选择买入  卖出
@property (nonatomic , assign)NSInteger indexBtnTag;
//收款银行
@property (nonatomic , strong)MyBankCardModel *bankModel;
//手续费
@property (nonatomic , copy)NSString *Rate;
//余额
@property (nonatomic , copy)NSString *balance;
//最大额度
@property (nonatomic , copy)NSString *biggestLimit;

@property (nonatomic , copy)NSString *smallLimit;


@end
