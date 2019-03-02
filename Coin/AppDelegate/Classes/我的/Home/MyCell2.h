//
//  MyCell2.h
//  
//
//  Created by 郑勤宝 on 2018/12/24.
//

#import <UIKit/UIKit.h>


@protocol MyCellDelegate2<NSObject>

-(void)MyCellButtonSelectTag:(NSInteger)tag;

@end

@interface MyCell2 : UITableViewCell
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, weak) id<MyCellDelegate2> delegate;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIImageView *accessoryImageView;

@property (nonatomic , strong)UIButton *backBtn;
//@property (nonatomic , strong)UIButton *invitationBtn;
@property (nonatomic , strong)NSArray *dataArray;
@end
