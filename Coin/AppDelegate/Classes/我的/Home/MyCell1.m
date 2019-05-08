//
//  MyCell1.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "MyCell1.h"


@interface MyCell1 ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIImageView *accessoryImageView;

@end

@implementation MyCell1


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(16.5, 15, 19, 20)];
        [self addSubview:iconImg];
        
        UILabel *iconLbl = [[UILabel alloc]initWithFrame:CGRectMake(iconImg.xx + 12, 15, SCREEN_WIDTH - 100, 20)];
        iconLbl.textAlignment = NSTextAlignmentLeft;
        [iconLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        iconLbl.font = FONT(14);
        [self addSubview:iconLbl];

        
        self.iconImg = iconImg;
        self.iconLbl = iconLbl;
        
        UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 7.5 - 12, 19, 7, 12)];
        [youImg theme_setImageIdentifier:@"我的跳转" moduleName:ImgAddress];
        
        [self addSubview:youImg];
        
    }
    return self;
    
}




@end
