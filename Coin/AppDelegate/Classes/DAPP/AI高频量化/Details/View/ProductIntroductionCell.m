//
//  ProductIntroductionCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/22.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "ProductIntroductionCell.h"

@implementation ProductIntroductionCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        [nameLbl theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        nameLbl.text = @"产品介绍";
        [self addSubview:nameLbl];
        
        UILabel *detailsLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy, SCREEN_WIDTH - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        self.detailsLbl = detailsLbl;
        [detailsLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        detailsLbl.numberOfLines = 0;
        detailsLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"无论是做内容营销还是产品市场,内容体系的完整性非常重要。而内容体系里面,文字性的内容,产品相关的内容,都是主力。"];
        [detailsLbl sizeToFit];
        [self addSubview:detailsLbl];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
