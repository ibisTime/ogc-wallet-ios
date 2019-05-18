//
//  MyMillDetailsModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/18.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMillDetailsModel : NSObject


//"userId" : "U20190510134951698572996",
//"symbol" : "HEY",
//"status" : "1",
//"id" : 1,
//"incomeCountExpect" : 4.9999999999999996e+22,
//"incomeTimeExpect" : "May 20, 2019 12:00:00 AM",
//"machineOrderCode" : "MO20190518121936637791903",
//"incomeTimeActual" : "May 20, 2019 12:00:00 AM",
//"incomeCountActual" : 4.9999999999999996e+22
@property (nonatomic ,copy)NSString *status;
@property (nonatomic ,copy)NSString *userId;
@property (nonatomic ,copy)NSString *symbol;
@property (nonatomic ,copy)NSString *incomeCountExpect;
@property (nonatomic ,copy)NSString *incomeTimeExpect;
@property (nonatomic ,copy)NSString *machineOrderCode;
@property (nonatomic ,copy)NSString *incomeCountActual;
@property (nonatomic ,copy)NSString *incomeTimeActual;
@end

NS_ASSUME_NONNULL_END
