//
//  SCPieCell.m
//  SCChart
//
//  Created by 2014-763 on 15/3/24.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import "SCPieCell.h"
#import "SCChart.h"

@interface SCPieCell()
{
    SCPieChart *chartView;
}
@end

@implementation SCPieCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];

        
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(33, 30, 140, 140)];
//        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
//        kViewRadius(backView, 70);
//        [self addSubview:backView];
        
        NSArray *colorArray = @[kHexColor(@"#6BAFFF"),kHexColor(@"#FFDA6B")];
        NSArray *nameArray = @[@"量化收益  详情 ",@"邀请收益  详情"];
        for (int i = 0; i < 2; i ++) {
            UIView *pointView = [[UIView alloc]initWithFrame:CGRectMake(205, 44 + i % 4 * 68, 10, 10)];
            pointView.backgroundColor = colorArray[i];
            kViewRadius(pointView, 2);
            [self addSubview:pointView];

            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(220, 41 + i % 4 * (51.5 + 16.5), SCREEN_WIDTH - (220) - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(12) textColor:kHexColor(@"#333333")];
            nameLabel.text = [LangSwitcher switchLang:nameArray[i] key:nil];
            [nameLabel theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
            [self addSubview:nameLabel];

            UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(220 + 90, 41 + i % 4 * (51.5 + 16.5) + 2.25, 7, 12)];
            [youImg theme_setImageIdentifier:@"我的跳转" moduleName:ImgAddress];
            [self addSubview:youImg];

            UIButton *detailsBtn = [UIButton buttonWithTitle:@"0%" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:16];
            detailsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [detailsBtn theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
            detailsBtn.frame = CGRectMake(220, 41 + i % 4 * (51.5 + 16.5), SCREEN_WIDTH - (220) - 15, 31.5 + 45);
            if (i == 0) {
                self.quantitativeButton = detailsBtn;
            }
            else
            {
                self.invitationButton = detailsBtn;
            }
        
            [self addSubview:detailsBtn];
        }



    }
    return self;
}


-(void)setModel:(MyIncomeModel *)model
{
    self.priceLabel.text = @"0.0";


//    NSString *incomeTotal1 = [CoinUtil convertToRealCoin2:model.incomeTotal setScale:10  coin:@"BTC"];
//    if (  [incomeTotal1 floatValue] < 0.0001 && [incomeTotal1 floatValue] > 0) {
//        self.priceLabel.text = @"＜0.0001";
//         self.priceLabel.adjustsFontSizeToFitWidth = YES;
//    }else
//    {
//        NSString *incomeTotal = [CoinUtil convertToRealCoin2:model.incomeTotal setScale:4  coin:@"BTC"];
//        self.priceLabel.text = incomeTotal;
//    }


//    NSString *incomeTotalStr = incomeTotal;


    [self.quantitativeButton setTitle:[NSString stringWithFormat:@"%.0f%%",[model.incomeRatioPop floatValue] * 100] forState:(UIControlStateNormal)];
//    [self.quantitativeButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
//        [self.quantitativeButton theme_setImageIdentifier:@"我的跳转" forState:(UIControlStateNormal) moduleName:ImgAddress];
//    }];

    [self.invitationButton setTitle:[NSString stringWithFormat:@"%.0f%%",[model.incomeRatioInvite floatValue] * 100] forState:(UIControlStateNormal)];

//    [self.invitationButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:5 imagePositionBlock:^(UIButton *button) {
//        [self.invitationButton theme_setImageIdentifier:@"我的跳转" forState:(UIControlStateNormal) moduleName:ImgAddress];
//    }];

    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    NSArray *items = @[
                       [SCPieChartDataItem dataItemWithValue:[model.incomeRatioPop floatValue] * 100 color:kHexColor(@"#6BAFFF") description:@""],
                       [SCPieChartDataItem dataItemWithValue:[model.incomeRatioInvite floatValue] * 100 color:kHexColor(@"#FFDA6B") description:@""],
                       ];

    chartView = [[SCPieChart alloc] initWithFrame:CGRectMake(33 + 30, 30  + 30, 80, 80) items:items];
    chartView.descriptionTextFont  = FONT(0);
    [chartView strokeChart];
    [self addSubview:chartView];

}


@end
