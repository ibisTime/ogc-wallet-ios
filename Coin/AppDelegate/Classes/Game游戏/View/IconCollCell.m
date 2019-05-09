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

        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
//        self.scrollView.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

-(void)setDataArray:(NSMutableArray<FindTheGameModel *> *)dataArray
{
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH/3 * dataArray.count, 0);
    for (int i = 0; i < dataArray.count; i ++) {
        
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn theme_setBackgroundImageIdentifier:BackColor forState:(UIControlStateNormal) moduleName:ColorName];
        backBtn.frame = CGRectMake(i % dataArray.count * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 110);
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backBtn.tag = i;
        [self.scrollView addSubview:backBtn];
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 - 30, 10, 60, 60)];
        [backBtn addSubview:iconImage];
        self.iconImage = iconImage;
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, iconImage.yy + 10, SCREEN_WIDTH/3, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        [backBtn addSubview:nameLbl];
        self.nameLbl = nameLbl;
        
        [iconImage sd_setImageWithURL:[NSURL URLWithString:[dataArray[i].icon convertImageUrl]]];
        self.nameLbl.text = dataArray[i].name;
        
    }
}

-(void)backBtnClick:(UIButton *)sender
{
    [_delegate IconCollDelegateSelectBtn:sender.tag];
}

@end
