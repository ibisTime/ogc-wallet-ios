//
//  AssetsHeadView.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/21.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "AssetsHeadView.h"

@implementation AssetsHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        //公告背景
        _whiteView = [[UIView alloc] init];
        _whiteView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeight(40));
        _whiteView.backgroundColor = kHexColor(@"#F7F9FC");
        [self addSubview:_whiteView];
        

        if ([LangSwitcher currentLangType] == LangTypeSimple) {
            _announcementImage.image = kImage(@"公告");
        }else{
            _announcementImage.image = kImage(@"NOTICE");
        }
        [_whiteView addSubview:_announcementImage];
        
        [_announcementImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            make.centerY.equalTo(_whiteView.mas_centerY);
            
        }];
        
        //公告
        _announcementLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:12.0];
        [_whiteView addSubview:_announcementLbl];
        _announcementLbl.frame = CGRectMake(_announcementImage.xx + 10, 0, kScreenWidth-100, kHeight(40));
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(announcement)];
        [_announcementLbl addGestureRecognizer:tap1];
        //右箭头
        _announcementDeleteBtn = [[UIImageView alloc] initWithImage:kImage(@"关闭")];
        UITapGestureRecognizer *leftSwipe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDeleteClick)];
        [_announcementDeleteBtn addGestureRecognizer:leftSwipe];
        
        [_whiteView addSubview:_announcementDeleteBtn];
        [_announcementDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(_whiteView.mas_right).offset(-15);
            make.centerY.equalTo(self.whiteView.mas_centerY);
            make.width.height.equalTo(@(16));
            
        }];
        
        
        _allAssetsLabel = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#333333") font:10];
        _allAssetsLabel.frame = CGRectMake(19, kHeight(40) + 11, SCREEN_WIDTH, 12);
        [self addSubview:_allAssetsLabel];
        
        if ([TLUser user].localMoney) {
            if ([[TLUser user].localMoney isEqualToString:@"CNY"] ) {
                _allAssetsLabel.text = [NSString stringWithFormat:@"%@",[LangSwitcher switchLang:@"总资产" key:nil]];
                
            }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
            {
                _allAssetsLabel.text = [NSString stringWithFormat:@"%@",[LangSwitcher switchLang:@"总资产" key:nil]];
                
            }
            else{
                _allAssetsLabel.text = [NSString stringWithFormat:@"%@",[LangSwitcher switchLang:@"总资产" key:nil]];
                
                
            }
        }else{
            
            _allAssetsLabel.text = [NSString stringWithFormat:@"%@",[LangSwitcher switchLang:@"总资产" key:nil]];
            
        }
        
        
            
            
            //总资产
        _allAssetsPriceLabel = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#333333") font:18.0];
        [self addSubview:_allAssetsPriceLabel];
        _allAssetsPriceLabel.frame = CGRectMake(19, kHeight(40) + 28, SCREEN_WIDTH, 18);

        
        _eyesBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_eyesBtn setImage:[UIImage imageNamed:@"眼睛"] forState:(UIControlStateNormal)];
        [_eyesBtn setImage:[UIImage imageNamed:@"闭眼"] forState:(UIControlStateSelected)];
        _eyesBtn.frame = CGRectMake(SCREEN_WIDTH - 46, kHeight(40), 46, 46);
        
        
        [_eyesBtn addTarget:self action:@selector(eyesButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _eyesBtn.backgroundColor = [UIColor whiteColor];
        [self addSubview:_eyesBtn];
            
            
            
            
            
            
            
            
        
        UIImageView *bgIV = [[UIImageView alloc] init];
        bgIV.image = kImage(@"个人钱包");
        bgIV.contentMode = UIViewContentModeScaleToFill;
        bgIV.frame = CGRectMake(19, kHeight(40) + 46 + 14, SCREEN_WIDTH - 38, kHeight(150));
        [self addSubview:bgIV];
        bgIV.userInteractionEnabled = YES;
        self.bgIV = bgIV;
        
        
        _accountNameBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"个人账户(CNY)" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:14.0];
        _accountNameBtn.frame = CGRectMake(30, kHeight(150)/2 - 27.5 - 10, SCREEN_WIDTH - 38 - 60, 15);
        [_accountNameBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:3 imagePositionBlock:^(UIButton *button) {
            [_accountNameBtn setImage:kImage(@"问号") forState:(UIControlStateNormal)];
        }];
        _accountNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_accountNameBtn addTarget:self action:@selector(accountNameBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [bgIV addSubview:_accountNameBtn];
        
        
        _priceLabel = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:30.0];
        _priceLabel.frame = CGRectMake(30, _accountNameBtn.yy + 10, SCREEN_WIDTH - 38 - 60, 30);
        [bgIV addSubview:_priceLabel];
        
        NSString *eyes = [[NSUserDefaults standardUserDefaults] objectForKey:@"eyes"];
        if ([eyes isEqualToString:@"1"]) {
            _eyesBtn.selected = YES;
            if ([TLUser user].localMoney) {
                if ([[TLUser user].localMoney isEqualToString:@"CNY"] ) {
                    
                    _allAssetsPriceLabel.text = @"¥****";
                    self.priceLabel.text = @"¥****";
                    
                }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
                {
                    _allAssetsPriceLabel.text = @"₩****";
                    self.priceLabel.text = @"₩****";
                    
                }
                else{
                    _allAssetsPriceLabel.text = @"$****";
                    self.priceLabel.text = @"$****";
                    
                    
                }
            }else{
                
                _allAssetsPriceLabel.text = @"¥****";
                self.priceLabel.text = @"¥****";
                
            }
        }
        else
        {
            _eyesBtn.selected = NO;
            if ([TLUser user].localMoney) {
                if ([[TLUser user].localMoney isEqualToString:@"CNY"] ) {
                    
                    _allAssetsPriceLabel.text = @"¥0.00";
                    self.priceLabel.text = @"¥0.00";
                    
                }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
                {
                    _allAssetsPriceLabel.text = @"₩0.00";
                    self.priceLabel.text = @"₩0.00";
                    
                }
                else{
                    _allAssetsPriceLabel.text = @"$****";
                    self.priceLabel.text = @"$0.00";
                    
                    
                }
            }else{
                
                _allAssetsPriceLabel.text = @"¥0.00";
                self.priceLabel.text = @"¥0.00";
                
            }
        }
        
        
        
        UILabel *text = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:16];
        text.text = [LangSwitcher switchLang:@"币种列表" key:nil];
        text.frame = CGRectMake(20,_bgIV.yy + 10, SCREEN_WIDTH - 40, 30);
        [self addSubview:text];
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(SCREEN_WIDTH - 40, _bgIV.yy + 10, 30, 30);
        [addButton setImage:kImage(@"增加") forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addCurrent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    NSString *eyes = [[NSUserDefaults standardUserDefaults] objectForKey:@"eyes"];
    if ([eyes isEqualToString:@"1"]) {
        if ([TLUser user].localMoney) {
            if ([[TLUser user].localMoney isEqualToString:@"CNY"] ) {
                _allAssetsPriceLabel.text = @"¥****";
                self.priceLabel.text = @"¥****";
            }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
            {
                _allAssetsPriceLabel.text = @"₩****";
                self.priceLabel.text = @"₩****";
            }
            else{
                _allAssetsPriceLabel.text = @"$****";
                self.priceLabel.text = @"$****";
            }
        }else{
            _allAssetsPriceLabel.text = @"¥****";
            self.priceLabel.text = @"¥****";
        }
    }else
    {
        if ([[TLUser user].localMoney isEqualToString:@"USD"]) {
            _allAssetsPriceLabel.text = [NSString stringWithFormat:@"$ %.2f", [[dataDic[@"totalAmountUSD"] convertToSimpleRealMoney] doubleValue]];
            _priceLabel.text = [NSString stringWithFormat:@"$ %.2f", [[dataDic[@"totalAmountUSD"] convertToSimpleRealMoney] doubleValue]];
        } else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
        {
            _allAssetsPriceLabel.text = [NSString stringWithFormat:@"₩ %.2f", [[dataDic[@"totalAmountKRW"] convertToSimpleRealMoney] doubleValue]];
            _priceLabel.text = [NSString stringWithFormat:@"₩ %.2f", [[dataDic[@"totalAmountKRW"] convertToSimpleRealMoney] doubleValue]];
        }
        else{
            _allAssetsPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", [[dataDic[@"totalAmountCNY"] convertToSimpleRealMoney] doubleValue]];
            _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f", [[dataDic[@"totalAmountCNY"] convertToSimpleRealMoney] doubleValue]];
            
        }
    }
}

