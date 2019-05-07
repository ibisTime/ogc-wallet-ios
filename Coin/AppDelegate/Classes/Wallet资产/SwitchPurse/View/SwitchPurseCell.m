//
//  SwitchPurseCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/6.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SwitchPurseCell.h"

@implementation SwitchPurseCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self theme_setBackgroundColorIdentifier:CellBackColor moduleName:@"homepage"];
        
        UIImageView *whiteView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 10 , 170)];
        //        我的资产背景
        [whiteView theme_setImageIdentifier:@"私钥钱包背景" moduleName:ImgAddress];
        [self addSubview:whiteView];
        
        
        
        
        UILabel *allAssetsLbl = [UILabel labelWithFrame:CGRectMake(35, 44, SCREEN_WIDTH - 80, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        allAssetsLbl.text= [LangSwitcher switchLang:@"私钥钱包 总资产（¥）" key:nil];
        [whiteView addSubview:allAssetsLbl];
        
        
        allAssetsLbl = [UILabel labelWithFrame:CGRectMake(35, 80, SCREEN_WIDTH - 80, 41) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(41) textColor:kTabbarColor];
        if ([[TLUser user].localMoney isEqualToString:@"USD"])
        {
            allAssetsLbl.text = @"≈0.00";
        }else
        {
            allAssetsLbl.text = @"≈0.00";
        }
        
        [whiteView addSubview:allAssetsLbl];
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
