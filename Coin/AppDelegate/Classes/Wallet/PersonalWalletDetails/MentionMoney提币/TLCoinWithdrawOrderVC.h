//
//  TLCoinWithdrawOrderVC.h
//  Coin
//
//  Created by  tianlei on 2018/1/17.
//  Copyright © 2018年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"

@interface TLCoinWithdrawOrderVC : TLBaseVC

//@property (nonatomic, copy) NSString *coin;
@property (nonatomic, strong) CurrencyModel *currency;
@property (nonatomic , copy)NSString *titleString;

@end
