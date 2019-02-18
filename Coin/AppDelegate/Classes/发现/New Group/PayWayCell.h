//
//  PayWayCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayWayCell : UITableViewCell
@property (nonatomic , strong)NSDictionary *payWayDic;
@property (nonatomic , strong)UILabel *nameLabel;
@property (nonatomic , strong)UIButton *payBtn;

//最大额度
@property (nonatomic , copy)NSString *biggestLimit;
@property (nonatomic , copy)NSString *smallLimit;
@end
