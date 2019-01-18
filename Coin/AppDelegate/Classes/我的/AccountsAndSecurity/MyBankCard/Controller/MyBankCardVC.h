//
//  MyBankCardVC.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLBaseVC.h"
#import "MyBankCardModel.h"
typedef void(^MyBankCardBlock)(MyBankCardModel *model);


@interface MyBankCardVC : TLBaseVC

@property (nonatomic,copy) MyBankCardBlock returnValueBlock;
@property (nonatomic , copy)NSString *choose;

@end
