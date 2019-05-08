//
//  CustomFMDB.h
//  Coin
//
//  Created by 郑勤宝 on 2019/3/20.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomFMDB : NSObject

+(NSDictionary *)FMDBqueryUseridMnemonicsPwdWalletName;

+(NSArray *)FMDBqueryMnemonics;

@end

NS_ASSUME_NONNULL_END
