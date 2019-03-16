//
//  IconCollCell.m
//  Coin
//
//  Created by 郑勤宝 on 2018/11/30.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "IconCollCell.h"

@implementation IconCollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIButton *iconButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        iconButton.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 25)/4, (SCREEN_WIDTH - 25)/4);
//        self.iconButton=iconButton;
//        [iconButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//        iconButton.titleLabel.font = FONT(14);
////        iconButton.titleLabel.numberOfLines = 2;
//        [self addSubview:iconButton];
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2 - 30, 10, 60, 60)];
        [self addSubview:iconImage];
        self.iconImage = iconImage;
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, iconImage.yy + 10, self.width, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        [self addSubview:nameLbl];
        self.nameLbl = nameLbl;
        
    }
    return self;
}

@end
