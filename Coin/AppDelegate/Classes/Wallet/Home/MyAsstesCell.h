//
//  MyAsstesCell.h
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyModel.h"
@interface MyAsstesCell : UITableViewCell


@property (nonatomic, strong) CurrencyModel *platform;

@property (nonatomic , strong)UIButton *intoBtn;

@property (nonatomic , strong)UIButton *rollOutBtn;

@property (nonatomic , strong)UIButton *billBtn;

@end
