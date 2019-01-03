//
//  OrderRecordCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderRecordCell : UITableViewCell

@property (nonatomic , strong)UIImageView *headImg;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UILabel *stateLbl;

@property (nonatomic , strong)UILabel *timeLbl;

@property (nonatomic , strong)UILabel *stateLbl2;

@property (nonatomic , assign)NSInteger row;

@end
