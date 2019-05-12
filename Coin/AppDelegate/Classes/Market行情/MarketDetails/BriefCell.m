//
//  BriefCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "BriefCell.h"

@implementation BriefCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView];
        
        NSArray *nameArray = @[@"英文名",@"简称",@"中文名",@"发行总量",@"流通总量",@"官网"];
        NSArray *contactArray = @[@"Bitcoin",@"BTC",@"比特币",@"2,100,00万",@"2,100,00万",@"官网1，官网2"];
        for (int i = 0; i < 6; i ++) {
            UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 15 + i % 6 * 35, 85, 20)];
            [nameLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            nameLbl.text = nameArray[i];
            nameLbl.font = FONT(14);
            [self addSubview:nameLbl];
            
            UILabel *contactLbl = [[UILabel alloc]initWithFrame:CGRectMake(100, 15 + i % 6 * 35, SCREEN_WIDTH - 115, 20)];
            [contactLbl theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
            contactLbl.text = contactArray[i];
            contactLbl.font = FONT(14);
            [self addSubview:contactLbl];
        }
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 225, SCREEN_WIDTH, 1)];
        [lineView1 theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:lineView1];
        
        UILabel *IntroductionLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, lineView1.yy + 20, 85, 20)];
        [IntroductionLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        IntroductionLbl.text = @"简介";
        IntroductionLbl.font = FONT(14);
        [self addSubview:IntroductionLbl];
        
        
        UILabel *IntroductionContactLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, IntroductionLbl.yy + 10, SCREEN_WIDTH - 30, 20)];
        [IntroductionContactLbl theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        IntroductionContactLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"比特币（Bitcoin）的概念最初由中本聪在2008年11月1日提出，并于2009年1月3日正式诞生。根据中本聪的思路设计发布的开源软件以及建构其上的P2P网络。比特币是一种P2P形式的虚拟的加密数字货币。点对点的传输意味着一个去中心化的支付系统。..."];
        IntroductionContactLbl.font = FONT(14);
        self.IntroductionContactLbl = IntroductionContactLbl;
        IntroductionContactLbl.numberOfLines = 0;
        [IntroductionContactLbl sizeToFit];
        [self addSubview:IntroductionContactLbl];
        
        
        
    }
    return self;
    
}


@end
