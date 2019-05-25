//
//  FlashAgainstHeaderView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashAgainstModel.h"
#import "CurrencyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FlashAgainstHeaderView : UIView<UITextFieldDelegate>
@property (nonatomic , strong)FlashAgainstModel *model;
@property (nonatomic , strong)NSMutableArray <CurrencyModel *>*currenctModel;
@property (nonatomic , assign)CGFloat InPrice;
@property (nonatomic , assign)CGFloat OutPrice;

@property (nonatomic , strong)CurrencyModel *platforms;
@property (nonatomic , strong)UIButton *exchangeBtn;
@property (nonatomic , strong)NSDictionary *dataDic;

@property (nonatomic , strong)UITextField *leftNumberTf;
@property (nonatomic , strong)UITextField *rightNumberTf;
@property (nonatomic , strong)UILabel *poundageLbl;
@property (nonatomic , strong)UIButton *chooseBtn;

@end

NS_ASSUME_NONNULL_END
