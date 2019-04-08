//
//  MyBankCardCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MyBankCardCell.h"

@implementation MyBankCardCell
{
    UILabel *bankNameLbl;
    UILabel *bankNumberLbl;
    UIImageView *backImage;
    UIImageView *iconImg;
    UILabel *bankTypeLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        backImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, SCREEN_WIDTH - 30, 160)];
//        backImage.image = kImage(@"邮政银行");
        [self addSubview:backImage];
        
//        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(24, 24, 40, 40)];
//        kViewRadius(bottomView, 20);
//        bottomView.backgroundColor = kWhiteColor;
//        [backImage addSubview:bottomView];
//
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(24, 24, 40, 40)];
//        iconImg.image = kImage(@"邮政银行");
        [backImage addSubview:iconImg];
        
        bankNameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 12, 24, SCREEN_WIDTH - 115, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kWhiteColor];
        bankNameLbl.text = [LangSwitcher switchLang:@"中国邮政储蓄银行" key:nil];
        [backImage addSubview:bankNameLbl];
        
        
        bankTypeLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 12, bankNameLbl.yy + 1, SCREEN_WIDTH - 115, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kWhiteColor];
        bankTypeLbl.text = [LangSwitcher switchLang:@"银行卡" key:nil];
        [backImage addSubview:bankTypeLbl];
        
        
        bankNumberLbl = [UILabel labelWithFrame:CGRectMake(10, bankTypeLbl.yy + 25, SCREEN_WIDTH - 60, 33.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(24) textColor:kWhiteColor];
        
        [backImage addSubview:bankNumberLbl];
        
        
        
        UIButton *defaultBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"设为默认" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12];
        defaultBtn.frame = CGRectMake( 15 + 24,13 + bankNumberLbl.yy + 11, 150, 16.5);
        self.defaultBtn = defaultBtn;
        defaultBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [defaultBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"Oval1") forState:(UIControlStateNormal)];
            [button setImage:kImage(@"Oval2") forState:(UIControlStateSelected)];
        }];
        [self addSubview:defaultBtn];
        
        
        UIButton *deleteBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"解绑" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 39 - 100 ,13 + bankNumberLbl.yy + 11, 100, 16.5);
        self.deleteBtn = deleteBtn;
        deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:deleteBtn];
        
    }
    return self;
}


-(void)setModels:(MyBankCardModel *)models
{
    
    [backImage sd_setImageWithURL:[NSURL URLWithString:[models.background convertImageUrl]]];
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[models.icon convertImageUrl]]];
    bankNameLbl.text = models.bankName;
    if ([models.bankName isEqualToString:@"支付宝"]) {
        bankTypeLbl.text = @"";
    }
    else
    {
        bankTypeLbl.text = @"银行卡";
    }
    NSString *number;
    if (models.bankcardNumber.length > 4) {
        number = [models.bankcardNumber substringFromIndex:models.bankcardNumber.length - 4];
    }else
    {
        number = models.bankcardNumber;
    }
    bankNumberLbl.text = [NSString stringWithFormat:@"****  ****  ****  %@",number];
    if ([models.isDefault isEqualToString:@"1"]) {
        self.defaultBtn.selected = YES;
    }else
    {
        self.defaultBtn.selected = NO;
    }
}

@end
