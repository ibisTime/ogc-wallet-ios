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
    UIView *backView;
    CAGradientLayer *gradientLayer;
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
//- (void)showPopAnimationWithAnimationStyle:(NSInteger)style{
//    ZJAnimationPopStyle popStyle = (style == 8) ? ZJAnimationPopStyleCardDropFromLeft : (ZJAnimationPopStyle)style;
//    ZJAnimationDismissStyle dismissStyle = (ZJAnimationDismissStyle)style;
//    // 1.初始化
//    _popView = [[ZJAnimationPopView alloc] initWithCustomView:_bouncedView popStyle:popStyle dismissStyle:dismissStyle];
//
//    // 2.设置属性，可不设置使用默认值，见注解
//    // 2.1 显示时点击背景是否移除弹框
//    _popView.isClickBGDismiss = ![_bouncedView isKindOfClass:[BouncedPasteView class]];
////    移除
//    _popView.isClickBGDismiss = YES;
//    // 2.2 显示时背景的透明度
//    _popView.popBGAlpha = 0.5f;
//    // 2.3 显示时是否监听屏幕旋转
//    _popView.isObserverOrientationChange = YES;
//    // 2.4 显示时动画时长
//    //    popView.popAnimationDuration = 0.8f;
//    // 2.5 移除时动画时长
//    //    popView.dismissAnimationDuration = 0.8f;
//
//    // 2.6 显示完成回调
//    _popView.popComplete = ^{
//        NSLog(@"显示完成");
//    };
//    // 2.7 移除完成回调
//    _popView.dismissComplete = ^{
//        NSLog(@"移除完成");
//    };
//    // 4.显示弹框
//    [_popView pop];
//}


//打开微信,去粘贴
-(void)pasteButtonClick{
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

    //去掉导航栏底部的黑线
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}



//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self getShareUrl];

    self.view.backgroundColor = kHexColor(@"#282A2E");
//    渐变背景
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT  - kHeight(50) - kBottomInsetHeight)];
    [self.view addSubview:backView];
    backView.backgroundColor = kHexColor(@"#282A2E");
    

    self.nameLable = [[UILabel alloc]init];
    self.nameLable.text = [LangSwitcher switchLang:@"邀请有礼" key:nil];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.font = Font(16);
    self.nameLable.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.nameLable;

   
    [self.view addSubview:self.bouncedView];
    // Do any additional setup after loading the view.
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kNavigationBarHeight - kHeight(50) - kBottomInsetHeight, SCREEN_WIDTH, kHeight(50) + kBottomInsetHeight)];
    bottomView.backgroundColor = RGB(45, 54, 71);
    bottomView.layer.shadowOpacity = 0.22;// 阴影透明度
    bottomView.layer.shadowColor = kWhiteColor.CGColor;// 阴影的颜色
    bottomView.layer.shadowRadius=3;// 阴影扩散的范围控制
    bottomView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    //    bottomView
    
    [self.view addSubview:bottomView];
    
    
    
    UIButton *downloadBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"下载至本地" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:16];
    downloadBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeight(50));
    [downloadBtn addTarget:self action:@selector(downloadBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:downloadBtn];
//    [self initUI];
}


