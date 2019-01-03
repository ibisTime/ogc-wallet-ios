//
//  PayWayCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PayWayCell.h"

@implementation PayWayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = kBackgroundColor;
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2 - 15, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#666666")];
        nameLabel.text = [LangSwitcher switchLang:@"支付方式" key:nil];
        [backView addSubview:nameLabel];
        
        UIButton *payBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"支付宝" key:nil] titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:14];
        payBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2 - 34, 50);
        payBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [backView addSubview:payBtn];
        [payBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"支付宝支付") forState:(UIControlStateNormal)];
        }];
        
        
        
        UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 7.5 - 18, 18.5, 7.5, 13)];
        youImg.image = kImage(@"更多-灰色");
        [backView addSubview:youImg];
        
        UILabel *instructionsLbl = [UILabel labelWithFrame:CGRectMake(15, backView.yy + 14, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        instructionsLbl.text = [LangSwitcher switchLang:@"说明：单笔交易限额5万人民币" key:nil];
        [self addSubview:instructionsLbl];
        
        
        
        
    }
    return self;
}

@end
