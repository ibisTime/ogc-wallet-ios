//
//  MyMillModel.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/18.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyMillModel.h"

@implementation MyMillModel

-(NSString *)statussStr
{
    if ([_status isEqualToString:@"0"]) {
        _statussStr = @"待挖矿";
    }
    if ([_status isEqualToString:@"1"]) {
        _statussStr = @"挖矿中";
    }
    if ([_status isEqualToString:@"2"]) {
        _statussStr = @"已失效";
    }
    return _statussStr;
}

@end
