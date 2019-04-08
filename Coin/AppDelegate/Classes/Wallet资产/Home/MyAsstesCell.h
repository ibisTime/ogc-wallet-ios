//
//  MyAsstesCell.h
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyModel.h"


@protocol MyAsstesDelegate <NSObject>

-(void)MyAsstesButton:(UIButton *)sender;

@end

@interface MyAsstesCell : UITableViewCell


@property (nonatomic , strong)UIView *whiteView;

@property (nonatomic, assign) id <MyAsstesDelegate> delegate;

@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*platforms;

@property (nonatomic , strong)UIButton *backButton;

@end
