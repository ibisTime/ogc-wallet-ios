//
//  SellDetalisView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/17.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "SellDetalisView.h"



#define WIDTH (SCREEN_WIDTH - kWidth(30))
@implementation SellDetalisView
{
    UIButton *stateBtn;
    UILabel *priceLbl;
    UILabel *allPriceLbl;
    UILabel *stateLbl;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(130) - kNavigationBarHeight)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(84) - kNavigationBarHeight, SCREEN_WIDTH - kWidth(30), kHeight(445.5))];
        backView.backgroundColor = kWhiteColor;
        backView.layer.cornerRadius = 10;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        stateBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"已取消" key:nil] titleColor:kHexColor(@"#333333 ") backgroundColor:kClearColor titleFont:17];
        stateBtn.frame = CGRectMake(0, kHeight(25), WIDTH, kHeight(24));
        [backView addSubview:stateBtn];
        
        
        
        
        
        priceLbl = [UILabel labelWithFrame:CGRectMake(0, stateBtn.yy + kHeight(18), WIDTH, kHeight(23)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(25) textColor:[UIColor blackColor]];
        
        [backView addSubview:priceLbl];
        
        allPriceLbl = [UILabel labelWithFrame:CGRectMake(0, priceLbl.yy + kHeight(14), WIDTH, kHeight(16)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kTabbarColor];
        
        [backView addSubview:allPriceLbl];
        
        
        stateLbl = [UILabel labelWithFrame:CGRectMake(0, allPriceLbl.yy + kHeight(22), WIDTH, kHeight(12)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        
        [backView addSubview:stateLbl];
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(180), SCREEN_WIDTH - kWidth(60), 1)];
        lineView.backgroundColor = kLineColor;
        [backView addSubview:lineView];
        
        
        
        NSArray *nameArray = @[@"订单编号",@"类型",@"单价",@"下单时间",@"收款信息"];
        
        for (int i = 0; i < 5; i ++) {
            
            
            UIView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(14.5), lineView.yy + kHeight(15) + i % 5 * kHeight(50), WIDTH - kWidth(29), kHeight(50))];
            [backView addSubview:bottomIV];
            
            
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, kWidth(70), kHeight(50)) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#666666")];
            nameLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
            [bottomIV addSubview:nameLabel];
            
            
            
            UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(nameLabel.xx + 10, 0, WIDTH  - kWidth(29) - nameLabel.xx - 10, kHeight(50)) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
            
            contentLbl.tag = 100 + i;
            [bottomIV addSubview:contentLbl];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight(50) - 1, WIDTH - kWidth(29), 1)];
            lineView.backgroundColor = kLineColor;
            [bottomIV addSubview:lineView];
            
        }
        
        
        
        
        
        
    }
    return self;
}

-(void)setModels:(OrderRecordModel *)models
{
    
    UILabel *label1 = [self viewWithTag:100];
    UILabel *label2 = [self viewWithTag:101];
    UILabel *label3 = [self viewWithTag:102];
    UILabel *label4 = [self viewWithTag:103];
    UILabel *label5 = [self viewWithTag:104];
    label1.text = models.code;
    if ([models.type isEqualToString:@"0"]) {
        label2.text = [LangSwitcher switchLang:@"买入" key:nil];
    }else
    {
        label2.text = [LangSwitcher switchLang:@"卖出" key:nil];
    }
    label3.text = [NSString stringWithFormat:@"¥%@",models.tradeAmount];
    label4.text = [models.createDatetime convertToDetailDate];
    
    NSString *number;
    if (models.receiveSubbranch.length > 4) {
        number = [models.receiveSubbranch substringFromIndex:models.receiveSubbranch.length - 4];
    }else
    {
        number = models.receiveSubbranch;
    }
    
    label5.text = [NSString stringWithFormat:@"%@ (尾号为：%@)",models.receiveBank,number];
    
    
    NSString *leftAmount = [CoinUtil convertToRealCoin:models.count coin:@"BTC"];
    if ([models.type isEqualToString:@"0"]) {
        priceLbl.text = [NSString stringWithFormat:@"%@ %@BTC",[LangSwitcher switchLang:@"买入" key:nil],leftAmount];
    }else
    {
        priceLbl.text = [NSString stringWithFormat:@"%@ %@BTC",[LangSwitcher switchLang:@"卖出" key:nil],leftAmount];
    }
    allPriceLbl.text = [NSString stringWithFormat:@"%@ ¥%@",[LangSwitcher switchLang:@"总价" key:nil],models.tradeAmount];
    
    
    [stateBtn setTitle:[LangSwitcher switchLang:@"待确认" key:nil] forState:(UIControlStateNormal)];
    [stateBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
        [stateBtn setImage:kImage(@"待确认-详情") forState:(UIControlStateNormal)];
    }];
    stateLbl.text = [LangSwitcher switchLang:@"订单已提交，平台将会在10分钟内确认并完成付款" key:nil];
}

@end
