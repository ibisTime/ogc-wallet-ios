//
//  EggplantAccountCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "EggplantAccountCell.h"

@implementation EggplantAccountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 17.5, SCREEN_WIDTH - 130, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        nameLbl.text=  @"兑换所得";
        [self addSubview:nameLbl];
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy + 5, SCREEN_WIDTH - 130, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        timeLbl.text=  @"兑换所得";
        [self addSubview:timeLbl];
        
        UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(nameLbl.xx, 0, 100, 75)];
        priceLbl.textAlignment = NSTextAlignmentRight;
        priceLbl.font = FONT(12);
        priceLbl.textColor = kHexColor(@"#FF6464");
        priceLbl.text=  @"+50";
        [self addSubview:priceLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
    }
    return self;
}
@end
