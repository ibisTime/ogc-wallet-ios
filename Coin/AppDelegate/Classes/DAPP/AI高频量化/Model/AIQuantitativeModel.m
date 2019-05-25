//
//  AIQuantitativeModel.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/24.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeModel.h"

@implementation AIQuantitativeModel



+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"Description"]) {
        return @"description";
    }
    return propertyName;
}


@end
