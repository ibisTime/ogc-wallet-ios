//
//  TeamPerformanceModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/21.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamPerformanceModel : NSObject

//dateTime = "May 21, 2019 12:00:00 AM";
//totalIncome = "1.312e+23";
//totalPerformance = 0;

@property (nonatomic , copy)NSString *totalPerformance;
@property (nonatomic , copy)NSString *totalIncome;
@property (nonatomic , copy)NSString *dateTime;

@end

NS_ASSUME_NONNULL_END
