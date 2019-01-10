//
//  FinancialDetailsView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/9.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FinancialDetailsView.h"


#define WIDTH (SCREEN_WIDTH - kWidth(30))
@implementation FinancialDetailsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(130) - kNavigationBarHeight)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(84) - kNavigationBarHeight, SCREEN_WIDTH - kWidth(30), kHeight(485))];
        backView.backgroundColor = kWhiteColor;
        backView.layer.cornerRadius = 10;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
    
        
        
        
        
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, kHeight(35), WIDTH, kHeight(25)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:[UIColor blackColor]];
        nameLbl.text = [LangSwitcher switchLang:@"币币加BTC第一期" key:nil];
        [backView addSubview:nameLbl];
        
        
        
        UILabel *stateLbl = [UILabel labelWithFrame:CGRectMake(0, nameLbl.yy + kHeight(10), WIDTH, kHeight(20)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#F59218")];
        stateLbl.text = [LangSwitcher switchLang:@"购买成功" key:nil];
        [backView addSubview:stateLbl];
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(6), kHeight(125), SCREEN_WIDTH - kWidth(42), 1)];
        lineView.backgroundColor = kLineColor;
        [backView addSubview:lineView];
        
        
        
        NSArray *nameArray = @[@"合约编号",@"交易时间",@"产品期限",@"年收益率",@"购买金额",@"总收益",@"起息时间",@"到期时间"];
        NSArray *contentArray = @[@"208900232346890",@"018-12-12 11:03:22",@"24个月",@"10.4%",@"1000.009BTC",@"100.009BTC",@"2018-12-12",@"2018-12-12"];
        for (int i = 0; i < nameArray.count; i ++) {
            
            
            UIView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(14.5), lineView.yy + kHeight(30) + i % nameArray.count * kHeight(40), WIDTH - kWidth(29), kHeight(20))];
            [backView addSubview:bottomIV];
            
            
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, kHeight(20)) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
            nameLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
            [nameLabel sizeToFit];
            nameLabel.frame = CGRectMake(0, 0, nameLabel.width, kHeight(20));
            [bottomIV addSubview:nameLabel];
            
            
            
            UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(nameLabel.xx + 10, 0, WIDTH  - kWidth(29) - nameLabel.xx - 10, kHeight(20)) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
            contentLbl.text = contentArray[i];
            [bottomIV addSubview:contentLbl];
            
            
        }
        
        
        
        
        
        
    }
    return self;
}


@end
