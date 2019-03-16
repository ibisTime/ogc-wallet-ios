//
//  PosMyInvestmentHeadView.h
//  Coin
//
//  Created by QinBao Zheng on 2018/9/26.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PosMyInvestmentDelegate <NSObject>

-(void)PosMyInvestmentButton:(NSInteger )tag;

@end

@interface PosMyInvestmentHeadView : UIView

@property (nonatomic, assign) id <PosMyInvestmentDelegate> delegate;

@property (nonatomic , strong)UIButton *earningsButton;

@property (nonatomic , strong)UIButton *backButton;

@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , strong)UILabel *nameLabel;

//@property (nonatomic , strong)UIButton *earningsButton;

@end
