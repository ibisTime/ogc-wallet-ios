//
//  AlertsCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AlertsCell.h"

@implementation AlertsCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(19.5, 0, 1, self.height)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
        UIView *dotView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 10, 10)];
        [dotView theme_setBackgroundColorIdentifier:LabelColor moduleName:ColorName];
        kViewRadius(dotView, 5);
        [self addSubview:dotView];
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(30, 12, SCREEN_WIDTH - 45, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        timeLbl.text = @"14:05:54";
        [self addSubview:timeLbl];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(30, timeLbl.yy + 11.5, SCREEN_WIDTH - 45, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kClearColor];
        nameLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"【快讯】财联社12月5日讯,华立股份、荣晟环保变更高送转预案"];;
        nameLbl.numberOfLines = 0;
        [nameLbl sizeToFit];
        [self addSubview:nameLbl];
        
        UILabel *contactLbl = [UILabel labelWithFrame:CGRectMake(30, nameLbl.yy + 7, SCREEN_WIDTH - 45, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        contactLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"迅雷链是全球区块链3.0具有代表性的主链,率先实现百万TPS高并发,秒级确认的处理能力,支持超大规模应用及实际场景落地,致力于成为探索区块链在实体产业中落地的引领者."];
        contactLbl.numberOfLines = 0;
        [contactLbl sizeToFit];
        [contactLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:contactLbl];
        
        
        UIButton *poorBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        poorBtn.frame = CGRectMake(SCREEN_WIDTH, contactLbl.yy + 11, 0, 20);
        [poorBtn setTitle:@"利空 0" forState:(UIControlStateNormal)];
        [poorBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
        [poorBtn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
        [poorBtn sizeToFit];
        poorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        poorBtn.titleLabel.font = FONT(14);
        poorBtn.frame = CGRectMake(SCREEN_WIDTH - poorBtn.width - 15 - 26, contactLbl.yy + 11, poorBtn.width + 26, 20);
        self.poorBtn = poorBtn;
        [poorBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
            [poorBtn theme_setImageIdentifier:@"利空-未点击" forState:(UIControlStateNormal) moduleName:ImgAddress];
            [poorBtn theme_setImageIdentifier:@"利空-点击" forState:(UIControlStateSelected) moduleName:ImgAddress];
        }];
        [self addSubview:poorBtn];
        
        
        UIButton *goodBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        goodBtn.frame = CGRectMake(SCREEN_WIDTH, contactLbl.yy + 11, 0, 20);
        [goodBtn setTitle:@"利好 0" forState:(UIControlStateNormal)];
        [goodBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
        [goodBtn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
        [goodBtn sizeToFit];
        goodBtn.titleLabel.font = FONT(14);
        goodBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        goodBtn.frame = CGRectMake(SCREEN_WIDTH - goodBtn.width - 26 - poorBtn.width - 18, contactLbl.yy + 11, goodBtn.width + 26, 20);
        [goodBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
            [goodBtn theme_setImageIdentifier:@"利好-未点击" forState:(UIControlStateNormal) moduleName:ImgAddress];
            [goodBtn theme_setImageIdentifier:@"利好-点击" forState:(UIControlStateSelected) moduleName:ImgAddress];
        }];
        [self addSubview:goodBtn];
        

        lineView.frame = CGRectMake(19.5, 0, 1, goodBtn.yy + 8);
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
