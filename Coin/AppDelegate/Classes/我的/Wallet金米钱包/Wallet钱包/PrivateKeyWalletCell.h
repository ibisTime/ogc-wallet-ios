//
//  PrivateKeyWalletCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/3/23.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol MyAsstesDelegate <NSObject>

-(void)MyAsstesButton:(UIButton *)sender;

@end

@interface PrivateKeyWalletCell : UITableViewCell


@property (nonatomic , strong)UIView *whiteView;

@property (nonatomic, assign) id <MyAsstesDelegate> delegate;

@property (nonatomic, strong) NSMutableArray <CurrencyModel *>*platforms;

@property (nonatomic , strong)UIButton *backButton;

@end



