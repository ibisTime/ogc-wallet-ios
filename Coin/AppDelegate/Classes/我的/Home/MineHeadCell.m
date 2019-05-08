//
//  MineHeadCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "MineHeadCell.h"

@implementation MineHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 80)];
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        NSArray *imgArray = @[@"公告",@"团队",@"推荐"];
        
        for (int i = 0; i < 3; i ++) {
            UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            backBtn.frame = CGRectMake(i % 3 * (SCREEN_WIDTH - 30)/3, 0, (SCREEN_WIDTH - 30)/3, 80);
            [backView addSubview:backBtn];
            backBtn.tag = 100 + i;
            [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 30)/3/2 - 12.5 , 14, 25, 25)];
            [iconImg theme_setImageIdentifier:imgArray[i] moduleName:ImgAddress];
            [backBtn addSubview:iconImg];
            
            UILabel *iconLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, iconImg.yy + 8, (SCREEN_WIDTH - 30)/3, 20)];
            iconLbl.text = imgArray[i];
            iconLbl.textAlignment = NSTextAlignmentCenter;
            [iconLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            iconLbl.font = FONT(14);
            [backBtn addSubview:iconLbl];
        }
        
        
    }
    return self;
    
}

-(void)backBtnClick:(UIButton *)sender
{
    [_delegate MineHeadDelegateSelectBtn:sender.tag];
}

@end
