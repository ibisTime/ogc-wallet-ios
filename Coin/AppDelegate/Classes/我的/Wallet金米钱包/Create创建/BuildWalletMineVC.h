//
//  BuildWalletMineVC.h
//  Coin
//
//  Created by shaojianfei on 2018/6/8.
//  Copyright © 2018年 chengdai. All rights reserved.
//
#define ACCOUNT_MARGIN 0;
#define ACCOUNT_HEIGHT 55;
#import "TLBaseVC.h"
typedef void(^WalletBackBlock)(void);

@interface BuildWalletMineVC : TLBaseVC

@property (nonatomic , copy) WalletBackBlock walletBlock;

@end
