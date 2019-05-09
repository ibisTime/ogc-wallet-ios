//
//  AddressBookCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface AddressBookCell : UITableViewCell

@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UILabel *timeLabel;
@property (nonatomic , strong)UILabel *addressLabel;
@property (nonatomic , strong)AddressModel *model;
@end
NS_ASSUME_NONNULL_END
