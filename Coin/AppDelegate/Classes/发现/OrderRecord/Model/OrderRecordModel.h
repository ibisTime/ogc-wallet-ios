//
//  OrderRecordModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderRecordModel : NSObject





//"acceptUserId" : "SYS_USER_",
//"status" : "0",
//"code" : "AO20190116151037018702732",
//"receiveType" : "1",
//"tradeCoin" : "FMVP",
//"tradeAmount" : 24912,
//"receiveInfo" : "支付宝",
//"count" : 100000000,
//"receiveCardNo" : "1234567890",
//"createDatetime" : "Jan 16, 2019 3:10:37 PM",
//"type" : "0",
//"user" :
//"invalidDatetime" : "Jan 16, 2019 3:20:37 PM",
//"pic" : "Fnk8QUjkUxmvnvH0cpIjDsZhG5Au",
//"receiveBank" : "支付宝",
//"tradePrice" : 24912,
//"postscript" : "34a2",
//"fee" : 100000,
//"receiveSubbranch" : "支付宝",
//"orderUid" : 53,
//"tradeCurrency" : "BTC",
//"userId" : "U20181228133231683443414"
@property (nonatomic , copy)NSString *tradeAmount;
@property (nonatomic , copy)NSString *acceptUserId;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *receiveType;
@property (nonatomic , copy)NSString *tradeCoin;
@property (nonatomic , copy)NSString *receiveInfo;
@property (nonatomic , copy)NSString *count;
@property (nonatomic , copy)NSString *receiveCardNo;
@property (nonatomic , copy)NSString *createDatetime;;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , strong)NSDictionary *user;
@property (nonatomic , copy)NSString *invalidDatetime;
@property (nonatomic , copy)NSString *pic;
@property (nonatomic , copy)NSString *receiveBank;
@property (nonatomic , copy)NSString *tradePrice;
@property (nonatomic , copy)NSString *postscript;
@property (nonatomic , copy)NSString *fee;
@property (nonatomic , copy)NSString *receiveSubbranch;
@property (nonatomic , copy)NSString *orderUid;
@property (nonatomic , copy)NSString *tradeCurrency;
@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *bankcardNumber;
@property (nonatomic , copy)NSString *receiveName;
@property (nonatomic , copy)NSString *remainTime;
//@property (nonatomic , copy)NSString *tradeCoin;
@end
