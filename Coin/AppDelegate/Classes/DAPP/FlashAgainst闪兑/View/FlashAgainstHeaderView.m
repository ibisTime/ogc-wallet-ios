//
//  FlashAgainstHeaderView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FlashAgainstHeaderView.h"

@implementation FlashAgainstHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
        iconImg.image = kImage(@"头像");
        [self addSubview:iconImg];
        
        UILabel *phoneLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 10, 15, SCREEN_WIDTH - 25, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:nil];
        phoneLbl.text = [TLUser user].mobile;
        [self addSubview:phoneLbl];
    }
    return self;
}

@end
