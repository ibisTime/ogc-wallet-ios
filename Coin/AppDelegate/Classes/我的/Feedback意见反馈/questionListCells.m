//
//  questionListCells.m
//  Coin
//
//  Created by shaojianfei on 2018/8/5.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "questionListCells.h"

@interface questionListCells ()
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *stateLab;
@property (nonatomic ,strong) UILabel *desLab;
@property (nonatomic ,strong) UILabel *timeLab;
@property (nonatomic ,strong) UIButton *moreButton;

@end
@implementation questionListCells
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubviews];
//        self.contentView setcon
    }
    
    return self;
}

- (void)initSubviews {
    

    [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    
    self.nameLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:14];
    self.nameLab.frame = CGRectMake(15, 16, SCREEN_WIDTH/2, 22.5);
    [self addSubview:self.nameLab];

    self.stateLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:14];
    self.stateLab.frame = CGRectMake(self.nameLab.xx, 16, SCREEN_WIDTH - 37 - self.nameLab.xx, 22.5 + 21.5);
    self.stateLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.stateLab];

    self.timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:14];
    self.timeLab.frame = CGRectMake(15, self.nameLab.yy + 5, SCREEN_WIDTH/2, 16.5);
    [self addSubview:self.timeLab];
    

//    self.desLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:11];
//    self.desLab.numberOfLines = 0;
//    self.desLab.frame = CGRectMake(self.timeLab.xx , self.nameLab.yy + 5, SCREEN_WIDTH - 44 - self.timeLab.xx, 16.5);
//    self.desLab.textAlignment = NSTextAlignmentRight;
//    [self addSubview:self.desLab];
    
    self.moreButton = [UIButton buttonWithTitle:@"" titleColor:kClearColor backgroundColor:kClearColor titleFont:12];
    self.moreButton.frame = CGRectMake(SCREEN_WIDTH - 15 - 7, 75/2 - 6, 7, 12);
    [self.moreButton theme_setImageIdentifier:@"我的跳转" forState:(UIControlStateNormal) moduleName:ImgAddress];
    [self addSubview:self.moreButton];
    
    

    UIView *vi = [UIView new];
    vi.frame = CGRectMake(15, 74.5, SCREEN_WIDTH - 30, 0.5);
//    vi.backgroundColor = kHexColor(@"#F0F2F7");
    [vi theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [self addSubview:vi];


}

- (void)loadMoneys
{
 
    
}

-(void)setModel:(QuestionModel *)model
{
    _model = model;
    self.nameLab.text = [TLUser user].nickname;
    self.timeLab.text = [model.commitDatetime convertRedDate];
    if ([model.status isEqualToString:@"0"]) {
        self.stateLab.text = [LangSwitcher switchLang:@"待确认" key:nil];
    }else if ([model.status isEqualToString:@"1"])
    {
        self.stateLab.text = [LangSwitcher switchLang:@"问题解决中" key:nil];
    }else if ([model.status isEqualToString:@"2"])
    {
        self.stateLab.text = [LangSwitcher switchLang:@"反馈失败" key:nil];
    }else
    {
        self.stateLab.text = [LangSwitcher switchLang:@"反馈成功" key:nil];
    }
    
    
    
    
}



@end
