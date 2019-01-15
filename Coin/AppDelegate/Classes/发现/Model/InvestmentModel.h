//
//  InvestmentModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestmentModel : NSObject



//"symbol" : "BTC",
//"period" : "1",
//"id" : 4,
//"price" : 24521,
//"createDatetime" : "Jan 14, 2019 2:07:34 PM",
//"type" : "0",
//"updateDatetime" : "Jan 14, 2019 10:07:33 PM"

@property (nonatomic , copy)NSString *symbol;
@property (nonatomic , copy)NSString *period;
@property (nonatomic , copy)NSString *ID;
@property (nonatomic , copy)NSString *price;
@property (nonatomic , copy)NSString *createDatetime;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *updateDatetime;

@end
