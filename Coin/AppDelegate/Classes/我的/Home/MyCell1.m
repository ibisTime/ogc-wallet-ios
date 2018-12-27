//
//  MyCell1.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "MyCell1.h"


@implementation MyCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 60)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        
        _AccountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _AccountBtn.frame = whiteView.frame;
        [self addSubview:_AccountBtn];
        
        self.iconImageView = [[UIImageView alloc] init];
        [whiteView addSubview:self.iconImageView];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImageView.image = kImage(@"账户与安全");
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(whiteView.mas_left).offset(15);
            
        }];
        
        //右边箭头
        self.accessoryImageView = [[UIImageView alloc] init];
        [whiteView addSubview:self.accessoryImageView];
        [self.accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@7);
            make.height.equalTo(@12);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(whiteView.mas_right).offset(-15);
            
        }];
        self.accessoryImageView.image = [UIImage imageNamed:@"更多-灰色"];
        
//        self.rightLabel = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:15.0];
//
//        self.rightLabel.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:self.rightLabel];
//        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.width.mas_lessThanOrEqualTo(200);
//            make.height.mas_equalTo(15.0);
//            make.right.mas_equalTo(-15);
//            make.centerY.mas_equalTo(0);
//
//        }];
        
        //
        self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
        self.titleLbl.text = [LangSwitcher switchLang:@"账户与安全" key:nil];
        [whiteView addSubview:self.titleLbl];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.lessThanOrEqualTo(self.accessoryImageView.mas_left);
        }];
        
        //
//        UIView *line = [[UIView alloc] init];
//        line.backgroundColor = kLineColor;
//        [self addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(0);
//            make.width.equalTo(self.mas_width);
//            make.height.mas_equalTo(@(kLineHeight));
//            make.bottom.equalTo(self.mas_bottom);
//        }];
        
    }
    return self;
    
}
@end
