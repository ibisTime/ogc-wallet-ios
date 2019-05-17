//
//  AlertsModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertsModel : NSObject

@property (nonatomic , copy)NSString *content;
@property (nonatomic , copy)NSString *source;
@property (nonatomic , copy)NSString *isPush;
@property (nonatomic , copy)NSString *isTop;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *showDatetime;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *updater;



@end

NS_ASSUME_NONNULL_END
