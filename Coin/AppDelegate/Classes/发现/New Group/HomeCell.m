//
//  HomeCell.m
//  Coin
//
//  Created by haiqingzheng on 2018/4/2.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {



        UIView *applicationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 125)];

        applicationView.backgroundColor = RGB(243, 244, 249);
        [self addSubview:applicationView];

        
        
        UIImageView *iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(70/2 - 12.5, 125/2 - 15, 25, 30)];
//        iconIV.backgroundColor = kAppCustomMainColor;
        self.iconImageView = iconIV;
        [applicationView addSubview:iconIV];


        

//        UIImageView *imageView= [[UIImageView alloc] init];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        [self addSubview:imageView];
//        self.iconImageView = imageView;


        UILabel *textLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:16];
        [applicationView addSubview:textLab];

        self.textLab = textLab;

            UILabel *introfucec = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor3 font:12];
        self.introfucec = introfucec;
        [self addSubview:introfucec];

        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(70, 124, SCREEN_WIDTH - 70, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];

//            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(applicationView.mas_top).offset(22.5);
//                make.left.equalTo(applicationView.mas_left).offset(20);
//                make.width.equalTo(@55);
//                make.height.equalTo(@58);
//
//            }];





            //        [btn setTitleBottom];
//        }];

    }
    return self;
}

-(void)setFindModel:(HomeFindModel *)findModel
{
    
    NSString *url = [findModel.icon convertImageUrl];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.textLab.text = [LangSwitcher switchLang:findModel.name key:nil];
    self.introfucec.text = [LangSwitcher switchLang:findModel.slogan key:nil];
    
    self.introfucec.frame = CGRectMake(90, 0, SCREEN_WIDTH - 135, 0);
    self.introfucec.numberOfLines = 3;
    [self.introfucec sizeToFit];
    self.textLab.frame = CGRectMake(90, (125 - self.introfucec.frame.size.height - 8 - 10)/2 - 2.5, SCREEN_WIDTH - 110, 16);
    self.introfucec.frame = CGRectMake(90, self.textLab.yy + 10, SCREEN_WIDTH - 110, self.introfucec.frame.size.height);
}

@end
