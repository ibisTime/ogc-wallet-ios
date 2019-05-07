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
        
        
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 80)];
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        
        NSArray *imgArray = @[@"公告",@"团队",@"推荐"];
        
        for (int i = 0; i < 3; i ++) {
            UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            backBtn.frame = CGRectMake(i % 3 * (SCREEN_WIDTH - 30)/3, 0, (SCREEN_WIDTH - 30)/3, 80);
            [self addSubview:backView];
            
            UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 30)/3/2 - 12.5 , 14, 25, 25)];
            [iconImg theme_setImageIdentifier:imgArray[i] moduleName:ImgAddress];
            [backBtn addSubview:iconImg];
            
            UILabel *iconLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, iconImg.yy + 8, (SCREEN_WIDTH - 30)/3, 20)];
            iconLbl.text = imgArray[i];
            iconLbl.textAlignment = NSTextAlignmentCenter;
            [iconLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            [backBtn addSubview:iconLbl];
        }
        
        
    }
    return self;
    
}

@end
