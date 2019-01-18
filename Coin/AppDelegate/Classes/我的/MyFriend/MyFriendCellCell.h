//
//  MyFriendCellCell.h
//  Coin
//
//  Created by 郑勤宝 on 2018/12/29.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFriendModel.h"
@interface MyFriendCellCell : UITableViewCell

@property (nonatomic , strong)MyFriendModel *model;

@property (nonatomic , strong)UIImageView *headImg;

@property (nonatomic , strong)UILabel *nameLabel;

@end
