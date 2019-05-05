//
//  TLCoinWithdrawOrderCell.m
//  Coin
//
//  Created by  tianlei on 2018/1/17.
//  Copyright © 2018年  tianlei. All rights reserved.
//

#import "TLCoinWithdrawOrderCell.h"
#import "UILable+convience.h"
#import "UIColor+theme.h"
#import "TLUIHeader.h"
#import "TLCoinWithdrawModel.h"
#import "NSString+Extension.h"
#import "NSString+Date.h"

@interface TLCoinWithdrawOrderCell()
{
    NSString *str;
    NSArray *dataAry;
}

//提现金额
@property (nonatomic, strong) UILabel *coinCountLbl;

//提现币种
//@property (nonatomic, strong) UILabel *coinTypelbl;

//提现手续费
@property (nonatomic, strong) UILabel *feelbl;

//提现状态
@property (nonatomic, strong) UILabel *statusLbl;

//提现时间
@property (nonatomic, strong) UILabel *applyTimeLbl;

@property (nonatomic, strong) UILabel *toAddressLbl;

@end

@implementation TLCoinWithdrawOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    
        
        self.coinCountLbl = [UILabel labelWithFrame:CGRectZero
                                      textAligment:NSTextAlignmentLeft
                                   backgroundColor:[UIColor whiteColor]
                                              font:[UIFont systemFontOfSize:14]
                                         textColor:[UIColor textColor]];
        self.coinCountLbl.frame = CGRectMake(10, 10, SCREEN_WIDTH/2, 20);
        [self.contentView addSubview:self.coinCountLbl];
        
        
        //
        self.feelbl = [UILabel labelWithFrame:CGRectZero
                                      textAligment:NSTextAlignmentLeft
                                   backgroundColor:[UIColor whiteColor]
                                              font:[UIFont systemFontOfSize:14]
                                         textColor:[UIColor textColor]];
        self.feelbl.frame = CGRectMake(10, 35, SCREEN_WIDTH/2 - 10, 20);
        [self.contentView addSubview:self.feelbl];
        
        //状态
        self.statusLbl = [UILabel labelWithFrame:CGRectZero
                                 textAligment:NSTextAlignmentRight
                              backgroundColor:[UIColor whiteColor]
                                         font:[UIFont systemFontOfSize:14]
                                    textColor:[UIColor themeColor]];
        self.statusLbl.frame = CGRectMake(SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2 - 10, 20);
        [self.contentView addSubview:self.statusLbl];
        
        //
        self.applyTimeLbl = [UILabel labelWithFrame:CGRectZero
                                    textAligment:NSTextAlignmentRight
                                 backgroundColor:[UIColor whiteColor]
                                            font:[UIFont systemFontOfSize:14]
                                       textColor:[UIColor textColor]];
        self.applyTimeLbl.frame =  CGRectMake(SCREEN_WIDTH/2, 35, SCREEN_WIDTH/2 - 10, 20);
        [self.contentView addSubview:self.applyTimeLbl];
        
        //提币到哪个地址
        self.toAddressLbl = [UILabel labelWithFrame:CGRectZero
                                       textAligment:NSTextAlignmentLeft
                                    backgroundColor:[UIColor whiteColor]
                                               font:[UIFont systemFontOfSize:14]
                                          textColor:[UIColor textColor]];
        [self.contentView addSubview:self.toAddressLbl];
        self.toAddressLbl.numberOfLines = 0;
        self.toAddressLbl.frame =  CGRectMake(10, 60, SCREEN_WIDTH - 20, 20);
        self.toAddressLbl.lineBreakMode = NSLineBreakByCharWrapping;
        
        //
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(0.7);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        
//        [self addLayout];
    }
    return self;
    
}

