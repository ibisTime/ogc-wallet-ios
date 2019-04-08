//
//  MyCell1.h
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCellDelegate1<NSObject>

-(void)MyCellButtonSelectTag:(NSString *)btnStr;

@end

@interface MyCell1 : UITableViewCell
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, weak) id<MyCellDelegate1> delegate;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIImageView *accessoryImageView;

@property (nonatomic , strong)UIButton *backBtn;
@property (nonatomic , strong)NSArray *dataArray;

@property (nonatomic , assign)NSInteger blessing;
@end