- (void)getShareUrl
{
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"630047";
    
    http.parameters[@"ckey"] = @"invite_url";
    
    [http postWithSuccess:^(id responseObject) {
        self.h5String = responseObject[@"data"][@"cvalue"];

        [self initUI];
        
//        [self initUI1];
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)initUI
{

    
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"邀请-logo"];
    [backView  addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(backView.mas_top).offset(157.5);
        make.width.mas_equalTo(@(kHeight(120)));
        make.height.mas_equalTo(@(kHeight(60)));

        make.centerX.equalTo(backView.mas_centerX);

    }];
    

    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0,   kNavigationBarHeight + kHeight(190), SCREEN_WIDTH, kHeight(25)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:kWhiteColor];
    nameLabel.textColor = kWhiteColor;
    nameLabel.text = [LangSwitcher switchLang:[TLUser user].mobile key:nil];
    [backView addSubview:nameLabel];
    
    UILabel *introduceLbl = [UILabel labelWithFrame:CGRectMake(0, nameLabel.yy + kHeight(8), SCREEN_WIDTH, kHeight(20)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kWhiteColor];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_info_dict_key"];
    introduceLbl.text = [NSString stringWithFormat:@"您的专属邀请码：%@",dict[@"inviteCode"]];
    introduceLbl.textColor = [UIColor whiteColor];
//    introduceLbl.backgroundColor = [UIColor redColor];
    [introduceLbl sizeToFit];
    introduceLbl.frame = CGRectMake(SCREEN_WIDTH/2 - introduceLbl.width/2 - 6 - 30, nameLabel.yy + kHeight(8), introduceLbl.width, kHeight(20));
    [backView addSubview:introduceLbl];
    
    
    UIButton *copyBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"复制" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12];
    copyBtn.frame = CGRectMake(introduceLbl.xx + 12 , nameLabel.yy + kHeight(7), 60, kHeight(22));
    kViewBorderRadius(copyBtn, 2, 1, kWhiteColor);
    [copyBtn addTarget:self action:@selector(copyBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:copyBtn];
    

    UIView *codeView = [UIView new];
    [self.view addSubview:codeView];
    codeView.backgroundColor = kBackgroundColor;
    codeView.frame = CGRectMake(SCREEN_WIDTH/2 - kWidth(110), introduceLbl.yy + kHeight(15), kWidth(220), kWidth(220));
    codeView.layer.cornerRadius=5;
    codeView.layer.shadowOpacity = 0.22;// 阴影透明度
    codeView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    codeView.layer.shadowRadius=3;// 阴影扩散的范围控制
    codeView.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围

    [backView addSubview:codeView];


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
    
     address = [NSString stringWithFormat:@"%@?inviteCode=%@&lang=%@",self.h5String,[TLUser user].userId,lang];


    

    
    qrIV.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:address imageViewWidth:170];
    
    [codeView addSubview:qrIV];
    [qrIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(codeView.mas_top).offset(kWidth(20));
        make.right.equalTo(codeView.mas_right).offset(-kWidth(20));
        make.left.equalTo(codeView.mas_left).offset(kWidth(20));
        make.bottom.equalTo(codeView.mas_bottom).offset(-kWidth(20));
    }];
    
    
    UILabel *InviteLinkLabel = [UILabel labelWithFrame:CGRectMake(kWidth(20), -kNavigationBarHeight + codeView.yy + kHeight(15), 0, kHeight(22)) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:kWhiteColor];
    InviteLinkLabel.text = [LangSwitcher switchLang:@"复制您的专属邀请链接" key:nil];
    InviteLinkLabel.textColor = kWhiteColor;
    [self.view addSubview:InviteLinkLabel];
    [InviteLinkLabel sizeToFit];
    if (InviteLinkLabel.width >= SCREEN_WIDTH - kWidth(72) - kWidth(40)) {
        InviteLinkLabel.frame = CGRectMake(kWidth(20), -kNavigationBarHeight + codeView.yy + kHeight(15), SCREEN_WIDTH - kWidth(72) - kWidth(40), kHeight(22));
    }else
    {
        InviteLinkLabel.frame = CGRectMake(SCREEN_WIDTH/2 - InviteLinkLabel.width/2 - kWidth(36), -kNavigationBarHeight + codeView.yy + kHeight(15), InviteLinkLabel.width, kHeight(22));
    }
    
    UIButton *copyButton = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"复制" key:nil] titleColor:kWhiteColor backgroundColor:kClearColor titleFont:12];
    copyButton.frame = CGRectMake(InviteLinkLabel.xx + kWidth(12) , -kNavigationBarHeight + codeView.yy + kHeight(15), kWidth(60), kHeight(22));
    kViewBorderRadius(copyButton, 2, 1, kWhiteColor);
    [copyButton addTarget:self action:@selector(copyButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:copyButton];
    
}

-(void)copyBtnClick
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_info_dict_key"];
    [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功!" key:nil]];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = dict[@"inviteCode"];
}


