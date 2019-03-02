//
//  MyCell3.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "MyCell3.h"

@implementation MyCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        
    }
    return self;
    
}

-(void)setDataArray:(NSArray *)dataArray
{
    [self.whiteView removeFromSuperview];

    if (dataArray.count == 4) {
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 60)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        self.whiteView = whiteView;
        
        
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.frame = CGRectMake(20, 0, SCREEN_WIDTH, 60);
        [self addSubview:_backBtn];

        [_backBtn addTarget:self action:@selector(backView:) forControlEvents:(UIControlEventTouchUpInside)];
        _backBtn.tag = 103;
        
        
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,20, 20, 20)];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImageView.image = kImage(dataArray[3][@"name"]);
        [whiteView addSubview:self.iconImageView];
        
        //右边箭头
        self.accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15 - 7,  24, 7, 12)];
        self.accessoryImageView.image = [UIImage imageNamed:@"更多-灰色"];
        [whiteView addSubview:self.accessoryImageView];
        
        //
        self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
        self.titleLbl.text = [LangSwitcher switchLang:dataArray[3][@"name"] key:nil];
        self.titleLbl.frame = CGRectMake(self.iconImageView.xx + 10, 0, SCREEN_WIDTH - self.iconImageView.xx - 40 - 35, 60);
        [whiteView addSubview:self.titleLbl];
    }
    
    
    if (dataArray.count == 5) {
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 120)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];

        self.whiteView = whiteView;
        
//        NSArray *array = @[@"加入社群",@"帮助中心",@"设置"];
        for (int i = 0; i < 2; i ++) {
            _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            _backBtn.frame = CGRectMake(20, i * 60, SCREEN_WIDTH, 60);
            [self addSubview:_backBtn];
            [_backBtn addTarget:self action:@selector(backView:) forControlEvents:(UIControlEventTouchUpInside)];
            _backBtn.tag = 103 + i;
            self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, i * 60 + 20, 20, 20)];
            self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.iconImageView.image = kImage(dataArray[i + 3][@"name"]);
            [whiteView addSubview:self.iconImageView];
            
            //右边箭头
            self.accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15 - 7, i * 60 + 24, 7, 12)];
            self.accessoryImageView.image = [UIImage imageNamed:@"更多-灰色"];
            [whiteView addSubview:self.accessoryImageView];
            
            //
            self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
            self.titleLbl.text = [LangSwitcher switchLang:dataArray[i + 3][@"name"] key:nil];
            self.titleLbl.frame = CGRectMake(self.iconImageView.xx + 10, i * 60, SCREEN_WIDTH - self.iconImageView.xx - 40 - 35, 60);
            [whiteView addSubview:self.titleLbl];
            
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.xx + 10, 59.5 , SCREEN_WIDTH - 40 - self.iconImageView.xx - 10, 1)];
        line.backgroundColor = kLineColor;
        [whiteView addSubview:line];
        
    }
    if (dataArray.count == 6) {
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 180)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        self.whiteView = whiteView;
        
        for (int i = 0; i < 3; i ++) {
            
            _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            _backBtn.frame = CGRectMake(20, i * 60, SCREEN_WIDTH, 60);
            [self addSubview:_backBtn];
            [_backBtn addTarget:self action:@selector(backView:) forControlEvents:(UIControlEventTouchUpInside)];
            _backBtn.tag = 103 + i;
            
            self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, i * 60 + 20, 20, 20)];
            self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.iconImageView.image = kImage(dataArray[i + 3][@"name"]);
            [whiteView addSubview:self.iconImageView];
            
            //右边箭头
            self.accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15 - 7, i * 60 + 24, 7, 12)];
            self.accessoryImageView.image = [UIImage imageNamed:@"更多-灰色"];
            [whiteView addSubview:self.accessoryImageView];
            
            //
            self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
            self.titleLbl.text = [LangSwitcher switchLang:dataArray[i + 3][@"name"] key:nil];
            self.titleLbl.frame = CGRectMake(self.iconImageView.xx + 10, i * 60, SCREEN_WIDTH - self.iconImageView.xx - 40 - 35, 60);
            [whiteView addSubview:self.titleLbl];
            
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.xx + 10, 59.5 , SCREEN_WIDTH - 40 - self.iconImageView.xx - 10, 1)];
        line.backgroundColor = kLineColor;
        [whiteView addSubview:line];
        
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.xx + 10, 119.5 , SCREEN_WIDTH - 40 - self.iconImageView.xx - 10, 1)];
        line1.backgroundColor = kLineColor;
        [whiteView addSubview:line1];
    }
    
}

-(void)backView:(UIButton *)sender
{
    [_delegate MyCellButtonSelectTag:sender.tag - 100];
}

@end
