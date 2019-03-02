//
//  MyCell2.m
//  
//
//  Created by 郑勤宝 on 2018/12/24.
//

#import "MyCell2.h"

@implementation MyCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        

        
    }
    return self;
    
}

-(void)setDataArray:(NSArray *)dataArray
{
    
    
    
    
    
    
    
    [self.whiteView removeFromSuperview];

    
//    NSArray *array = @[@"我的好友",@"邀请有礼"];
    
    
    if (dataArray.count >= 3) {
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 120)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        self.whiteView = whiteView;
       
        
        for (int i = 0; i < 2; i ++) {
            
            
            _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            _backBtn.frame = CGRectMake(20, i % 2 * 60, SCREEN_WIDTH, 60);
            [_backBtn addTarget:self action:@selector(backView:) forControlEvents:(UIControlEventTouchUpInside)];
            _backBtn.tag = 101 + i;
            [self addSubview:_backBtn];
            
            self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, i % 2 * 60 + 20, 20, 20)];
            [whiteView addSubview:self.iconImageView];
            self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.iconImageView.image = kImage(dataArray[i + 1][@"name"]);
            
            
            //右边箭头
            self.accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15 - 7, i % 2 * 60 + 24, 7, 12)];
            [whiteView addSubview:self.accessoryImageView];
            self.accessoryImageView.image = [UIImage imageNamed:@"更多-灰色"];
            self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
            self.titleLbl.text = [LangSwitcher switchLang:dataArray[i + 1][@"name"] key:nil];
            self.titleLbl.frame = CGRectMake(self.iconImageView.xx + 10, i % 2 * 60, SCREEN_WIDTH - self.iconImageView.xx - 40 - 35, 60);
            [whiteView addSubview:self.titleLbl];
            
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.xx + 10, 59.5 , SCREEN_WIDTH - 40 - self.iconImageView.xx - 10, 1)];
        line.backgroundColor = kLineColor;
        [whiteView addSubview:line];
    }else
    {
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 120)];
        whiteView.backgroundColor = kWhiteColor;
        whiteView.layer.cornerRadius=10;
        whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
        whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制
        whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:whiteView];
        self.whiteView = whiteView;
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.frame = CGRectMake(20, 0, SCREEN_WIDTH, 60);
        [_backBtn addTarget:self action:@selector(backView:) forControlEvents:(UIControlEventTouchUpInside)];
        _backBtn.tag = 101;
        [self addSubview:_backBtn];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 20, 20)];
        [whiteView addSubview:self.iconImageView];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImageView.image = kImage(dataArray[1][@"name"]);
        
        
        //右边箭头
        self.accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15 - 7,  24, 7, 12)];
        [whiteView addSubview:self.accessoryImageView];
        self.accessoryImageView.image = [UIImage imageNamed:@"更多-灰色"];
        
        self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
        self.titleLbl.text = [LangSwitcher switchLang:dataArray[1][@"name"] key:nil];
        self.titleLbl.frame = CGRectMake(self.iconImageView.xx + 10, 0, SCREEN_WIDTH - self.iconImageView.xx - 40 - 35, 60);
        [whiteView addSubview:self.titleLbl];
    }
    
    
    
}

-(void)backView:(UIButton *)sender
{
    [_delegate MyCellButtonSelectTag:sender.tag - 100];
}

@end
