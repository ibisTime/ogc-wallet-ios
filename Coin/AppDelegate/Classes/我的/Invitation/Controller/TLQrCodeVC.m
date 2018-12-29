//
//  TLQrCodeVC.m
//  Coin
//
//  Created by shaojianfei on 2018/8/9.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLQrCodeVC.h"
#import "SGQRCodeGenerateManager.h"
#import "AppConfig.h"
#import "UIButton+SGImagePosition.h"
#import <QuartzCore/QuartzCore.h>
#import "TLWBManger.h"
#import "TLWXManager.h"
#import "BouncedPasteView.h"
#import "ZJAnimationPopView.h"
@interface TLQrCodeVC ()
{
    NSString *address ;
}


@property (nonatomic ,strong) UIImageView *bgView;

@property (nonatomic ,strong) UIImageView *bgView1;

@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic , strong)ZJAnimationPopView *popView;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic, copy) NSString *h5String;

@property (nonatomic , strong)BouncedPasteView *bouncedView;

@end

@implementation TLQrCodeVC


-(BouncedPasteView *)bouncedView
{
    if (!_bouncedView) {
        _bouncedView = [[BouncedPasteView alloc]initWithFrame:CGRectMake(kWidth(25), SCREEN_HEIGHT + kNavigationBarHeight , SCREEN_WIDTH - kWidth(50), _bouncedView.pasteButton.yy + kHeight(30))];
        kViewRadius(_bouncedView, 4);
        [_bouncedView.pasteButton addTarget:self action:@selector(pasteButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        


    }
    return _bouncedView;
}



#pragma mark 显示弹框
- (void)showPopAnimationWithAnimationStyle:(NSInteger)style
{
    ZJAnimationPopStyle popStyle = (style == 8) ? ZJAnimationPopStyleCardDropFromLeft : (ZJAnimationPopStyle)style;
    ZJAnimationDismissStyle dismissStyle = (ZJAnimationDismissStyle)style;
    // 1.初始化
    _popView = [[ZJAnimationPopView alloc] initWithCustomView:_bouncedView popStyle:popStyle dismissStyle:dismissStyle];

    // 2.设置属性，可不设置使用默认值，见注解
    // 2.1 显示时点击背景是否移除弹框
    _popView.isClickBGDismiss = ![_bouncedView isKindOfClass:[BouncedPasteView class]];
//    移除
    _popView.isClickBGDismiss = YES;
    // 2.2 显示时背景的透明度
    _popView.popBGAlpha = 0.5f;
    // 2.3 显示时是否监听屏幕旋转
    _popView.isObserverOrientationChange = YES;
    // 2.4 显示时动画时长
    //    popView.popAnimationDuration = 0.8f;
    // 2.5 移除时动画时长
    //    popView.dismissAnimationDuration = 0.8f;

    // 2.6 显示完成回调
    _popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    _popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };
    // 4.显示弹框
    [_popView pop];
}


//打开微信,去粘贴
-(void)pasteButtonClick
{
    [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功!" key:nil]];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *lang;
    LangType type = [LangSwitcher currentLangType];
    if (type == LangTypeSimple || type == LangTypeTraditional) {
        lang = @"ZH_CN";
    }else if (type == LangTypeKorean)
    {
        lang = @"KO";
    }else{
        lang = @"EN";

    }

    pasteboard.string = self.bouncedView.informationLabel.text;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    [self navigationTransparentClearColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}


//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = kTabbarColor;
//    self.navigationItem.backBarButtonItem = item;
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = [LangSwitcher switchLang:@"邀请有礼" key:nil];
    [self getShareUrl];

//    渐变背景
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT + kNavigationBarHeight)];
    [self.view addSubview:backView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = backView.bounds;
    [backView.layer addSublayer:gradientLayer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.colors = @[(__bridge id)RGB(92, 101, 221).CGColor,
                             (__bridge id)RGB(90, 63, 200).CGColor];
    
    gradientLayer.locations = @[@(0.5f), @(1.0f)];

    self.nameLable = [[UILabel alloc]init];
    self.nameLable.text = [LangSwitcher switchLang:@"邀请有礼" key:nil];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.font = Font(18);
    self.nameLable.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.nameLable;

    self.view.backgroundColor  =[UIColor whiteColor];
    [self.view addSubview:self.bouncedView];
    // Do any additional setup after loading the view.
    
    [self initUI];
}


- (void)getShareUrl
{
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"660917";
    
    http.parameters[@"ckey"] = @"redPacketShareUrl";
    
    [http postWithSuccess:^(id responseObject) {
        self.h5String = responseObject[@"data"][@"cvalue"];


        
        [self initUI1];
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)initUI
{
//    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - kWidth(38), kHeight(kNavigationBarHeight + 16), 76, 103)];
//    iconImage.contentMode = UIViewContentModeScaleToFill;
//    iconImage.image = kImage(@"logoo");
    //    iconImage.backgroundColor = [UIColor redColor];
//    [_bgView addSubview:iconImage];
//
//    UIImageView *titleBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(70), kHeight(197 - 64 + kNavigationBarHeight),SCREEN_WIDTH - kWidth(105), kHeight(52))];
//    titleBackImage.image = kImage(@"文字背景");
//    [_bgView addSubview:titleBackImage];
//
//
//    UILabel *introduceLabel = [UILabel labelWithFrame:CGRectMake(kWidth(23), kHeight(2), SCREEN_WIDTH - kWidth(186), kHeight(36)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#FFFFFF")];
//
//    introduceLabel.text = [LangSwitcher switchLang:@"全球首款跨链生态钱包" key:nil];
//    [titleBackImage addSubview:introduceLabel];
//
//
    

    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0,  - 64 + kNavigationBarHeight + kHeight(190), SCREEN_WIDTH, kHeight(25)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:kWhiteColor];
    nameLabel.text = [LangSwitcher switchLang:[TLUser user].mobile key:nil];
    [self.view addSubview:nameLabel];
    
    UILabel *introduceLbl = [UILabel labelWithFrame:CGRectMake(0, nameLabel.yy + kHeight(8), SCREEN_WIDTH, kHeight(20)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kWhiteColor];
    introduceLbl.text = [LangSwitcher switchLang:@"邀请您加入XXX" key:nil];
    [self.view addSubview:introduceLbl];
    
    
//    UIImageView *btnBack = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(-1), SCREEN_HEIGHT - kHeight(91), SCREEN_WIDTH + kWidth(2), kHeight(92))];
//    btnBack.image = kImage(@"1-1");
//    kViewBorderRadius(btnBack, 0.01, 1, kHexColor(@"#00F5FE"));
//    [self.view addSubview:btnBack];
//
//    NSArray *nameArray = @[@"保存本地",@"微信",@"朋友圈",@"微博"];
//    NSArray *imgArray = @[@"保存本地 亮色",@"微信 亮色",@"朋友圈 亮色",@"微博 亮色"];
//
//    for (int i = 0; i < 4; i ++) {
//        UIButton *shareBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:nameArray[i] key:nil] titleColor:kHexColor(@"#05C8DB") backgroundColor:kClearColor titleFont:12];
//        shareBtn.frame = CGRectMake(i % 4 * SCREEN_WIDTH/4, SCREEN_HEIGHT - kHeight(91), SCREEN_WIDTH/4, kHeight(91));
//        [shareBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:8 imagePositionBlock:^(UIButton *button) {
//            [button setImage:[UIImage imageNamed:imgArray[i]] forState:(UIControlStateNormal)];
//        }];
//        [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        shareBtn.tag = 100 + i;
//        [self.view addSubview:shareBtn];
//    }
    


    UIView *codeView = [UIView new];
    [self.view addSubview:codeView];
    codeView.backgroundColor = kBackgroundColor;
    codeView.frame = CGRectMake(SCREEN_WIDTH/2 - kWidth(110), introduceLbl.yy + kHeight(15), kWidth(220), kWidth(220));
    codeView.layer.cornerRadius=5;
    codeView.layer.shadowOpacity = 0.22;// 阴影透明度
    codeView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    codeView.layer.shadowRadius=3;// 阴影扩散的范围控制
    codeView.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围

    [self.view addSubview:codeView];


    //二维码
    UIImageView *qrIV = [[UIImageView alloc] init];

     NSString *lang;
    LangType type = [LangSwitcher currentLangType];
    if (type == LangTypeSimple || type == LangTypeTraditional) {
        lang = @"ZH_CN";
    }else if (type == LangTypeKorean)
    {
        lang = @"KO";
    }else{
        lang = @"EN";
        
    }
    http://m.thadev.hichengdai.com/user/register.html?inviteCode=U201807030441369491006&lang=ZH_CN
     address = [NSString stringWithFormat:@"%@/user/register.html?inviteCode=%@&lang=%@",self.h5String,[TLUser user].secretUserId,lang];

    self.bouncedView.informationLabel.attributedText = [self ReturnsTheDistanceBetween:[NSString stringWithFormat:@"%@%@",[LangSwitcher switchLang:@"【Theia是全球首款跨链生态钱包，同时支持BTC、ETH、TUSD等多币数字货币储存。注册即送10积分，千万BTC/ETH/WAN矿山，等您来挖】" key:nil],address]];



    
    qrIV.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:address imageViewWidth:170];
    
    [codeView addSubview:qrIV];
    [qrIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(codeView.mas_top).offset(kWidth(20));
        make.right.equalTo(codeView.mas_right).offset(-kWidth(20));
        make.left.equalTo(codeView.mas_left).offset(kWidth(20));
        make.bottom.equalTo(codeView.mas_bottom).offset(-kWidth(20));
    }];
    
    
    UILabel *InviteLinkLabel = [UILabel labelWithFrame:CGRectMake(kWidth(20), codeView.yy + kHeight(15), 0, kHeight(22)) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kWhiteColor];
    InviteLinkLabel.text = [LangSwitcher switchLang:@"复制您的专属邀请链接" key:nil];
    [self.view addSubview:InviteLinkLabel];
    [InviteLinkLabel sizeToFit];
    if (InviteLinkLabel.width >= SCREEN_WIDTH - kWidth(72) - kWidth(40)) {
        InviteLinkLabel.frame = CGRectMake(kWidth(20), codeView.yy + kHeight(15), SCREEN_WIDTH - kWidth(72) - kWidth(40), kHeight(22));
    }else
    {
        InviteLinkLabel.frame = CGRectMake(SCREEN_WIDTH/2 - InviteLinkLabel.width/2 - kWidth(36), codeView.yy + kHeight(15), InviteLinkLabel.width, kHeight(22));
    }
    
    UIButton *copyButton = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"复制" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12];
    copyButton.frame = CGRectMake(InviteLinkLabel.xx + kWidth(12) , codeView.yy + kHeight(15), kWidth(60), kHeight(22));
    kViewBorderRadius(copyButton, 2, 1, kWhiteColor);
    [copyButton addTarget:self action:@selector(copyButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:copyButton];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - kHeight(50) - kBottomInsetHeight, SCREEN_WIDTH, kHeight(50) + kBottomInsetHeight)];
    bottomView.backgroundColor = RGB(90, 61, 200);
    bottomView.layer.shadowOpacity = 0.22;// 阴影透明度
    bottomView.layer.shadowColor = kWhiteColor.CGColor;// 阴影的颜色
    bottomView.layer.shadowRadius=3;// 阴影扩散的范围控制
    bottomView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
//    bottomView
    
    [self.view addSubview:bottomView];

    
//    UIView *liView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.2)];
//    liView.backgroundColor = kWhiteColor;
//    [bottomView addSubview:liView];
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = bottomView.bounds;
//    [bottomView.layer addSublayer:gradientLayer];
//    gradientLayer.startPoint = CGPointMake(0, 1);
//    gradientLayer.endPoint = CGPointMake(1, 1);
//    gradientLayer.colors = @[(__bridge id)kHexColor(@"#657FFF").CGColor,
//                             (__bridge id)kHexColor(@"#4D30C5").CGColor];
//    gradientLayer.locations = @[@(0.5f), @(1.0f)];
    
    
    UIButton *downloadBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"下载至本地" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:16];
    downloadBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeight(50));
    [bottomView addSubview:downloadBtn];
    
    
}


