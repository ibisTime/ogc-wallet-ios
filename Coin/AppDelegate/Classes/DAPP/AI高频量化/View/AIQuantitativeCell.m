//
//  AIQuantitativeCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeCell.h"

@implementation AIQuantitativeCell
{
    UILabel *nameLbl;
    UILabel *smbolLbl;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 140)];
        
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的backView
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2 - 30, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [nameLbl theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        
        [backView addSubview:nameLbl];
        
        smbolLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx, 0, SCREEN_WIDTH/2 - 30, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [smbolLbl theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
//        smbolLbl.text = @"BTC";
        [backView addSubview:smbolLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - 30, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [backView addSubview:lineView];
        
//        NSArray *topAry= @[@"7日",@"12.00%",@"1 BTC"];
        NSArray *bottomAry = @[@"锁仓时长",@"日息",@"起存数量"];
        for (int i = 0; i < 3; i ++) {
            
            
            
            UILabel *topLbl = [UILabel labelWithFrame:CGRectMake( i % 3 * (SCREEN_WIDTH - 30)/3, lineView.yy + 26, (SCREEN_WIDTH - 30)/3, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:nil];
//            topLbl.text = topAry[i];
            topLbl.tag = i + 100;
            [backView addSubview:topLbl];
            
            UILabel *bottomLbl = [UILabel labelWithFrame:CGRectMake( i % 3 * (SCREEN_WIDTH - 30)/3, lineView.yy + 52.5, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:nil];
            bottomLbl.text = bottomAry[i];
            [bottomLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
            [backView addSubview:bottomLbl];
            
            if (i != 2) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(topLbl.xx , lineView.yy + 27.5, 0.5, 45)];
                [line theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
                [backView addSubview:line];
            }
            
        }
        
    }
    return self;
}

-(void)setModel:(AIQuantitativeModel *)model
{
    nameLbl.text = model.name;
    smbolLbl.text = model.symbolBuy;
    UILabel *label1 = [self viewWithTag:100];
    UILabel *label2 = [self viewWithTag:101];
    UILabel *label3 = [self viewWithTag:102];
    label1.text = [NSString stringWithFormat:@"%@日",model.lockDays];
    label2.text = [NSString stringWithFormat:@"%.2f%%",[model.rate floatValue] * 100];
    label3.text = [NSString stringWithFormat:@"%@ %@",model.buyMin,model.symbolBuy];
}

@end
