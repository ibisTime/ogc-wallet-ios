//
//  OrderRecordCell.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "OrderRecordCell.h"

@implementation OrderRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(14, 18, 30, 30)];
        [self addSubview:_headImg];
        
        _nameLbl = [UILabel labelWithFrame:CGRectMake(60, 14.5, 100, 14) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#333333")];
        
        [self addSubview:_nameLbl];
        
        
        _stateLbl = [UILabel labelWithFrame:CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [self addSubview:_stateLbl];
        
        
        _timeLbl = [UILabel labelWithFrame:CGRectMake(60, 43.5, 0, 11) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#333333")];
        [self addSubview:_timeLbl];
        
        
        _stateLbl2 = [UILabel labelWithFrame:CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kHexColor(@"#999999")];
        [self addSubview:_stateLbl2];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 65, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

-(void)setRow:(NSInteger)row
{
    switch (row) {
        case 0:
        {
            self.headImg.image = kImage(@"待支付-订单");
            
            _nameLbl.text = @"BTC";
            [_nameLbl sizeToFit];
            _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
            
            _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
            _stateLbl.text = @"剩余付款时间：09分30秒";
            _stateLbl.font = FONT(12);
            _stateLbl.textColor = kHexColor(@"#0EC55B");
            
            _timeLbl.text = @"2018-06-19 10:25";
            [_timeLbl sizeToFit];
            _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
            
            _stateLbl2.text = @"待支付";
            _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
            _stateLbl2.textColor = kHexColor(@"#0EC55B");
        }
            break;
        case 1:
        {
            self.headImg.image = kImage(@"已取消-订单");
            
            _nameLbl.text = @"BTC";
            [_nameLbl sizeToFit];
            _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
            
            _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
            _stateLbl.text = @"用户取消订单";
            _stateLbl.font = FONT(12);
            _stateLbl.textColor = kHexColor(@"#999999");
            
            _timeLbl.text = @"2018-06-19 10:25";
            [_timeLbl sizeToFit];
            _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
            
            _stateLbl2.text = @"已取消";
            _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
            _stateLbl2.textColor = kHexColor(@"#999999");
        }
            break;
        case 2:
        {
            
            self.headImg.image = kImage(@"已完成-订单");
            _nameLbl.text = @"BTC";
            [_nameLbl sizeToFit];
            _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
            
            _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
            _stateLbl.text = @"-0.0894";
            _stateLbl.font = FONT(14);
            _stateLbl.textColor = kHexColor(@"#333333");
            
            _timeLbl.text = @"2018-06-19 10:25";
            [_timeLbl sizeToFit];
            _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
            
            _stateLbl2.text = @"已完成";
            _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
            _stateLbl2.textColor = kHexColor(@"#D53D3D");
        }
            break;
        case 3:
        {
            self.headImg.image = kImage(@"已超时-订单");
            _nameLbl.text = @"BTC";
            [_nameLbl sizeToFit];
            _nameLbl.frame = CGRectMake(60, 14.5, _nameLbl.width, 14);
            
            _stateLbl.frame = CGRectMake(_nameLbl.xx, 11.5, SCREEN_WIDTH - _nameLbl.xx- 15, 16.5);
            _stateLbl.text = @"订单超时";
            _stateLbl.font = FONT(12);
            _stateLbl.textColor = kHexColor(@"#999999");
            
            _timeLbl.text = @"2018-06-19 10:25";
            [_timeLbl sizeToFit];
            _timeLbl.frame = CGRectMake(60, 43.5, _timeLbl.width, 11);
            
            _stateLbl2.text = @"已取消";
            _stateLbl2.frame = CGRectMake(_timeLbl.xx, 40, SCREEN_WIDTH - _timeLbl.xx- 15, 15);
            _stateLbl2.textColor = kHexColor(@"#999999");
        }
            break;
            
        default:
            break;
    }
}


@end
