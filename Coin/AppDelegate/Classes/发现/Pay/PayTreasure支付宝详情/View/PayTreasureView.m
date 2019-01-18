//
//  PayTreasureView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PayTreasureView.h"
#define WIDTH (SCREEN_WIDTH - kWidth(30))


@implementation PayTreasureView
{
    UILabel *priceLbl;
    UILabel *payName;
    UILabel *PSLbl;
    
    OrderRecordModel *RecordModel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(130) - kNavigationBarHeight)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(84) - kNavigationBarHeight, SCREEN_WIDTH - kWidth(30), kHeight(561))];
        backView.backgroundColor = kWhiteColor;
        backView.layer.cornerRadius = 10;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        UIButton *stateBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"待支付" key:nil] titleColor:kHexColor(@"#333333 ") backgroundColor:kClearColor titleFont:17];
        [stateBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [stateBtn setImage:kImage(@"待支付-详情") forState:(UIControlStateNormal)];
        }];
        stateBtn.frame = CGRectMake(0, kHeight(25), WIDTH, kHeight(24));
        [backView addSubview:stateBtn];
        

        
        priceLbl = [UILabel labelWithFrame:CGRectMake(0, stateBtn.yy + 17.5, WIDTH, kHeight(23)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(25) textColor:[UIColor blackColor]];
        
        [backView addSubview:priceLbl];
        
        
        PSLbl = [UILabel labelWithFrame:CGRectMake(0, priceLbl.yy + kHeight(15), WIDTH, 19) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        
        [backView addSubview:PSLbl];
        
        UIButton *codePSBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        codePSBtn.frame = PSLbl.frame;
        [codePSBtn addTarget:self action:@selector(codePSBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:codePSBtn];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(145), SCREEN_WIDTH - kWidth(60), 1)];
        lineView.backgroundColor = kLineColor;
        [backView addSubview:lineView];
        
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(13.5), lineView.yy + kHeight(17), kWidth(48), kHeight(24))];
        iconImage.image = kImage(@"详情-支付背景");
        [backView addSubview:iconImage];
        
        
        UIImageView *nameImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(14.3), iconImage.height/2 - kHeight(6), kWidth(16.5), kHeight(12))];
        nameImage.image = kImage(@"支付宝-详情");
        [iconImage addSubview:nameImage];
        
        
        UIButton *copyBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"一键复制" key:nil] titleColor:kHexColor(@"#4064E6") backgroundColor:kClearColor titleFont:14];
        [copyBtn addTarget:self action:@selector(copyBtn) forControlEvents:(UIControlEventTouchUpInside)];
        copyBtn.frame = CGRectMake(SCREEN_WIDTH, lineView.yy + kHeight(15.5), 0, kHeight(20));
        [copyBtn sizeToFit];
        copyBtn.frame = CGRectMake(WIDTH - kWidth(16.5) - copyBtn.width, lineView.yy + kHeight(15.5), copyBtn.width, kHeight(20));
        [backView addSubview:copyBtn];
        
        
        payName = [UILabel labelWithFrame:CGRectMake(iconImage.xx + kWidth(10), lineView.yy + kHeight(17.5), SCREEN_WIDTH - kWidth(60) - copyBtn.width - iconImage.width, kHeight(18.5)) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#666666")];
        
        [backView addSubview:payName];
        
        UIView *payLine = [[UIView alloc]initWithFrame:CGRectMake(iconImage.xx  , iconImage.yy - 1, SCREEN_WIDTH - iconImage.xx - 16.5 - kWidth(30), 1)];
        payLine.backgroundColor = kHexColor(@"#3D92EF");
        [backView addSubview:payLine];
        
        UIView *promptView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(13.5), payLine.yy + kHeight(15), WIDTH - kWidth(27), kHeight(27))];
        promptView.backgroundColor = kHexColor(@"#FFF6EF");
        [backView addSubview:promptView];
        
        
        UILabel *promptName = [UILabel labelWithFrame:CGRectMake(5, 0,  WIDTH - kWidth(27) - 10, kHeight(27)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FA7D0E")];
        promptName.text = [LangSwitcher switchLang:@"请按以下方式付款，转账请务必填写转账附言码" key:nil];
        promptName.numberOfLines = 2;
        [promptView addSubview:promptName];
        
        
        UIImageView *tutorialImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - kWidth(180)/2, promptView.yy + kHeight(9), kWidth(360)/2, kHeight(201.5))];
        tutorialImg.image = kImage(@"支付宝付款教程");
        [backView addSubview:tutorialImg];
        
        UIButton *promptBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"收款账户经过平台认证，请放心付款" key:nil] titleColor:kHexColor(@"#0EC55B") backgroundColor:kClearColor titleFont:12];
        promptBtn.frame = CGRectMake(0, tutorialImg.yy + kHeight(18.5), WIDTH, kHeight(16.5));
        [promptBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [promptBtn setImage:kImage(@"认证") forState:(UIControlStateNormal)];
        }];
        [backView addSubview:promptBtn];
        
        
        UIButton *completeBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"我已完成付款" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:18];
        completeBtn.frame = CGRectMake(kWidth(15), promptBtn.yy + kHeight(18.5), WIDTH - kWidth(30), kHeight(45));
        kViewRadius(completeBtn, 10);
        self.completeBtn = completeBtn;
        [backView addSubview:completeBtn];
                                                              
                                                              
        
        
    }
    return self;
}

-(void)codePSBtnClick
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    
    pasteBoard.string = RecordModel.postscript;
    
    if (pasteBoard == nil) {
        
        [TLAlert alertWithError:@"复制失败, 请重新复制"];
        
    } else {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功" key:nil]];
    }
}

-(void)copyBtn
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = RecordModel.receiveCardNo;
    if (pasteBoard == nil) {
        [TLAlert alertWithError:@"复制失败, 请重新复制"];
    } else {
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功" key:nil]];
    }
}

-(void)setModels:(OrderRecordModel *)models
{
    RecordModel = models;
    NSString *price = [NSString stringWithFormat:@"¥ %@",models.tradeAmount];
    NSMutableAttributedString *buyingAttrStr = [[NSMutableAttributedString alloc] initWithString:price];
    [buyingAttrStr addAttribute:NSFontAttributeName value:HGboldfont(18) range:NSMakeRange(0,1)];
    priceLbl.attributedText = buyingAttrStr;
    
    payName.text = models.receiveCardNo;
    
    NSString *str1 = [LangSwitcher switchLang:@"转账附言 " key:nil];
    NSString *str2 = models.postscript;
    NSString *str3 = [LangSwitcher switchLang:@"复制" key:nil];
    NSString *allStr = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    NSMutableAttributedString *PSAttrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    [PSAttrStr addAttribute:NSFontAttributeName value:HGboldfont(18) range:NSMakeRange(str1.length,str2.length)];
    [PSAttrStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(str1.length,str2.length)];
    [PSAttrStr addAttribute:NSForegroundColorAttributeName value:kTabbarColor range:NSMakeRange(str2.length + str1.length,str3.length)];
    PSLbl.attributedText = PSAttrStr;
    
}

@end
