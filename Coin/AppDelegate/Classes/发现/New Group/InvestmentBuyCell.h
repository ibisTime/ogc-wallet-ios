//
//  InvestmentBuyCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestmentBuyCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic , assign)CGFloat price;
@property (nonatomic , strong)UITextField *amountField;

@property (nonatomic , strong)UITextField *numberField;
@property (nonatomic , copy)NSString *Rate;
@end
