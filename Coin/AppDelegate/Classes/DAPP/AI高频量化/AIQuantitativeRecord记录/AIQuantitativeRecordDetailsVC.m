//
//  AIQuantitativeRecordDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/26.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AIQuantitativeRecordDetailsVC.h"
#define WIDTH (SCREEN_WIDTH - kWidth(30))

@interface AIQuantitativeRecordDetailsVC ()
{
    UILabel *nameLbl;
    UILabel *stateLbl;
}
@end

@implementation AIQuantitativeRecordDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(15), kHeight(84) - kNavigationBarHeight, SCREEN_WIDTH - kWidth(30), kHeight(485))];
    [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
    backView.layer.cornerRadius = 10;
    backView.layer.shadowOpacity = 0.22;// 阴影透明度
    backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    backView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self.view addSubview:backView];
    
    
    
    
    
    
    nameLbl = [UILabel labelWithFrame:CGRectMake(0, kHeight(35), WIDTH, kHeight(25)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:[UIColor blackColor]];
    //        nameLbl.text = [LangSwitcher switchLang:@"币币加BTC第一期" key:nil];
    nameLbl.text = _model.productName;
    [backView addSubview:nameLbl];
    
    
    
    stateLbl = [UILabel labelWithFrame:CGRectMake(0, nameLbl.yy + kHeight(10), WIDTH, kHeight(20)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#F59218")];
    //        stateLbl.text = [LangSwitcher switchLang:@"购买成功" key:nil];
    [backView addSubview:stateLbl];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kWidth(6), kHeight(125), SCREEN_WIDTH - kWidth(42), 1)];
    
    [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [backView addSubview:lineView];
    
    
    
    for (int i = 0; i < _dataArray.count; i ++) {
        if ([_model.status isEqualToString:_dataArray[i][@"dkey"]]) {
            stateLbl.text = self.dataArray[i][@"dvalue"];
        }
    }
    
    
        
    NSArray *nameArray = @[@"合约编号",@"购买金额",@"总收益",@"开始收益时间",@"创建时间",@"到期时间"];
    
    for (int i = 0; i < nameArray.count; i ++) {
        
        
        UIView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(14.5), lineView.yy + kHeight(30) + i % nameArray.count * kHeight(40), WIDTH - kWidth(29), kHeight(20))];
        [backView addSubview:bottomIV];
        
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, kHeight(20)) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        nameLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
        [nameLabel sizeToFit];
        nameLabel.frame = CGRectMake(0, 0, nameLabel.width, kHeight(20));
        [bottomIV addSubview:nameLabel];
        
        
        
        UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(nameLabel.xx + 10, 0, WIDTH  - kWidth(29) - nameLabel.xx - 10, kHeight(20)) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        
        contentLbl.tag = 100 + i;
        [bottomIV addSubview:contentLbl];
        
        if (i == 0) {
            contentLbl.text = _model.code;
            
        }
        if (i == 1) {
            contentLbl.text = [NSString stringWithFormat:@"%@%@",_model.investCount,_model.symbolBuy];
        }
        if (i == 2) {
            contentLbl.text = [NSString stringWithFormat:@"%@%@",_model.totalIncome,_model.symbolBuy];
        }
        if (i == 3) {
            contentLbl.text = [_model.startTime convertToDetailDate];
        }
        if (i == 4) {
            contentLbl.text = [_model.createTime convertToDetailDate];
        }
        if (i == 5) {
            contentLbl.text = [_model.endTime convertToDetailDate];
        }
    }
}
        
        
    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
