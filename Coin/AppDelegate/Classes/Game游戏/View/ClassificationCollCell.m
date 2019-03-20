//
//  ClassificationCollCell.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/3.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "ClassificationCollCell.h"

@implementation ClassificationCollCell
{
    UIButton *selectBtn;
    UIView *blueView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kBackgroundColor;
        [self addSubview:lineView];
        
        NSArray *array = @[@"ETHdapp",@"TRXdapp"];
        for (int i = 0; i < 2; i ++) {
            UIButton *ClassificationBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:array[i] key:nil] titleColor:kHexColor(@"#acacac") backgroundColor:kClearColor titleFont:16];
            
            ClassificationBtn.frame = CGRectMake(50 + i % 2 * (SCREEN_WIDTH/2 - 50) , 15, SCREEN_WIDTH/2 - 50, 40);
            [ClassificationBtn setTitleColor:kHexColor(@"#0064ff") forState:(UIControlStateSelected)];
            [ClassificationBtn setTitleColor:kHexColor(@"#acacac") forState:(UIControlStateNormal)];
            ClassificationBtn.titleLabel.font = HGboldfont(16);
            if (i == 0) {
                ClassificationBtn.selected = YES;
                selectBtn = ClassificationBtn;
            }
            [ClassificationBtn addTarget:self action:@selector(ClassificationBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            ClassificationBtn.tag = 200 + i;
            
            
            if (i == 0) {
                
                
                blueView = [[UIView alloc]initWithFrame:CGRectMake(ClassificationBtn.centerX - 20, 48 - 1.5 + 5, 40, 3)];
                blueView.backgroundColor = kHexColor(@"#0064ff");
                [self addSubview:blueView];
                
            }else
            {
                
            }

            
            
            
            [self addSubview:ClassificationBtn];
            
            
            
        }
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 51 - 1.5 + 5, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = kLineColor;
        [self addSubview:lineView1];
        
        
        
    }
    return self;
}

-(void)ClassificationBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    selectBtn = sender;
    [_delegate ClassificationDelegateSelectBtn:sender.tag - 200];
    [UIView animateWithDuration:0.3 animations:^{
        blueView.frame = CGRectMake(sender.centerX - 20, 48 - 1.5 + 5, 40, 3);
    }];
}

@end
