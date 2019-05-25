//
//  ImportPurchaseAmountVC.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIQuantitativeModel.h"
#import "CurrencyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ImportPurchaseAmountVC : UIView
@property (nonatomic , strong)UIButton *confirm;

@property (nonatomic , strong)AIQuantitativeModel *model;
@property (nonatomic , strong)CurrencyModel *currencyModel;
@property (nonatomic , strong)UIButton *intoBtn;
@property (nonatomic , strong)UITextField *buyCreditsTf;

@property (nonatomic , copy)NSString *price;
@end

NS_ASSUME_NONNULL_END
