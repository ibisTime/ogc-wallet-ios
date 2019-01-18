//
//  MyBankCardModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBankCardModel : NSObject

//bankCode = PSBC;
//bankName = "\U4e2d\U56fd\U90ae\U653f\U50a8\U84c4\U94f6\U884c";
//bankcardNumber = 3303271996194648;
//code = BC20190116192900461604378;
//subbranch = 3303271996194648;
//systemCode = "CD-OGC000019";
//type = 0;
//userId = U20181228133231683443414;
@property (nonatomic , copy)NSString *isDefault;
@property (nonatomic , copy)NSString *bankCode;
@property (nonatomic , copy)NSString *bankName;
@property (nonatomic , copy)NSString *bankcardNumber;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *subbranch;
@property (nonatomic , copy)NSString *systemCode;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *userId;
;
@end
