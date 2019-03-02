//
//  MyCell3.h
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyCellDelegate3<NSObject>

-(void)MyCellButtonSelectTag:(NSInteger)tag;

@end

@interface MyCell3 : UITableViewCell
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, weak) id<MyCellDelegate3> delegate;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIImageView *accessoryImageView;

@property (nonatomic , strong)UIButton *backBtn;

@property (nonatomic , strong)NSArray *dataArray;
@end
