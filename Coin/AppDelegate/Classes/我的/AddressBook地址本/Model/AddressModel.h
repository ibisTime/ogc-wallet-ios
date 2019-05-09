//
//  AddressModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/8.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject

//address = 0xcd97701484cfe194799b477ca9f7be01b158cf51;
//createDatetime = "May 8, 2019 11:55:55 PM";
//id = 1;
//label = "\U90d1\U52e4\U5b9d";
//status = 0;
//symbol = ETH;
//updateDatetime = "May 8, 2019 11:55:55 PM";
//updater = U20190508151410179964065;
//userId = U20190508151410179964065;

@property (nonatomic , copy)NSString *address;
@property (nonatomic , copy)NSString *createDatetime;
@property (nonatomic , copy)NSString *label;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *symbol;
@property (nonatomic , copy)NSString *updateDatetime;
@property (nonatomic , copy)NSString *updater;
@property (nonatomic , copy)NSString *userId;
@end

NS_ASSUME_NONNULL_END
