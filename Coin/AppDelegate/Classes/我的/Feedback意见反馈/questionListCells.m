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
    self.stateLab.frame = CGRectMake(self.nameLab.xx, 16, SCREEN_WIDTH - 44 - self.nameLab.xx, 22.5);
    self.stateLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.stateLab];

    self.timeLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:14];
    self.timeLab.frame = CGRectMake(15, self.nameLab.yy + 5, SCREEN_WIDTH/2, 16.5);
    [self addSubview:self.timeLab];
    

    self.desLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:11];
    self.desLab.numberOfLines = 0;
    self.desLab.frame = CGRectMake(self.timeLab.xx , self.nameLab.yy + 5, SCREEN_WIDTH - 44 - self.timeLab.xx, 16.5);
    self.desLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.desLab];
    
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
    if ([model.status isEqualToString:@"0"]) {
        self.stateLab.text = [LangSwitcher switchLang:@"待确认" key:nil];
//        self.stateLab.textColor = kHexColor(@"#007AFF ");
        self.desLab.text = [LangSwitcher switchLang:@"奖励确认中" key:nil];
        self.timeLab.text = [model.commitDatetime convertRedDate];
    }else if ([model.status isEqualToString:@"1"])
    {
        
        self.stateLab.text = [LangSwitcher switchLang:@"已确认,待奖励" key:nil];
        self.stateLab.textColor = kTextColor2;
        NSString *type ;
        if ([self.model.level isEqualToString:@"1"]) {
            type = [LangSwitcher switchLang:@"严重缺陷" key:nil];
        }else if ([self.model.level isEqualToString:@"2"])
        {
            type = [LangSwitcher switchLang:@"一般缺陷" key:nil];

        }else{
            type = [LangSwitcher switchLang:@"优化缺陷" key:nil];

        }

        self.desLab.text = [LangSwitcher switchLang:@"奖励发放中" key:nil];
        self.timeLab.text = [model.commitDatetime convertRedDate];
        
    }else if ([model.status isEqualToString:@"2"])
    {
        
        self.stateLab.text = [LangSwitcher switchLang:@"复现不成功" key:nil];
        self.stateLab.textColor = kHexColor(@"#FE4F4F");
        self.desLab.text = [LangSwitcher switchLang:@"奖励0" key:nil];
        self.timeLab.text = [model.commitDatetime convertRedDate];
        
    }
    else
    {
        
        self.stateLab.text = [LangSwitcher switchLang:@"已领取" key:nil];
        self.stateLab.textColor = kTextColor2;
        NSString *type ;
        if ([self.model.level isEqualToString:@"1"]) {
            type = [LangSwitcher switchLang:@"严重缺陷" key:nil];
        }else if ([self.model.level isEqualToString:@"2"])
        {
            type = [LangSwitcher switchLang:@"一般缺陷" key:nil];
            
        }else{
            type = [LangSwitcher switchLang:@"优化缺陷" key:nil];
            
        }
        
        CoinModel *currentCoin = [CoinUtil getCoinModel:@"WAN"];
        
//        NSString *leftAmount = [model.payAmount subNumber:currentCoin.withdrawFeeString];
        NSString *text =  [CoinUtil convertToRealCoin:model.payAmount coin:@"WAN"];

        
        NSString *str = [NSString stringWithFormat:@"%@%.2fwan-%@,,%@%@%@",[LangSwitcher switchLang:@"奖励" key:nil],[text floatValue],type,[LangSwitcher switchLang:@"已于" key:nil],model.repairVersionCode,[LangSwitcher switchLang:@"版本修复" key:nil]];
        
     
//        NSString *text1 =  [CoinUtil convertToRealCoin:model.payAmount coin:@"wan"];

//
        NSString *money = [NSString stringWithFormat:@"%@",text];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        if ([LangSwitcher currentLangType] == LangTypeEnglish) {
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:kHexColor(@"#007AFF")
                            range:NSMakeRange(6, money.length+3)];
        }else{
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:kHexColor(@"#007AFF")
                            range:NSMakeRange(2, money.length+3)];
        }
//        [attrStr addAttribute:NSForegroundColorAttributeName
//                        value:kHexColor(@"#007AFF")
//                        range:NSMakeRange(2, money.length+3)];
        self.desLab.attributedText = attrStr;
        
        self.timeLab.text = [model.commitDatetime convertRedDate];
        
    }
    
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
