//
//  MyFriendCellCell.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/29.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "MyFriendCellCell.h"

@implementation MyFriendCellCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 40, 40)];
        self.headImg.image = kImage(@"头像");
        kViewRadius(self.headImg, 20);
        [self addSubview:_headImg];
        
        _nameLabel = [UILabel labelWithFrame:CGRectMake(_headImg.xx + 11, 0, SCREEN_WIDTH - _headImg.xx - 11 - 15 - 140, 70) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kTextColor];
        _nameLabel.text = @"";
        [self addSubview:_nameLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        _timeLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 155, 0, 140, 70) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor];
        _timeLabel.text = @"";
        [self addSubview:_timeLabel];
        
    }
    return self;
}

-(void)setModel:(MyFriendModel *)model
{
    _nameLabel.text = model.loginName;
    if ([TLUser isBlankString:model.photo] == YES) {
        self.headImg.image = kImage(@"头像");
    }else
    {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[model.photo convertImageUrl]]];
    }
    _timeLabel.text = [model.createDatetime convertToDetailDate];
}

@end
