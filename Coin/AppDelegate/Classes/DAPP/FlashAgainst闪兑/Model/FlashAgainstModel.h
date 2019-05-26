//
//  FlashAgainstModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/17.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlashAgainstModel : NSObject


@property (nonatomic , copy)NSString *countIn;
@property (nonatomic , copy)NSString *symbolIn;
@property (nonatomic , copy)NSString *feeRate;
@property (nonatomic , copy)NSString *updaterName;
@property (nonatomic , copy)NSString *symbolOut;
@property (nonatomic , copy)NSString *orderNo;;
@property (nonatomic , copy)NSString *creator;
@property (nonatomic , copy)NSString *creatorName;
@property (nonatomic , copy)NSString *createTime;
@property (nonatomic , copy)NSString *updater;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *min;
@property (nonatomic , copy)NSString *countOutTotal;
@property (nonatomic , copy)NSString *fee;
@property (nonatomic , copy)NSString *valueCnyOut;
@property (nonatomic , copy)NSString *valueCnyIn;
//"id" : 1,
//"symbolIn" : "ETH",
//"feeRate" : 10,
//"updaterName" : "admin",
//"symbolOut" : "USDT",
//"orderNo" : 0,
//"creator" : "UCOIN201700000000000001",
//"creatorName" : "admin",
//"createTime" : "May 16, 2019 8:33:19 PM",
//"updater" : "UCOIN201700000000000001",
//"status" : "1",
//"min" : 10000000000000000


@end

NS_ASSUME_NONNULL_END