-(void)accountNameBtnClick
{
    [self inreoduceView:@"个人账户" content:@"个人账户就是指中心化钱包,是由MooreBit替您保管私钥,在中心化钱包中,不存在钱包丢失了无法找回的情况,可以通过身份证找回您的钱包,并且可以让您体验到更多的服务。"];
}

-(void)announcement
{
    [_delegate AssetsHeadViewDelegateSelectBtn:0];
}

-(void)tapDeleteClick
{
    [_delegate AssetsHeadViewDelegateSelectBtn:1];
}

-(void)addCurrent
{
    [_delegate AssetsHeadViewDelegateSelectBtn:3];
}

#pragma mark -- 点击问号的方法
- (void)inreoduceView:(NSString *)name content:(NSString *)contents
{
    UIView *contentText = [UIView new];
    kViewRadius(contentText, 10);
    contentText.frame = CGRectMake(50,  -SCREEN_HEIGHT, SCREEN_WIDTH - 100, 100);
//    self.contentView = contentText;
    [self addSubview:contentText];
    contentText.backgroundColor = kWhiteColor;
    
    
    UILabel *title = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:17.0];
    title.textAlignment = NSTextAlignmentCenter;
    title.frame = CGRectMake(10, 30, SCREEN_WIDTH - 120, 20);
    title.text = [LangSwitcher switchLang:name key:nil];
    [contentText addSubview:title];
    
    
    UILabel *content = [UILabel labelWithBackgroundColor:kClearColor textColor:[UIColor grayColor] font:14];
    content.numberOfLines = 0;
    content.frame = CGRectMake(20, 70, SCREEN_WIDTH - 100 - 40, 0);
    content.attributedText = [UserModel ReturnsTheDistanceBetween:[LangSwitcher switchLang:contents key:nil]];
    [content sizeToFit];
    [contentText addSubview:content];
    
    UIButton *sureButton = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确定" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16];
    
    [contentText addSubview:sureButton];
    sureButton.layer.cornerRadius = 4.0;
    sureButton.clipsToBounds = YES;
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    sureButton.frame = CGRectMake(30, content.yy + 30, SCREEN_WIDTH - 100 - 60, 50);
    contentText.frame = CGRectMake(50, SCREEN_HEIGHT/2 - (sureButton.yy + 30)/2, SCREEN_WIDTH - 100, (sureButton.yy + 30));
    [[UserModel user] showPopAnimationWithAnimationStyle:2 showView:contentText];
}

