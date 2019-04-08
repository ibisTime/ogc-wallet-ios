//
//  PrivateKeyWalletTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/3/23.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"

//M
#import "CurrencyModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^selectCurrent)(NSInteger );

@interface PrivateKeyWalletTableView : TLTableView
//
@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*platforms;
//类型
//@property (nonatomic, assign) PlatformType type;

@property (nonatomic,copy)selectCurrent selectBlock;

@property (nonatomic, assign) BOOL isLocal;

@property (nonatomic , copy)NSString *btcOldAddress;


NS_ASSUME_NONNULL_END
@end