- (void)initUI1
{
    UIImageView *bgView = [[UIImageView alloc] init];
    self.bgView1 = bgView;
    bgView.userInteractionEnabled = YES;
    bgView.contentMode = UIViewContentModeScaleToFill;

    bgView.image = kImage(@"邀请bg");
    [self.view addSubview:bgView];
    bgView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 44)];
    titleLabel.text = [LangSwitcher switchLang:@"邀请有礼" key:nil];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = Font(18);
    titleLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:titleLabel];


    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - kWidth(38), kHeight(kNavigationBarHeight + 16), kWidth(76), kHeight(103))];
    iconImage.image = kImage(@"logoo");
    //    iconImage.backgroundColor = [UIColor redColor];
    [bgView addSubview:iconImage];

    UIImageView *titleBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(70), kHeight(197 - 64 + kNavigationBarHeight),SCREEN_WIDTH - kWidth(105), kHeight(52))];
    titleBackImage.image = kImage(@"文字背景");
    [bgView addSubview:titleBackImage];


    UILabel *introduceLabel = [UILabel labelWithFrame:CGRectMake(kWidth(23), kHeight(2), SCREEN_WIDTH - kWidth(186), kHeight(36)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#FFFFFF")];

    introduceLabel.text = [LangSwitcher switchLang:@"全球首款跨链生态钱包" key:nil];
    [titleBackImage addSubview:introduceLabel];


    UIView *codeView = [UIView new];
    [self.bgView addSubview:codeView];
    codeView.backgroundColor = kBackgroundColor;
    codeView.frame = CGRectMake(SCREEN_WIDTH/2 - kWidth(90), kHeight(230) + kNavigationBarHeight, kWidth(180), kWidth(180));
    codeView.layer.cornerRadius=5;
    codeView.layer.shadowOpacity = 0.22;// 阴影透明度
    codeView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    codeView.layer.shadowRadius=3;// 阴影扩散的范围控制
    codeView.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围
    [bgView addSubview:codeView];


    //二维码
    UIImageView *qrIV = [[UIImageView alloc] init];

    qrIV.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:address imageViewWidth:170];

    [codeView addSubview:qrIV];
    [qrIV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(codeView.mas_top).offset(15);
        make.right.equalTo(codeView.mas_right).offset(-15);
        make.left.equalTo(codeView.mas_left).offset(15);
        make.bottom.equalTo(codeView.mas_bottom).offset(-15);
    }];

    UILabel *InviteFriendsLabel = [UILabel labelWithFrame:CGRectMake(kWidth(20), codeView.yy + kHeight(30), SCREEN_WIDTH - kWidth(40), 22) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#00F9FE")];
    InviteFriendsLabel.text = [LangSwitcher switchLang:@"- 登录享豪礼 -" key:nil];
    [bgView addSubview:InviteFriendsLabel];

    UILabel *numberLabel1 = [UILabel labelWithFrame:CGRectMake(kWidth(60), InviteFriendsLabel.yy +  kHeight(16), 20, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];
    numberLabel1.text = [LangSwitcher switchLang:@"1," key:nil];
    [bgView addSubview:numberLabel1];

    UILabel *introduceLabel1 = [UILabel labelWithFrame:CGRectMake(kWidth(60) + 20, InviteFriendsLabel.yy +  kHeight(16), SCREEN_WIDTH - kWidth(120) - 20, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];

    // 设置Label要显示的text
    [introduceLabel1  setAttributedText:[self ReturnsTheDistanceBetween:[LangSwitcher switchLang:@"新用户注册并登陆可获得10积分奖励" key:nil]]];
    introduceLabel1.numberOfLines = 0;
    [introduceLabel1 sizeToFit];
    [bgView addSubview:introduceLabel1];
    UILabel *numberLabel2 = [UILabel labelWithFrame:CGRectMake(kWidth(60), introduceLabel1.yy + kHeight(10), 20, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];
    numberLabel2.text = [LangSwitcher switchLang:@"2," key:nil];
    [bgView addSubview:numberLabel2];

    UILabel *introduceLabel2 = [UILabel labelWithFrame:CGRectMake(kWidth(60) + 20, introduceLabel1.yy + kHeight(10), SCREEN_WIDTH - kWidth(120) - 20, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];
    [introduceLabel2  setAttributedText:[self ReturnsTheDistanceBetween:[LangSwitcher switchLang:@"新用户可获得购买币加宝收益首次翻倍的奖励" key:nil]]];
    introduceLabel2.numberOfLines = 0;
    [introduceLabel2 sizeToFit];
    [bgView addSubview:introduceLabel2];
}


//设置行间距
-(NSMutableAttributedString *)ReturnsTheDistanceBetween:(NSString *)str
{
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置为30
    [paragraphStyle  setLineSpacing:8];
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:str];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    return setString;
}

//@[@"保存本地",@"微信",@"朋友圈",@"微博"]
-(void)shareBtnClick:(UIButton *)sender
{
    switch (sender.tag - 100) {
        case 0:
        {
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"保存成功!" key:nil]];

            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);

        }
            break;
        case 1:
        {
            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [TLWXManager wxShareImgWith:@"" scene:0 desc:nil image:viewImage];
//            [[TLWXManager manager] setWxShare:^(BOOL isSuccess, int errorCode) {
//                
//                if (isSuccess) {
//                    
//                    [TLAlert alertWithInfo:@"分享成功"];
//                    
//                } else {
//                    
//                    [TLAlert alertWithInfo:@"分享失败"];
//                    
//                }
//                
//            }];
        }
            break;
        case 2:
        {
            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [TLWXManager wxShareImgWith:@"" scene:1 desc:nil image:viewImage];
//            [[TLWXManager manager] setWxShare:^(BOOL isSuccess, int errorCode) {
//
//                if (isSuccess) {
//
//                    [TLAlert alertWithInfo:@"分享成功"];
//
//                } else {
//
//                    [TLAlert alertWithInfo:@"分享失败"];
//
//                }
//
//            }];
        }
            break;
        case 3:
        {
            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [TLWBManger sinaShareWithImage:viewImage];
            
        }
            break;

        default:
            break;
    }
}

//复制
-(void)copyButtonClick
{
    _bouncedView.frame = CGRectMake(kWidth(25), kHeight(140), SCREEN_WIDTH - kWidth(50), _bouncedView.pasteButton.yy + kHeight(30));
    [self showPopAnimationWithAnimationStyle:8];
//    [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功!" key:nil]];
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = address;

}


- (void)inviteButtonClick
{
    
    
}

- (void)sendinviteButtonClick
{
    
    
}
- (void)buttonClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
