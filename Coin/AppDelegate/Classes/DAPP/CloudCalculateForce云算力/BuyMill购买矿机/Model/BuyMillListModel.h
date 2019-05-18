//
//  BuyMillListModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/18.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyMillListModel : NSObject


//amount = 1000;
//code = M20190516171044433208998;
//dailyOutput = "0.1";
//daysLimit = 7;
//name = "Hey007D\U578b";
//stockOut = 20;
//stockTotal = 100;
//symbol = ETH;

@property (nonatomic , copy)NSString *amount;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *dailyOutput;
@property (nonatomic , copy)NSString *daysLimit;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *stockOut;
@property (nonatomic , copy)NSString *stockTotal;
@property (nonatomic , copy)NSString *symbol;
@end

NS_ASSUME_NONNULL_END