//- (void)addLayout {
//
//    //左边
//    [self.coinCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.top.equalTo(self.contentView.mas_top).offset(10);
//    }];
//
//    [self.feelbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.coinCountLbl.mas_left);
//        make.top.equalTo(self.coinCountLbl.mas_bottom).offset(10);
//
//    }];
//
//    //右边
//    [self.statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.top.equalTo(self.coinCountLbl.mas_top);
//
//    }];
//
//    [self.applyTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.statusLbl.mas_right);
//        make.top.equalTo(self.statusLbl.mas_bottom).offset(10);
//    }];
//
//    [self.toAddressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.feelbl.mas_left);
//        make.right.equalTo(self.statusLbl.mas_right);
//        make.top.equalTo(self.applyTimeLbl.mas_bottom).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//
//    }];
//
//}

-(void)setTitleString:(NSString *)titleString
{
    str = titleString;
}

- (void)setWithdrawModel:(TLCoinWithdrawModel *)withdrawModel {
    
    _withdrawModel = withdrawModel;
   
    
    NSString *countStr = [CoinUtil convertToRealCoin: _withdrawModel.amount
                                                coin:_withdrawModel.currency];
    
    if ([str isEqualToString:[LangSwitcher switchLang:@"收款订单" key:nil]]) {
        NSString *normalCountStr = [NSString stringWithFormat:@"%@：%@ %@",[LangSwitcher switchLang:@"收款金额" key:nil],countStr,_withdrawModel.currency];
        self.coinCountLbl.attributedText = [self attrStrLeftLen:5 str:normalCountStr];
        NSString *toAddressStr;
        if ([TLUser isBlankString:withdrawModel.payCardNo] == YES) {
            toAddressStr = [NSString stringWithFormat:@"%@：",[LangSwitcher switchLang:@"地址" key:nil]];
        }else
        {
            toAddressStr = [NSString stringWithFormat:@"%@：%@",[LangSwitcher switchLang:@"地址" key:nil],withdrawModel.payCardNo];
        }
        
        self.toAddressLbl.attributedText = [self attrStrLeftLen:3 str:toAddressStr];;
         self.applyTimeLbl.text = [NSString stringWithFormat:@"%@",[_withdrawModel.payDatetime convertToDetailDate]];
    }else
    {
        NSString *normalCountStr = [NSString stringWithFormat:@"%@：%@ %@",[LangSwitcher switchLang:@"转出金额" key:nil],countStr,_withdrawModel.currency];
        self.coinCountLbl.attributedText = [self attrStrLeftLen:5 str:normalCountStr];
        NSString *toAddressStr;
//        = [NSString stringWithFormat:@"%@：%@",[LangSwitcher switchLang:@"转出地址" key:nil],withdrawModel.payCardNo];
        
        if ([TLUser isBlankString:withdrawModel.payCardNo] == YES) {
            toAddressStr = [NSString stringWithFormat:@"%@：",[LangSwitcher switchLang:@"转出地址" key:nil]];
        }else
        {
            toAddressStr = [NSString stringWithFormat:@"%@：%@",[LangSwitcher switchLang:@"转出地址" key:nil],withdrawModel.payCardNo];
        }
        self.toAddressLbl.attributedText = [self attrStrLeftLen:5 str:toAddressStr];
         self.applyTimeLbl.text = [NSString stringWithFormat:@"%@",[_withdrawModel.applyDatetime convertToDetailDate]];
    }
    
    //
    NSString *feeStr = [CoinUtil convertToRealCoin: _withdrawModel.feeString
                                             coin:_withdrawModel.currency];
    
    NSString *feeNormalStr =  [NSString stringWithFormat:@"%@：%@ %@",[LangSwitcher switchLang:@"手续费" key:nil],feeStr,_withdrawModel.currency];
    self.feelbl.attributedText = [self attrStrLeftLen:4 str:feeNormalStr];
    
    //
    
    
    //
    for (int i = 0; i < dataAry.count; i ++) {
        if ([dataAry[i][@"dkey"] isEqualToString:withdrawModel.status]) {
            self.statusLbl.text = dataAry[i][@"dvalue"];
        }
    }
    
    
    
   
    
}

- (NSMutableAttributedString *)attrStrLeftLen:(NSInteger)len str:(NSString *)str {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor themeColor] range:NSMakeRange(len, str.length - len)];
    
    return attrStr;
    
}

-(void)setDataArray:(NSArray *)dataArray
{
    dataAry = dataArray;
}

@end
