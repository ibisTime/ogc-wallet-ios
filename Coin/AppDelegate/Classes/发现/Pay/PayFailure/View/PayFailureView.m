//
//  PayFailureView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PayFailureView.h"
#define WIDTH (SCREEN_WIDTH - kWidth(30))
@implementation PayFailureView

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
        
        UIButton *stateBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"已取消" key:nil] titleColor:kHexColor(@"#333333 ") backgroundColor:kClearColor titleFont:17];
        [stateBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [stateBtn setImage:kImage(@"已取消-详情") forState:(UIControlStateNormal)];
        }];
        stateBtn.frame = CGRectMake(0, kHeight(25), WIDTH, kHeight(24));
        [backView addSubview:stateBtn];
        
        

        
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(0, stateBtn.yy + kHeight(18), WIDTH, kHeight(23)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(25) textColor:[UIColor blackColor]];
        priceLbl.text = [LangSwitcher switchLang:@"买入 0.3456577BTC" key:nil];
        [backView addSubview:priceLbl];
        
        UILabel *allPriceLbl = [UILabel labelWithFrame:CGRectMake(0, priceLbl.yy + kHeight(14), WIDTH, kHeight(16)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kTabbarColor];
        allPriceLbl.text = [LangSwitcher switchLang:@"总价 ¥100" key:nil];
        [backView addSubview:allPriceLbl];
        
        
        UILabel *stateLbl = [UILabel labelWithFrame:CGRectMake(0, allPriceLbl.yy + kHeight(22), WIDTH, kHeight(12)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        stateLbl.text = [LangSwitcher switchLang:@"用户已取消订单" key:nil];
        [backView addSubview:stateLbl];
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(180), SCREEN_WIDTH - kWidth(60), 1)];
        lineView.backgroundColor = kLineColor;
        [backView addSubview:lineView];
        
    
        
        NSArray *nameArray = @[@"订单编号",@"类型",@"单价",@"下单时间"];
        NSArray *contentArray = @[@"656787868779",@"买入",@"¥567",@"2018-09-23 12:00:00"];
        for (int i = 0; i < 4; i ++) {
            
            
            UIView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(14.5), lineView.yy + kHeight(15) + i % 4 * kHeight(50), WIDTH - kWidth(29), kHeight(50))];
            [backView addSubview:bottomIV];
            
            
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, kWidth(70), kHeight(50)) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#666666")];
            nameLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
            [bottomIV addSubview:nameLabel];
            
            
            
            UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(nameLabel.xx + 10, 0, WIDTH  - kWidth(29) - nameLabel.xx - 10, kHeight(50)) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
            contentLbl.text = contentArray[i];
            [bottomIV addSubview:contentLbl];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight(50) - 1, WIDTH - kWidth(29), 1)];
            lineView.backgroundColor = kLineColor;
            [bottomIV addSubview:lineView];
            
        }
        
        
        
        
        
        
    }
    return self;
}


@end
