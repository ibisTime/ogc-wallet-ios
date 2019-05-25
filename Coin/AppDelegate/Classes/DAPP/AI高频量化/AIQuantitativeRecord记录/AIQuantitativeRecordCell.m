//
//  AIQuantitativeRecordCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/25.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeRecordCell.h"

@implementation AIQuantitativeRecordCell
{
    UILabel *statusLbl;
    UILabel *nameLbl;
    UILabel *timeLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 165)];
        
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的backView
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        statusLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 84 - 15, 16.5, 84, 32) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#F4AC71") font:FONT(14) textColor:nil];
        statusLbl.textColor = kWhiteColor;
        statusLbl.backgroundColor = kHexColor(@"#F4AC71");
        kViewRadius(statusLbl, 2);
        [backView addSubview:statusLbl];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30 - 15 - 84 - 25, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [backView addSubview:nameLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy + 5, SCREEN_WIDTH - 30 - 15 - 84 - 25, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [backView addSubview:timeLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH - 30, 0.5)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [backView addSubview:lineView];
        
        
        NSArray *bottomAry = @[@"购买金额",@"总收益",@"到期时间"];
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

-(void)setDataArray:(NSArray *)dataArray
{
    for (int i = 0; i < dataArray.count; i ++) {
        if ([_model.status isEqualToString:dataArray[i][@"dkey"]]) {
            statusLbl.text = dataArray[i][@"dvalue"];
        }
    }
}

-(void)setModel:(AIQuantitativeRecordModel *)model
{
    _model = model;
    nameLbl.text = model.productName;
    timeLbl.text = [model.createTime convertToDetailDate];
    
    UILabel *label1 = [self viewWithTag:100];
    UILabel *label2 = [self viewWithTag:101];
    UILabel *label3 = [self viewWithTag:102];
    label1.text = [NSString stringWithFormat:@"%@%@",model.investCount,model.symbolBuy];
    label2.text = [NSString stringWithFormat:@"%@%@",model.totalIncome,model.symbolBuy];
    label3.text = [NSString stringWithFormat:@"%@",[model.endTime convertDate]];
    
//    statusLbl.text = 
    
    
//    self.timeLabel.text= [NSString stringWithFormat:@"%@%@",[model.createTime convertDate],[LangSwitcher switchLang:@"到期" key:nil]];
//    [self.timeLabel sizeToFit];
//    self.timeLabel.frame = CGRectMake(SCREEN_WIDTH - 15 - self.timeLabel.frame.size.width, 10, self.timeLabel.frame.size.width, 45);
//    [self.nameButton setTitle:@"1月理财" forState:(UIControlStateNormal)];
//    self.nameButton.frame = CGRectMake(15, 10, SCREEN_WIDTH - self.timeLabel.frame.size.width - 30 - 10, 45);
//    [self.nameButton sizeToFit];
//    self.nameButton.frame = CGRectMake(15, 10, self.nameButton.frame.size.width, 45);
//
//
//    _stateLabel.frame = CGRectMake(self.nameButton.xx, 26.5, 0, 12);
//
//    if ([model.status integerValue] == 0) {
//
//        _stateLabel.text = [LangSwitcher switchLang:@"已申购" key:nil];
//        kViewBorderRadius(_stateLabel, 3, 0.5, kTabbarColor);
//        _stateLabel.textColor = kTabbarColor;
//
//    }else if ([model.status integerValue] == 1)
//    {
//
//        _stateLabel.text = [LangSwitcher switchLang:@"已持有" key:nil];
//        kViewBorderRadius(_stateLabel, 3, 0.5, kTabbarColor);
//        _stateLabel.textColor = kTabbarColor;
//
//
//    }else if ([model.status integerValue] == 2)
//    {
//
//        _stateLabel.text = [LangSwitcher switchLang:@"已回款" key:nil];
//        kViewBorderRadius(_stateLabel, 3, 0.5, kHexColor([TLUser TextFieldPlacColor]));
//        [_stateLabel theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
//
//
//    }else if ([model.status integerValue] == 3)
//    {
//        _stateLabel.text = [LangSwitcher switchLang:@"募集失败" key:nil];
//        kViewBorderRadius(_stateLabel, 3, 0.5, [UIColor grayColor]);
//        _stateLabel.textColor = [UIColor grayColor];
//
//    }
//    [_stateLabel sizeToFit];
//
//    if (self.nameButton.xx + 15 + _stateLabel.frame.size.width + self.timeLabel.frame.size.width + 15 > SCREEN_WIDTH) {
//        self.nameButton.frame = CGRectMake(15, 10, SCREEN_WIDTH - self.timeLabel.frame.size.width - 50 - self.stateLabel.frame.size.width, 45);
//    }
//
//    _stateLabel.frame = CGRectMake(self.nameButton.xx + 5, 25.5, _stateLabel.frame.size.width + 5, 14);
    
    
//    NSString *expectIncome = [CoinUtil convertToRealCoin2:model.expectIncome setScale:4 coin:model.productInfo[@"symbol"]];
    
    //
    //    if ([expectIncome floatValue] > 10000) {
    //
    //        self.numberLabel.text = [NSString stringWithFormat:@"%.4f%@%@",[expectIncome floatValue]/10000,model.productInfo[@"symbol"],[LangSwitcher switchLang:@"万" key:nil]];
    //
    //    }else
    //    {
//    self.numberLabel.text = @"3BTC";
    //    }
    
//    [self.numberLabel sizeToFit];
//
//    self.nameLabel.frame = CGRectMake(25, 101, self.numberLabel.frame.size.width, 14);
//    self.nameLabel.numberOfLines = 2;
//    [self.nameLabel sizeToFit];
//
//    self.line.frame = CGRectMake(self.numberLabel.xx + 20, 75, 1, 39);
//
//
//
//    self.shareLabel.frame = CGRectMake(self.line.xx + 22, 76, SCREEN_WIDTH - self.line.xx - 22 -15, 14);
//    self.earningsLabel.frame =  CGRectMake(self.line.xx + 22, 100, SCREEN_WIDTH -self.line.xx - 22 - 15, 14);
    
    
//    NSString *avmount = [CoinUtil convertToRealCoin1:model.investAmount coin:model.productInfo[@"symbol"]];
//
//    NSString *shareStr1 = [LangSwitcher switchLang:@"持有份额" key:nil];
//    NSString *shareStr2 = [NSString stringWithFormat:@"%@  %@%@",[LangSwitcher switchLang:@"持有份额" key:nil],avmount,model.productInfo[@"symbol"]];
//
//    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:shareStr2];
//    [attriStr addAttribute:NSForegroundColorAttributeName value:kHexColor([TLUser TextFieldPlacColor]) range:NSMakeRange(0, shareStr1.length)];
//    self.shareLabel.attributedText = attriStr;
//
//    NSString *earningsLabel1 = [LangSwitcher switchLang:@"预期年化收益" key:nil];
//
//    NSString *str = [NSString stringWithFormat:@"%.2f%%",[model.productInfo[@"expectYield"] floatValue]*100];
//    NSString *earningsLabel2 = [NSString stringWithFormat:@"%@  %@",[LangSwitcher switchLang:@"预期年化收益" key:nil],str];
//    NSMutableAttributedString * attriStr1 = [[NSMutableAttributedString alloc] initWithString:earningsLabel2];
//    [attriStr1 addAttribute:NSForegroundColorAttributeName value:kHexColor([TLUser TextFieldPlacColor]) range:NSMakeRange(0, earningsLabel1.length)];
//    self.earningsLabel.attributedText = attriStr1;
//    self.earningsLabel.numberOfLines = 2;
//    [self.earningsLabel sizeToFit];
//
//    self.line.frame = CGRectMake(self.numberLabel.xx + 20, 75, 1, 39 - 12 + self.earningsLabel.frame.size.height);
    
}

@end
