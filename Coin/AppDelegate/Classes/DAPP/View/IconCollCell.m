//
//  IconCollCell.m
//  Coin
//
//  Created by 郑勤宝 on 2018/11/30.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "IconCollCell.h"

#define WIDTH SCREEN_WIDTH/3

@implementation IconCollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
//        [self.scrollView theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [self addSubview:self.scrollView];
        
//        self.scrollView.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

-(void)setDataArray:(NSMutableArray<FindTheGameModel *> *)dataArray
{
    self.scrollView.contentSize = CGSizeMake(WIDTH * dataArray.count, 0);
    for (int i = 0; i < dataArray.count; i ++) {
        
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backBtn theme_setBackgroundImageIdentifier:BackColor forState:(UIControlStateNormal) moduleName:ColorName];
        backBtn.frame = CGRectMake(i % dataArray.count * WIDTH, 0, WIDTH, 110);
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backBtn.tag = i;
//        [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
        [backBtn theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
        [self.scrollView addSubview:backBtn];
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 20, 20, 40, 40)];
        [backBtn addSubview:iconImage];
        self.iconImage = iconImage;
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, iconImage.yy + 10, WIDTH, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kTextBlack];
        [backBtn addSubview:nameLbl];
        self.nameLbl = nameLbl;
        
        [iconImage sd_setImageWithURL:[NSURL URLWithString:[dataArray[i].picList convertImageUrl]]];
        self.nameLbl.text = dataArray[i].name;
        
    }
}

-(void)backBtnClick:(UIButton *)sender
{
    [_delegate IconCollDelegateSelectBtn:sender.tag];
}

@end
