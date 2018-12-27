//
//  FoundHeadView.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/24.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "FoundHeadView.h"

@implementation FoundHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160 + kStatusBarHeight)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(20, 80 + kStatusBarHeight, SCREEN_WIDTH - 40, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(16) textColor:kWhiteColor];
        nameLabel.text = [LangSwitcher switchLang:@"全球首创师徒玩法，等你来体验" key:nil];
        [self addSubview:nameLabel];
        
        
        UILabel *introduceLabel = [UILabel labelWithFrame:CGRectMake(20, 110 + kStatusBarHeight , SCREEN_WIDTH - 40, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kWhiteColor];
        introduceLabel.text = [LangSwitcher switchLang:@"多种任务形式拿币拿到手软" key:nil];
        [self addSubview:introduceLabel];
        
    }
    return self;
}

@end
