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
        
        
        

        
    }
    return self;
    
}


-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.whiteView removeFromSuperview];
    
    
    //    NSArray *array = @[@"我的好友",@"邀请有礼"];
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, dataArray.count * 60)];
    whiteView.backgroundColor = kWhiteColor;
    whiteView.layer.cornerRadius=10;
    whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
    whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
    whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self addSubview:whiteView];
    self.whiteView = whiteView;
    
    
    for (int i = 0; i < dataArray.count; i ++) {
        
        
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.frame = CGRectMake(20, i % dataArray.count * 60, SCREEN_WIDTH, 60);
        [_backBtn addTarget:self action:@selector(backView:) forControlEvents:(UIControlEventTouchUpInside)];
        _backBtn.tag = 100 + i;
        [self addSubview:_backBtn];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, i % dataArray.count * 60 + 20, 20, 20)];
        [whiteView addSubview:self.iconImageView];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImageView.image = kImage(dataArray[i][@"name"]);
        
        
        //右边箭头
        self.accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15 - 7, i % dataArray.count * 60 + 24, 7, 12)];
        [whiteView addSubview:self.accessoryImageView];
        self.accessoryImageView.image = [UIImage imageNamed:@"更多-灰色"];
        self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
        self.titleLbl.text = [LangSwitcher switchLang:dataArray[i][@"name"] key:nil];
        self.titleLbl.frame = CGRectMake(self.iconImageView.xx + 10, i % dataArray.count * 60, SCREEN_WIDTH - self.iconImageView.xx - 40 - 35, 60);
        [whiteView addSubview:self.titleLbl];
        
        if (i < dataArray.count - 1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.xx + 10,59.5 + i % self.dataArray.count * 60 , SCREEN_WIDTH - 40 - self.iconImageView.xx - 10, 1)];
            line.backgroundColor = kLineColor;
            [whiteView addSubview:line];
        }
        
    }
    
    
    
    
}

-(void)backView:(UIButton *)sender
{
    [_delegate MyCellButtonSelectTag:_dataArray[sender.tag - 100][@"name"]];
}


@end
