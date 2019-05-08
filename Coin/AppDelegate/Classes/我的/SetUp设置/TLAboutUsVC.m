//
//  TLAboutUsVC.m
//  Coin
//
//  Created by  tianlei on 2018/1/18.
//  Copyright © 2018年  tianlei. All rights reserved.
//

#import "TLAboutUsVC.h"
#import "UIColor+theme.h"
#import "NSString+Extension.h"
#import "AppColorMacro.h"
@interface TLAboutUsVC ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *nameLbl;
@property (nonatomic, strong) UILabel *versionLbl;
@property (nonatomic, strong) UILabel *versionLbl2;
@property (nonatomic, strong) UILabel *versionLbl3;

@property (nonatomic, strong) UILabel *lastVersionLbl;
@property (nonatomic, strong) UILabel *banQuanLbl;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UILabel *phoneNumber;
@property (nonatomic, strong) UIImageView *bgImage;


@property (nonatomic, strong)  UIView *line;

@property (nonatomic, strong)  UIView *line2;

@end

@implementation TLAboutUsVC

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleText.text = [LangSwitcher switchLang:@"关于我们" key:nil];
    self.navigationItem.titleView = self.titleText;
    [self setUpUI];

    [self addLayout];
    [self data];
    
}



//
- (void)data {
    
    
    self.iconImageView.image = [UIImage imageNamed:@"版本-logo"];
    self.versionLbl.text = [LangSwitcher switchLang:[NSString stringWithFormat:@"%@  V%@",[LangSwitcher switchLang:@"版本号" key:nil],[NSString appVersionString]] key:nil];
//    self.versionLbl.text = [LangSwitcher switchLang:@"钱包是一款全新的数字货币钱包" key:nil];
    self.versionLbl2.text = [NSString stringWithFormat:@"2019%@",[LangSwitcher switchLang:@"金米钱包版权所有" key:nil]];
//    self.versionLbl3.text = [LangSwitcher switchLang:@"服务时间:  9:00 - 18:00 " key:nil];
//    self.banQuanLbl.text = [LangSwitcher switchLang:@"联系电话" key:nil];
//    self.phoneNumber.text = [LangSwitcher switchLang:@"0571-8765650" key:nil];
//
//    //
//    NSString *at = @"@";
    
    
    
}

- (NSString *)currentYear {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    return [formatter stringFromDate:[NSDate new]];
    
}

//
- (void)setUpUI {
    
    //
   
    self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.bgImage.contentMode = UIViewContentModeScaleToFill;
    self.bgImage.userInteractionEnabled = YES;
    self.bgImage.image = kImage(@"我的 背景");
    [self.view  addSubview:self.bgImage];
    
//    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
    //
    
    self.bgView = [[UIView alloc] init];
//    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    [self.bgImage addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImage.mas_top).offset(30 + kNavigationBarHeight);
        make.left.equalTo(self.bgImage.mas_left).offset(15);
        make.right.equalTo(self.bgImage.mas_right).offset(-15);
        make.height.equalTo(@(kHeight(541)));

    }];
    self.iconImageView = [[UIImageView alloc] init];
    [self.bgImage  addSubview:self.iconImageView];
//    self.iconImageView.layer.cornerRadius = 10;
//    self.iconImageView.layer.masksToBounds = YES;
    
    //
    self.nameLbl = [[UIImageView alloc] init];
    self.nameLbl.contentMode = UIViewContentModeScaleToFill;
//    self.nameLbl.image = kImage(@"THA");
    [self.bgImage addSubview:self.nameLbl];
    
    UIView *line = [[UIView alloc] init];
    [line theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    [self.bgView addSubview:line];
    self.line = line;
    UIView *line2 = [[UIView alloc] init];
    [line2 theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
    self.line2 = line2;
    [self.bgView addSubview:line2];
    //
    self.versionLbl = [UILabel labelWithFrame:CGRectZero
                                 textAligment:NSTextAlignmentCenter
                              backgroundColor:[UIColor clearColor]
                                         font:[UIFont systemFontOfSize:14]
                                    textColor:kTextColor];
    [self.bgImage addSubview:self.versionLbl];
    
    self.versionLbl2 = [UILabel labelWithFrame:CGRectZero
                                 textAligment:NSTextAlignmentCenter
                              backgroundColor:[UIColor whiteColor]
                                         font:[UIFont systemFontOfSize:12]
                                    textColor:kHexColor(@"#808080")];
    [self.bgImage addSubview:self.versionLbl2];
    
    self.versionLbl3 = [UILabel labelWithFrame:CGRectZero
                                  textAligment:NSTextAlignmentCenter
                               backgroundColor:[UIColor whiteColor]
                                          font:[UIFont systemFontOfSize:12]
                                     textColor:kHexColor(@"#808080")];
//    [self.bgImage addSubview:self.versionLbl3];
    
    //
    self.phoneView = [[UIView alloc] init];
    self.phoneView.backgroundColor = [UIColor whiteColor];
    [self.bgImage addSubview:self.phoneView];
    
    
  
    self.banQuanLbl = [UILabel labelWithFrame:CGRectZero
                                 textAligment:NSTextAlignmentRight
                              backgroundColor:[UIColor whiteColor]
                                         font:[UIFont systemFontOfSize:15]
                                    textColor:kHexColor(@"#333333")];
//    [self.phoneView addSubview:self.banQuanLbl];
    
    
    self.phoneNumber = [UILabel labelWithFrame:CGRectZero
                                 textAligment:NSTextAlignmentLeft
                              backgroundColor:[UIColor whiteColor]
                                         font:[UIFont systemFontOfSize:12]
                                    textColor:kHexColor(@"#999999")];
//    [self.phoneView addSubview:self.phoneNumber];
    self.banQuanLbl.numberOfLines = 0;
    
}

- (void)addLayout {
    
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bgImage.mas_top).offset(167.5);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(70);

        make.centerX.equalTo(self.bgImage.mas_centerX);
        
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.bgImage);
        make.width.equalTo(@90);
        make.height.equalTo(@35);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nameLbl.mas_bottom).offset(30);
        make.centerX.equalTo(self.bgImage);
        make.left.equalTo(@60);
        make.right.equalTo(@-60);
        
        make.height.equalTo(@1);

    }];
    
    [self.versionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.line.mas_bottom).offset(35);
        make.centerX.equalTo(self.bgImage);
        
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.versionLbl.mas_bottom).offset(25);
        make.centerX.equalTo(self.bgImage);
        make.left.equalTo(@60);
        make.right.equalTo(@-60);
        make.height.equalTo(@1);

    }];
    [self.versionLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(self.bgImage.mas_bottom).offset(-65);
        make.centerX.equalTo(self.bgImage);

    }];
//    [self.versionLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.versionLbl2.mas_bottom).offset(17);
//        make.centerX.equalTo(self.bgImage);
//
//    }];
//
//    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.versionLbl3.mas_bottom).offset(40);
//        make.height.equalTo(@50);
//        make.width.equalTo(@(kScreenWidth));
//        make.centerX.equalTo(self.bgImage);
//
//    }];
//    [self.banQuanLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.phoneView.mas_left).offset(15);
//        make.centerY.equalTo(self.phoneView);
//
//    }];
//    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.phoneView.mas_right).offset(-15);
//        make.centerY.equalTo(self.phoneView);
//
//    }];
//
    
}


@end
