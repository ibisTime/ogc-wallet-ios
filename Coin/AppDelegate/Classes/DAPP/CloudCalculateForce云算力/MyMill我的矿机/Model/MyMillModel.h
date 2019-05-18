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
@property (nonatomic ,copy)NSString *statussStr;
@property (nonatomic ,copy)NSString *symbol;
@property (nonatomic ,copy)NSString *userId;
@property (nonatomic ,copy)NSDictionary *machine;

@end

NS_ASSUME_NONNULL_END
