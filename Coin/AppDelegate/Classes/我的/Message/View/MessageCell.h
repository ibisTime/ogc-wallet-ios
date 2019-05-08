//
//  MessageCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UITableViewCell
@property (nonatomic , strong)TodoModel *models;
@end

NS_ASSUME_NONNULL_END
