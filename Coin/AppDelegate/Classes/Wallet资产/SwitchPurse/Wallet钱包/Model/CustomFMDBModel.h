//
//  CustomFMDBModel.h
//  Coin
//
//  Created by 郑勤宝 on 2019/3/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomFMDBModel : NSObject

@property (nonatomic , copy)NSString *userid;
@property (nonatomic , copy)NSString *mnemonics;
@property (nonatomic , copy)NSString *pwd;
@property (nonatomic , copy)NSString *walletName;

@end

NS_ASSUME_NONNULL_END
