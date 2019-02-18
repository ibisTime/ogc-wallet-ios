//
//  TLtakeMoneyModel.m
//  Coin
//
//  Created by shaojianfei on 2018/8/16.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLtakeMoneyModel.h"

@implementation TLtakeMoneyModel



//DRAFT("0", "草稿"), TO_APPROVE("1", "待审核"), APPROVE_YES("2",
//                                                      "审核通过"), APPROVE_NO("3", "审核不通过"), TO_START("4", "即将开始"), RAISE("5",
//                                                                                                                      "募集期"), RAISE_YES("6", "募集成功"), TO_YIELD("7", "生息中"), REPAY_CAN(
//                                                                                                                                                                                      "8", "可还款"), REPAY_YES("9", "已还款"), RAISE_NO("10", "募集失败");
-(NSString *)statusStr
{
    if (!_statusStr) {
        if ([_status isEqualToString:@"4"]) {
            _statusStr = @"即将开始";
        }else if ([_status isEqualToString:@"5"]) {
            _statusStr = @"认购中";
        }else if ([_status isEqualToString:@"6"]) {
            _statusStr = @"募集成功";
        }else if ([_status isEqualToString:@"7"]) {
            _statusStr = @"计息中";
        }else if ([_status isEqualToString:@"8"]) {
            _statusStr = @"赎回中";
        }else if ([_status isEqualToString:@"9"]) {
            _statusStr = @"已结束";
        }else if ([_status isEqualToString:@"10"]) {
            _statusStr = @"募集失败";
        }
        else
        {
            _statusStr = @"敬请期待";
        }

    }
    return _statusStr;
}

@end
