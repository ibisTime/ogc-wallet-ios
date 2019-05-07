//
//  MineHeaderView.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/9.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "MineHeaderView.h"
@interface MineHeaderView()

//背景
@property (nonatomic, strong) UIImageView *bgIV;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //
        [self initSubvies];

    }
    return self;
}

#pragma mark - Init
- (void)initSubvies {
    

    
//    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200 - 64 + kNavigationBarHeight)];
//    topImage.image = kImage(@"Mask");
//    [self addSubview:topImage];

//    [self theme_setBackgroundColorIdentifier:@"self.view.back" moduleName:@"homepage"];
    
    UILabel *titleLab  = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:18.0];
    titleLab.frame = CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 44);
    [self addSubview:titleLab];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = [LangSwitcher switchLang:@"我的" key:nil];


    self.photoBtn = [UIButton buttonWithTitle:nil titleColor:kAppCustomMainColor backgroundColor:kWhiteColor titleFont:30 cornerRadius:75/2.0];
    self.photoBtn = [UIButton buttonWithImageName:@"头像" cornerRadius:58/2.0];
    [self.photoBtn setBackgroundImage:kImage(@"头像") forState:UIControlStateNormal];
    [self.photoBtn addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:self.photoBtn];
    if ([TLUser user].photo)
    {
        [self.photoBtn sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].photo convertImageUrl]] forState:UIControlStateNormal];
    }
    else
    {
        [self.photoBtn setImage:kImage(@"头像") forState:UIControlStateNormal];
    }
    
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@58);
        make.height.equalTo(@58);
        make.left.equalTo(@(35));
        make.top.equalTo(@(82 - 64 + kNavigationBarHeight));

    }];
    

    
    //昵称
    self.nameLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:22];
    self.nameLbl.userInteractionEnabled = YES;
    self.nameLbl.text = [TLUser user].nickname;
    self.nameLbl.font = HGboldfont(22);
    [self addSubview:self.nameLbl];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(87 - 64 + kNavigationBarHeight);
        make.left.equalTo(self.photoBtn.mas_right).offset(15);
        make.height.equalTo(@24);
    }];
    UIImageView *phone = [[UIImageView alloc] init];
    phone.image = kImage(@"手机");
    [self addSubview:phone];
    
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLbl.mas_left).offset(0);
//        make.top.equalTo(self.nameLbl.mas_bottom).offset(12);
        make.bottom.equalTo(self.photoBtn.mas_bottom).offset(-6);
        make.width.equalTo(@9);
        make.height.equalTo(@12);

    }];
    //手机号
    
    self.mobileLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:14.0];
    if ([TLUser isBlankString:[TLUser user].mobile] == YES) {
        self.mobileLbl.text = [NSString stringWithFormat:@"%@", [TLUser user].email];
    }else
    {
        self.mobileLbl.text = [NSString stringWithFormat:@"%@", [TLUser user].mobile];
    }
    [self addSubview:self.mobileLbl];
    [self.mobileLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(phone.mas_right).offset(4);
        make.centerY.equalTo(phone.mas_centerY);
        make.height.equalTo(@14);

    }];



}

//- (void)initBuyAndSell {
//
//    NSArray *textArr = @[[LangSwitcher switchLang:@"我要购买" key:nil],
//                         [LangSwitcher switchLang:@"我要出售" key:nil]];
//
//    NSArray *imgArr = @[@"我要购买", @"我要出售"];
//
//    CGFloat btnW = kScreenWidth/2.0;
//
//    __block UIButton *lastBtn;
//
//    [textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        UIButton *btn = [UIButton buttonWithTitle:textArr[idx] titleColor:kTextColor backgroundColor:kWhiteColor titleFont:13.0];
//
//        [btn setImage:kImage(imgArr[idx]) forState:UIControlStateNormal];
//
//        btn.tag = 1100 + idx;
//
//        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//
//        [self addSubview:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(self.bgIV.mas_bottom);
//            make.left.equalTo(@(idx*btnW));
//            make.width.equalTo(@(btnW));
//            make.height.equalTo(@55);
//
//        }];
//
//
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
//
//        lastBtn = btn;
//
//    }];
//
//    UIView *lineView = [[UIView alloc] init];
//
//    lineView.backgroundColor = kLineColor;
//
//    [self addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerX.equalTo(@0);
//        make.height.equalTo(@24);
//        make.width.equalTo(@0.5);
//        make.centerY.equalTo(lastBtn.mas_centerY);
//
//    }];
//
//}

#pragma mark - Events
- (void)clickButton:(UIButton *)sender {
    
    NSInteger index = sender.tag - 1100;
    
    MineHeaderSeletedType type = index == 0 ? MineHeaderSeletedTypeBuy: MineHeaderSeletedTypeSell;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedWithType:)]) {
        
        [self.delegate didSelectedWithType:type];
        
    }
    
}

- (void)selectPhoto:(UITapGestureRecognizer *)tapGR {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedWithType:)]) {
        
        [self.delegate didSelectedWithType:MineHeaderSeletedTypePhoto];
    }
    
}

@end

