//
//  AlertsCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlertsCell : UITableViewCell

@property (nonatomic , strong)AlertsModel *model;

@property (nonatomic , strong)UIButton *poorBtn;
@property (nonatomic , strong)UILabel *contactLbl;
@property (nonatomic , strong)UILabel *timeLbl;
@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIView *lineView;
@end

NS_ASSUME_NONNULL_END
