//
//  MyMillCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMillModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyMillCell : UITableViewCell


@property (nonatomic , strong)MyMillModel *model;
@property (nonatomic , copy)NSString *cvalue;
@end

NS_ASSUME_NONNULL_END
