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
    CGFloat width;
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [lineView theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [self addSubview:lineView];
        
        NSArray *array = @[@"游戏类",@"工具类",@"DAPP分类"];
        
        
        
        
        
        
    }
    return self;
}

-(void)setDvalueArray:(NSArray *)dvalueArray
{
    width = 15;
    
    if (_dvalueArray.count == 0) {
        for (int i = 0; i < dvalueArray.count; i ++) {
            UIButton *ClassificationBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:dvalueArray[i][@"dvalue"] key:nil] titleColor:kHexColor(@"#acacac") backgroundColor:kClearColor titleFont:16];
            
            ClassificationBtn.frame = CGRectMake(15 , 15, SCREEN_WIDTH/3 - 50, 40);
            
            //            [ClassificationBtn theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
            [ClassificationBtn theme_setTitleColorIdentifier:GaryLabelColor forState:(UIControlStateNormal) moduleName:ColorName];
//            [ClassificationBtn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
            [ClassificationBtn theme_setTitleColorIdentifier:@"tabbarselectcolor" forState:(UIControlStateSelected) moduleName:ColorName];
            ClassificationBtn.titleLabel.font = HGboldfont(16);
            if (i == 0) {
                ClassificationBtn.selected = YES;
                selectBtn = ClassificationBtn;
            }
            [ClassificationBtn sizeToFit];
            ClassificationBtn.frame = CGRectMake(width, 15, ClassificationBtn.width , 40);
            
            width = ClassificationBtn.xx + 15;
            
            [ClassificationBtn addTarget:self action:@selector(ClassificationBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            ClassificationBtn.tag = 200 + i;
            if (i == 0) {
                blueView = [[UIView alloc]initWithFrame:CGRectMake(ClassificationBtn.centerX - 12.5, 48 - 1.5 + 5, 25, 3)];
//                blueView.backgroundColor = kTabbarColor;
                [blueView theme_setBackgroundColorIdentifier:@"tabbarselectcolor" moduleName:ColorName];
                [self addSubview:blueView];
            }
            [self addSubview:ClassificationBtn];
        }
    }
    _dvalueArray = dvalueArray;
}

-(void)ClassificationBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    selectBtn = sender;
    [_delegate ClassificationDelegateSelectBtn:sender.tag - 200];
    [UIView animateWithDuration:0.3 animations:^{
        blueView.frame = CGRectMake(sender.centerX - 12.5, 48 - 1.5 + 5, 25, 3);
    }];
}

@end
