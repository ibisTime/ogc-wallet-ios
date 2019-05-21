//
//  SLNodeTableViewCell.m
//  MultilevelList
//
//  Created by 王双龙 on 2019/1/11.
//  Copyright © 2019年 https://www.jianshu.com/u/e15d1f644bea. All rights reserved.
//

#import "SLNodeTableViewCell.h"

@interface SLNodeTableViewCell ()
{
    UILabel *phoneLbl;
    UILabel *allmMillLbl;
    UILabel *yesterdayMillLbl;
    UILabel *allCommissionLbl;
    UILabel *yesterdayCommissionLbl;
}

@property (nonatomic, strong) UILabel *nameLabel; // 名字
@property (nonatomic, strong) UIButton *expandBtn; // 展开按钮
@property (nonatomic, strong) UIView *line; // 细线

@end

@implementation SLNodeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _selectedBtn = [[UIButton alloc] init];
//        [_selectedBtn addTarget:self action:@selector(selectedClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_selectedBtn];
        
        
        
        phoneLbl = [UILabel labelWithFrame:CGRectMake(15, 15.5, (SCREEN_WIDTH - 60)/2, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:nil];
        phoneLbl.text = @"18839802894";
        [phoneLbl sizeToFit];
        phoneLbl.frame = CGRectMake(15, 15.5, phoneLbl.width, 22.5);
        [self addSubview:phoneLbl];
        
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLbl.xx + 6, 17.5, 36, 19)];
        _nameLabel.font = FONT(11);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = kWhiteColor;
        _nameLabel.backgroundColor = kHexColor(@"#F4AC71");
        kViewRadius(_nameLabel, 2);
        [self.contentView addSubview:_nameLabel];
        
        
        allmMillLbl = [UILabel labelWithFrame:CGRectMake(15, phoneLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        allmMillLbl.text = @"总水滴型号：10滴";
        [allmMillLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:allmMillLbl];
        
        yesterdayMillLbl = [UILabel labelWithFrame:CGRectMake(15, allmMillLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        yesterdayMillLbl.text = @"昨日水滴型号：8滴";
        [yesterdayMillLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:yesterdayMillLbl];
        
        
        
        allCommissionLbl = [UILabel labelWithFrame:CGRectMake(allmMillLbl.xx, 26.5, (SCREEN_WIDTH - 60)/2, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(18) textColor:nil];
        allCommissionLbl.text = @"总提成：3HEY";
        [self addSubview:allCommissionLbl];
        
        yesterdayCommissionLbl = [UILabel labelWithFrame:CGRectMake(allmMillLbl.xx, allCommissionLbl.yy + 5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        yesterdayCommissionLbl.text = @"昨日提成：2HEY";
        [yesterdayCommissionLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:yesterdayCommissionLbl];
        
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(15, 95, SCREEN_WIDTH - 30, 1)];
        [_line theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self addSubview:_line];
        
        _expandBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 96)];
        _expandBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_expandBtn addTarget:self action:@selector(expandBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_expandBtn];
        
        
        
    }
    return self;
}



#pragma mark - Help Methods

- (void)refreshCell {

    if (self.node.expand) {
//        [_expandBtn theme_setImageIdentifier:@"我的跳转" forState:(UIControlStateNormal) moduleName:ImgAddress];
        [_expandBtn setImage:kImage(@"上收") forState:(UIControlStateNormal)];
    }else{
//        [_expandBtn theme_setImageIdentifier:@"我的跳转" forState:(UIControlStateNormal) moduleName:ImgAddress];
        [_expandBtn setImage:kImage(@"下拉") forState:(UIControlStateNormal)];
    }
    
    
    phoneLbl.text = self.node.mobile;
    allmMillLbl.text = [NSString stringWithFormat:@"总水滴型号：%@滴",self.node.totalPerformance];
    yesterdayMillLbl.text = [NSString stringWithFormat:@"昨日水滴型号：%@滴",self.node.yesterdayPerformance];
    NSString *totalIncome;
    if ([self.node.totalIncome floatValue] == 0) {
        totalIncome = @"0";
    }else
    {
        totalIncome = [CoinUtil convertToRealCoin:self.node.totalIncome
                                             coin:@"HEY"];
    }
    NSString *yesterdayIncome;
    if ([self.node.yesterdayIncome floatValue] == 0) {
        yesterdayIncome = @"0";
    }else
    {
        yesterdayIncome = [CoinUtil convertToRealCoin:self.node.yesterdayIncome
                                                 coin:@"HEY"];
    }
    
    allCommissionLbl.text = [NSString stringWithFormat:@"总提成：%@HEY",totalIncome];
    yesterdayCommissionLbl.text = [NSString stringWithFormat:@"昨日提成：%@HEY",yesterdayIncome];
    
    
    int testNum = self.node.level;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:testNum]];
    _nameLabel.text = [NSString stringWithFormat:@"%@代",string];
    
    if (_node.leaf) {
        _expandBtn.hidden = YES;
    }else{
        _expandBtn.hidden = NO;
    }
    
    _line.frame = CGRectMake(15 + 30 * (self.node.level - 1), 95, SCREEN_WIDTH - 15 - 15 - 30 * (self.node.level - 1), 1);
    
}

#pragma mark - Event Handle

- (void)selectedClicked:(UIButton *)btn {

}

- (void)expandBtnClicked:(UIButton *)btn {
    if (!self.node.expand) {
        [_expandBtn setImage:kImage(@"上收") forState:(UIControlStateNormal)];
    }else{
        [_expandBtn setImage:kImage(@"下拉") forState:(UIControlStateNormal)];;
    }
    self.node.expand = !self.node.expand;
    if ([self.delegate respondsToSelector:@selector(nodeTableViewCell:expand:atIndexPath:)]) {
        [self.delegate nodeTableViewCell:self expand:self.node.expand atIndexPath:self.cellIndexPath];
    }
}

@end
