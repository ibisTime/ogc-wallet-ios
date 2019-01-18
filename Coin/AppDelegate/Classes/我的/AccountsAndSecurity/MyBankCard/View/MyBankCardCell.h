//
//  MyBankCardCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBankCardModel.h"
@interface MyBankCardCell : UITableViewCell

@property (nonatomic , strong)MyBankCardModel *models;

@property (nonatomic , strong)UIButton *defaultBtn;
@property (nonatomic , strong)UIButton *deleteBtn;
@end
