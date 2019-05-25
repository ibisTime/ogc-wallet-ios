//
//  AIQuantitativeRecordModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AIQuantitativeRecordModel : NSObject



//"userId" : "U20190510134951698572996",
//"investCount" : 10,
//"status" : "0",
//"incomeCount" : 0,
//"code" : "GO20190525114416946527507",
//"productCode" : "GP20190523225907593588869",
//"createTime" : "May 25, 2019 11:44:16 AM"

@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *investCount;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *incomeCount;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *productCode;
@property (nonatomic , copy)NSString *createTime;
@property (nonatomic , copy)NSString *productName;
@property (nonatomic , copy)NSString *symbolBuy;
@property (nonatomic , copy)NSString *endTime;
@property (nonatomic , copy)NSString *totalIncome;
@property (nonatomic , copy)NSString *startTime;
@end

NS_ASSUME_NONNULL_END
