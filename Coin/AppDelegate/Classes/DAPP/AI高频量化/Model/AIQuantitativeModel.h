//
//  AIQuantitativeModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/24.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AIQuantitativeModel : NSObject


@property (nonatomic , copy)NSString *buyMax;
@property (nonatomic , copy)NSString *buyMin;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *createTime;
@property (nonatomic , copy)NSString *Description;
@property (nonatomic , copy)NSString *feeRate;
@property (nonatomic , copy)NSString *lockDays;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *orderCount;
@property (nonatomic , copy)NSString *picture;
@property (nonatomic , copy)NSString *rate;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , copy)NSString *repayType;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *symbolBuy;
@property (nonatomic , copy)NSString *symbolIncome;


@end

NS_ASSUME_NONNULL_END
