//
//  TodoModel.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoModel : NSObject

@property (nonatomic , copy)NSString *bizOrderType;
@property (nonatomic , copy)NSString *bizType;
@property (nonatomic , copy)NSString *dealNode;
@property (nonatomic , copy)NSString *departmentName;
@property (nonatomic , copy)NSString *loanBank;
@property (nonatomic , copy)NSString *refOrder;
@property (nonatomic , copy)NSString *refType;
@property (nonatomic , copy)NSString *startDatetime;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *ID;

@property (nonatomic , copy)NSString *content;
@property (nonatomic , copy)NSString *title;
@property (nonatomic , copy)NSString *createDatetime;

//bizOrderType = "\U51c6\U5165\U5355";
//bizType = 0;
//dealNode = "002_01";
//departmentName = "\U4e4c\U9c81\U6728\U9f50\U534e\U9014\U5a01\U901a\U6c7d\U8f66\U9500\U552e\U6709\U9650\U516c\U53f8";
//id = 28;
//loanBank = BA201809101215201166542;
//refOrder = BO201904111018378327344;
//refType = 002;
//startDatetime = "Apr 11, 2019 10:18:37 AM";
//userName = xlf2;

@end

NS_ASSUME_NONNULL_END
