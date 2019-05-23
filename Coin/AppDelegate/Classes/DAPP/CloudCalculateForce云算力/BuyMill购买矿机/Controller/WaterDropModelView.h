//
//  WaterDropModelView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/23.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyMillListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WaterDropModelView : UIView

@property (nonatomic , strong)UIButton *confirm;
@property (nonatomic , strong)BuyMillListModel *model;

@property (nonatomic , copy)NSString *orderInformation;
@end

NS_ASSUME_NONNULL_END