-(void)copyButtonClick
{
    [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功!" key:nil]];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = address;
}

-(void)downloadBtnClick
{
    [TLAlert alertWithSucces:[LangSwitcher switchLang:@"保存成功!" key:nil]];
    
    UIGraphicsBeginImageContextWithOptions(backView.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}


//- (void)initUI1{
//    UIImageView *bgView = [[UIImageView alloc] init];
//    self.bgView1 = bgView;
//    bgView.userInteractionEnabled = YES;
//    bgView.contentMode = UIViewContentModeScaleToFill;
//
//    bgView.image = kImage(@"邀请bg");
//    [self.view addSubview:bgView];
//    bgView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
//
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 44)];
//    titleLabel.text = [LangSwitcher switchLang:@"邀请有礼" key:nil];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = Font(18);
//    titleLabel.textColor = [UIColor whiteColor];
//    [bgView addSubview:titleLabel];
//
//
//    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - kWidth(38), kHeight(kNavigationBarHeight + 16), kWidth(76), kHeight(103))];
//    iconImage.image = kImage(@"logoo");
//    //    iconImage.backgroundColor = [UIColor redColor];
//    [bgView addSubview:iconImage];
//
//    UIImageView *titleBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth(70), kHeight(197 - 64 + kNavigationBarHeight),SCREEN_WIDTH - kWidth(105), kHeight(52))];
//    titleBackImage.image = kImage(@"文字背景");
//    [bgView addSubview:titleBackImage];
//
//
//    UILabel *introduceLabel = [UILabel labelWithFrame:CGRectMake(kWidth(23), kHeight(2), SCREEN_WIDTH - kWidth(186), kHeight(36)) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#FFFFFF")];
//
//    introduceLabel.text = [LangSwitcher switchLang:@"全球首款跨链生态钱包" key:nil];
//    [titleBackImage addSubview:introduceLabel];
//
//
//    UIView *codeView = [UIView new];
//    [self.bgView addSubview:codeView];
//    codeView.backgroundColor = kBackgroundColor;
//    codeView.frame = CGRectMake(SCREEN_WIDTH/2 - kWidth(90), kHeight(230) + kNavigationBarHeight, kWidth(180), kWidth(180));
//    codeView.layer.cornerRadius=5;
//    codeView.layer.shadowOpacity = 0.22;// 阴影透明度
//    codeView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//    codeView.layer.shadowRadius=3;// 阴影扩散的范围控制
//    codeView.layer.shadowOffset=CGSizeMake(1, 1);// 阴影的范围
//    [bgView addSubview:codeView];
//
//
//    //二维码
//    UIImageView *qrIV = [[UIImageView alloc] init];
//
//    qrIV.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:address imageViewWidth:170];
//
//    [codeView addSubview:qrIV];
//    [qrIV mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(codeView.mas_top).offset(15);
//        make.right.equalTo(codeView.mas_right).offset(-15);
//        make.left.equalTo(codeView.mas_left).offset(15);
//        make.bottom.equalTo(codeView.mas_bottom).offset(-15);
//    }];
//
//    UILabel *InviteFriendsLabel = [UILabel labelWithFrame:CGRectMake(kWidth(20), codeView.yy + kHeight(30), SCREEN_WIDTH - kWidth(40), 22) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:kHexColor(@"#00F9FE")];
//    InviteFriendsLabel.text = [LangSwitcher switchLang:@"- 登录享豪礼 -" key:nil];
//    [bgView addSubview:InviteFriendsLabel];
//
//    UILabel *numberLabel1 = [UILabel labelWithFrame:CGRectMake(kWidth(60), InviteFriendsLabel.yy +  kHeight(16), 20, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];
//    numberLabel1.text = [LangSwitcher switchLang:@"1," key:nil];
//    [bgView addSubview:numberLabel1];
//
//    UILabel *introduceLabel1 = [UILabel labelWithFrame:CGRectMake(kWidth(60) + 20, InviteFriendsLabel.yy +  kHeight(16), SCREEN_WIDTH - kWidth(120) - 20, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];
//
//    // 设置Label要显示的text
//    [introduceLabel1  setAttributedText:[self ReturnsTheDistanceBetween:[LangSwitcher switchLang:@"新用户注册并登陆可获得10积分奖励" key:nil]]];
//    introduceLabel1.numberOfLines = 0;
//    [introduceLabel1 sizeToFit];
//    [bgView addSubview:introduceLabel1];
//    UILabel *numberLabel2 = [UILabel labelWithFrame:CGRectMake(kWidth(60), introduceLabel1.yy + kHeight(10), 20, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];
//    numberLabel2.text = [LangSwitcher switchLang:@"2," key:nil];
//    [bgView addSubview:numberLabel2];
//
//    UILabel *introduceLabel2 = [UILabel labelWithFrame:CGRectMake(kWidth(60) + 20, introduceLabel1.yy + kHeight(10), SCREEN_WIDTH - kWidth(120) - 20, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#FFFFFF")];
//    [introduceLabel2  setAttributedText:[self ReturnsTheDistanceBetween:[LangSwitcher switchLang:@"新用户可获得购买币加宝收益首次翻倍的奖励" key:nil]]];
//    introduceLabel2.numberOfLines = 0;
//    [introduceLabel2 sizeToFit];
//    [bgView addSubview:introduceLabel2];
//}


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
//-(void)shareBtnClick:(UIButton *)sender{
//    switch (sender.tag - 100) {
//        case 0:
//        {
//            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"保存成功!" key:nil]];
//
//            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
//            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
//            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
//
//        }
//            break;
//        case 1:
//        {
//            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
//            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
//            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            [TLWXManager wxShareImgWith:@"" scene:0 desc:nil image:viewImage];
////            [[TLWXManager manager] setWxShare:^(BOOL isSuccess, int errorCode) {
////
////                if (isSuccess) {
////
////                    [TLAlert alertWithInfo:@"分享成功"];
////
////                } else {
////
////                    [TLAlert alertWithInfo:@"分享失败"];
////
////                }
////
////            }];
//        }
//            break;
//        case 2:
//        {
//            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
//            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
//            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            [TLWXManager wxShareImgWith:@"" scene:1 desc:nil image:viewImage];
////            [[TLWXManager manager] setWxShare:^(BOOL isSuccess, int errorCode) {
////
////                if (isSuccess) {
////
////                    [TLAlert alertWithInfo:@"分享成功"];
////
////                } else {
////
////                    [TLAlert alertWithInfo:@"分享失败"];
////
////                }
////
////            }];
//        }
//            break;
//        case 3:
//        {
//            UIGraphicsBeginImageContextWithOptions(self.bgView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
//            [self.bgView1.layer renderInContext:UIGraphicsGetCurrentContext()];
//            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            [TLWBManger sinaShareWithImage:viewImage];
//
//        }
//            break;
//
//        default:
//            break;
//    }
//}


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
