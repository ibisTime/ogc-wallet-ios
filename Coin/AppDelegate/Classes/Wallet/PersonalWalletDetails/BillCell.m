//
//  BillCell.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/12.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "BillCell.h"
#import "AppColorMacro.h"
#import "TLUIHeader.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface BillCell ()

@property (nonatomic, strong) UIImageView *iconIV;

@property (nonatomic,strong) UILabel *moneyLbl;

@property (nonatomic,strong) UILabel *detailLbl;

@property (nonatomic, strong) UILabel *dayLbl;

//@property (nonatomic,strong) UILabel *timeLbl;
//@property (nonatomic,strong) UILabel *introduceLab;

@end

@implementation BillCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 27.5, 30, 30)];
        self.iconIV.contentMode = UIViewContentModeScaleAspectFill;
        self.iconIV.layer.cornerRadius = 15;
        self.iconIV.clipsToBounds = YES;
        [self addSubview:self.iconIV];

        
        
        _nameLabel = [UILabel labelWithFrame:CGRectMake(self.iconIV.xx + 15, 12.5, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:[UIColor blackColor]];
        [self addSubview:_nameLabel];
        
        //
        self.dayLbl = [UILabel labelWithFrame:CGRectMake(self.iconIV.xx + 15, _nameLabel.yy, SCREEN_WIDTH - self.iconIV.xx - 15, 20) textAligment:NSTextAlignmentLeft
                              backgroundColor:[UIColor clearColor]
                                         font:Font(11.0)
                                    textColor:[UIColor blackColor]];
        [self addSubview:self.dayLbl];
//        [self.dayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.iconIV.mas_right).offset(15);
//            make.top.equalTo(self.detailLbl.mas_bottom).offset(4);
//
//        }];
        
//        self.timeLbl = [UILabel labelWithFrame:CGRectMake(self.iconIV.xx + 15, _nameLabel.yy, 40, 20) textAligment:NSTextAlignmentLeft
//                               backgroundColor:[UIColor clearColor]
//                                          font:Font(12.0)
//                                     textColor:kTextColor2];
//        [self addSubview:self.timeLbl];
        

        //备注
        self.detailLbl = [UILabel labelWithFrame:CGRectMake(self.iconIV.xx + 15, _dayLbl.yy, SCREEN_WIDTH - self.iconIV.xx - 15, 20) textAligment:NSTextAlignmentLeft
                                 backgroundColor:[UIColor clearColor]
                                            font:Font(12)
                                       textColor:RGB(208, 214, 218)];
        self.detailLbl.numberOfLines = 0;
        [self addSubview:self.detailLbl];
        
        
        //钱
        self.moneyLbl = [UILabel labelWithFrame:CGRectZero textAligment:NSTextAlignmentRight
                                backgroundColor:[UIColor clearColor]
                                           font:Font(16.0)
                                      textColor:kTextColor];
        self.moneyLbl.frame = CGRectMake(SCREEN_WIDTH - 115, 12.5, 100, 20);
        [self addSubview:self.moneyLbl];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 84.5, SCREEN_WIDTH, 0.5)];
        
        line.backgroundColor = kLineColor;
        
        [self addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(15);
//            make.right.equalTo(self.mas_right).offset(-15);
//            make.height.equalTo(@(0.5));
//            make.top.equalTo(self.timeLbl.mas_bottom).offset(15);
//        }];
    }
    return self;
    
}

- (void)setBillModel:(BillModel *)billModel {
    
    _billModel = billModel;
    
    //

    NSString *moneyStr = @"";

    NSString *countStr = [CoinUtil convertToRealCoin:_billModel.transAmountString
                                                coin:billModel.currency];
    CGFloat money = [countStr doubleValue];

//    CoinModel *coin = [CoinUtil getCoinModel:billModel.currency];
    if (money > 0) {
        
//        moneyStr = [NSString stringWithFormat:@"+%@ %@",countStr , billModel.currency];
        self.moneyLbl.textColor = kHexColor(@"#47D047");

        self.iconIV.image = kImage(@"充值");
        self.nameLabel.text = [LangSwitcher switchLang:@"充值" key:nil];

//        [self.iconIV sd_setImageWithURL:[NSURL URLWithString:[coin.pic2 convertImageUrl]]];

    } else {
        self.moneyLbl.textColor = kHexColor(@"#FE4F4F");

//        moneyStr = [NSString stringWithFormat:@"%@ %@", countStr, billModel.currency];

        self.iconIV.image = kImage(@"转  出");
        self.nameLabel.text = [LangSwitcher switchLang:@"转出" key:nil];
    }
    [self.nameLabel sizeToFit];
    
    self.nameLabel.frame =  CGRectMake(self.iconIV.xx + 15, 12.5, self.nameLabel.width, 20);
    
    self.moneyLbl.frame = CGRectMake(self.nameLabel.xx + 10, 12.5, SCREEN_WIDTH - self.nameLabel.xx - 25, 20);
    self.dayLbl.text = [_billModel.createDatetime convertRedDate];

    self.detailLbl.text = billModel.bizNote;
    
    
//    [self layoutSubviews];
    
//    NSInteger num = [self.detailLbl getLinesArrayOfStringInLabel];
//    _billModel.dHeightValue = num == 1 ? 0: self.detailLbl.height - 10;
//    self.timeLbl.frame = CGRectMake(60, self.nameLabel.yy, SCREEN_WIDTH - 75, 20);

}

@end
