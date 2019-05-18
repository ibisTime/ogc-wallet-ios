//
//  MyMillModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/18.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMillModel : NSObject

//amount = 1000;
//code = MO20190518121936637791903;
//continueEndTime = "May 20, 2019 12:00:00 AM";
//continueFlag = 0;
//continueLifeTime = 7;
//continueOutput = 0;
//continueStartTime = "May 19, 2019 12:00:00 AM";
//continueStatus = 0;
//createTime = "May 18, 2019 12:00:00 AM";
//endTime = "May 25, 2019 12:00:00 AM";
//incomeActual = "6e+23";
//investAmount = 5000;
//investCount = 5000;
//machineCode = M20190516171044433208998;
//quantity = 5;
//speedDays = 0;
//speedEndTime = "May 25, 2019 12:00:00 AM";
//startTime = "May 19, 2019 12:00:00 AM";
//status = 0;
//symbol = ETH;
//userId = U20190510134951698572996;


@property (nonatomic ,copy)NSString *amount;
@property (nonatomic ,copy)NSString *code;
@property (nonatomic ,copy)NSString *continueEndTime;
@property (nonatomic ,copy)NSString *continueFlag;
@property (nonatomic ,copy)NSString *continueLifeTime;
@property (nonatomic ,copy)NSString *continueOutput;
@property (nonatomic ,copy)NSString *continueStartTime;
@property (nonatomic ,copy)NSString *continueStatus;
@property (nonatomic ,copy)NSString *createTime;
@property (nonatomic ,copy)NSString *endTime;
@property (nonatomic ,copy)NSString *incomeActual;
@property (nonatomic ,copy)NSString *investAmount;
@property (nonatomic ,copy)NSString *investCount;
@property (nonatomic ,copy)NSString *machineCode;
@property (nonatomic ,copy)NSString *quantity;
@property (nonatomic ,copy)NSString *speedDays;
@property (nonatomic ,copy)NSString *speedEndTime;
@property (nonatomic ,copy)NSString *startTime;
@property (nonatomic ,copy)NSString *status;
@property (nonatomic ,copy)NSString *symbol;
@property (nonatomic ,copy)NSString *userId;

@end

NS_ASSUME_NONNULL_END