-(void)sureClick
{
    [[UserModel user].cusPopView dismiss];
}



-(void)eyesButtonClick:(UIButton *)sender
{
    
    [_delegate AssetsHeadViewDelegateSelectBtn:2];
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"eyes"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"eyes"];
    }
    
    NSString *eyes = [[NSUserDefaults standardUserDefaults] objectForKey:@"eyes"];
    if ([eyes isEqualToString:@"1"]) {
        _eyesBtn.selected = YES;
        if ([TLUser user].localMoney) {
            if ([[TLUser user].localMoney isEqualToString:@"CNY"] ) {
                
                _allAssetsPriceLabel.text = @"¥****";
                self.priceLabel.text = @"¥****";
                
            }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
            {
                _allAssetsPriceLabel.text = @"₩****";
                self.priceLabel.text = @"₩****";
                
            }
            else{
                _allAssetsPriceLabel.text = @"$****";
                self.priceLabel.text = @"$****";
                
                
            }
        }else{
            
            _allAssetsPriceLabel.text = @"¥****";
            self.priceLabel.text = @"¥****";
            
        }
    }
    else
    {
        _eyesBtn.selected = NO;
        if ([TLUser user].localMoney) {
            if ([[TLUser user].localMoney isEqualToString:@"CNY"] ) {
                
                _allAssetsPriceLabel.text = @"¥0.00";
                self.priceLabel.text = @"¥0.00";
                
            }else if ([[TLUser user].localMoney isEqualToString:@"KRW"])
            {
                _allAssetsPriceLabel.text = @"₩0.00";
                self.priceLabel.text = @"₩0.00";
                
            }
            else{
                _allAssetsPriceLabel.text = @"$****";
                self.priceLabel.text = @"$0.00";
                
                
            }
        }else{
            
            _allAssetsPriceLabel.text = @"¥0.00";
            self.priceLabel.text = @"¥0.00";
            
        }
    }
    
}





@end
