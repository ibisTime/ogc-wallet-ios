//
//  AddressModel.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/8.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"ID"]) {
        return @"id";
    }
    
    return propertyName;
}

@end
