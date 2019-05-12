//
//  AlertsDetailsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/10.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AlertsDetailsVC.h"
#import "SGQRCodeGenerateManager.h"
@interface AlertsDetailsVC ()<RefreshDelegate>
{
    UIScrollView *scrollView;
}


@end
@implementation AlertsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topView.backgroundColor = kClearColor;
    self.view.backgroundColor = kWhiteColor;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 80)];
    [self.view addSubview:scrollView];
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150 - 64 + kNavigationBarHeight)];
    [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    [scrollView addSubview:backView];
    

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = backView.bounds;
    [backView.layer addSublayer:gradientLayer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.colors = @[(__bridge id)kHexColor(@"#5C6DFF").CGColor,(__bridge id)kHexColor(@"#77A4FF").CGColor];
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, 150 - 64 + kNavigationBarHeight - kStatusBarHeight)];
    titleLbl.font = HGboldfont(36);
    titleLbl.text = @"消息快讯";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = kWhiteColor;
    [backView addSubview:titleLbl];
    
    
    UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, backView.yy + 20, SCREEN_WIDTH - 30, 0)];
    nameLbl.font = FONT(16);
    nameLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"【快讯】财联社12月5日讯,华立股份、荣晟环保变更高送转预案"];;
    nameLbl.numberOfLines = 0;
    [nameLbl sizeToFit];
    [scrollView addSubview:nameLbl];
    
    
    UIButton *goodBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    goodBtn.frame = CGRectMake(SCREEN_WIDTH, nameLbl.yy + 20, 0, 20);
    [goodBtn setTitle:@"利好 0" forState:(UIControlStateNormal)];
    [goodBtn setTitleColor:kHexColor(@"#999999") forState:(UIControlStateNormal)];
    [goodBtn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
    [goodBtn sizeToFit];
    goodBtn.titleLabel.font = FONT(14);
    goodBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    goodBtn.frame = CGRectMake(15, nameLbl.yy + 20, goodBtn.width + 26, 20);
    [goodBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
        [goodBtn setImage:kImage(@"利好-未点击") forState:(UIControlStateNormal)];
        [goodBtn setImage:kImage(@"利好-点击") forState:(UIControlStateSelected)];
    }];
    [scrollView addSubview:goodBtn];
    
    
    UIButton *poorBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    poorBtn.frame = CGRectMake(goodBtn.xx + 18, nameLbl.yy + 20, 0, 20);
    [poorBtn setTitle:@"利空 0" forState:(UIControlStateNormal)];
    [poorBtn setTitleColor:kHexColor(@"#999999") forState:(UIControlStateNormal)];
    [poorBtn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
    [poorBtn sizeToFit];
    poorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    poorBtn.titleLabel.font = FONT(14);
    poorBtn.frame = CGRectMake(goodBtn.xx + 18, nameLbl.yy + 20, poorBtn.width + 26, 20);
    
    [poorBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
        [poorBtn setImage:kImage(@"利空-未点击") forState:(UIControlStateNormal)];
        [poorBtn setImage:kImage(@"利空-点击") forState:(UIControlStateSelected)];
    }];
    [scrollView addSubview:poorBtn];
    
    
    UILabel *timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 165, nameLbl.yy + 20, 150, 20)];
    timeLbl.textAlignment = NSTextAlignmentRight;
    timeLbl.font = FONT(14);
    timeLbl.textColor = kHexColor(@"#999999");
    timeLbl.text = @"14:05:54";
    [scrollView addSubview:timeLbl];
    
    
    
    UILabel *contactLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, timeLbl.yy + 16.5, SCREEN_WIDTH - 30, 0)];
    contactLbl.textAlignment = NSTextAlignmentRight;
    contactLbl.font = FONT(14);
    contactLbl.attributedText = [UserModel ReturnsTheDistanceBetween:@"迅雷链是全球区块链3.0具有代表性的主链,率先实现百万TPS高并发,秒级确认的处理能力,支持超大规模应用及实际场景落地,致力于成为探索区块链在实体产业中落地的引领者."];
    contactLbl.numberOfLines = 0;
    contactLbl.textColor = kHexColor(@"#999999");
    [contactLbl sizeToFit];
    [scrollView addSubview:contactLbl];
    
    
    UIImageView *QrCode = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 15, contactLbl.yy + 64, 80, 80)];
    NSString *address = @"http:www.baidu.com";
    QrCode.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:address imageViewWidth:170];
    [scrollView addSubview:QrCode];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareBtn.frame = CGRectMake(15, QrCode.yy - 20, SCREEN_WIDTH - 100, 20);
    [shareBtn setTitle:@"分享来自 Ticp APP" forState:(UIControlStateNormal)];
    [shareBtn setTitleColor:kHexColor(@"#999999") forState:(UIControlStateNormal)];
    shareBtn.titleLabel.font = FONT(12);
    shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [shareBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
        [shareBtn setImage:kImage(@"分享-未点击") forState:(UIControlStateNormal)];
    }];
    [scrollView addSubview:shareBtn];
    
    UIButton *bottomBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    bottomBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 15 - 50 - kNavigationBarHeight, SCREEN_WIDTH - 30, 50);
    [bottomBtn setTitle:@"下载图片" forState:(UIControlStateNormal)];
    [bottomBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
    bottomBtn.titleLabel.font = FONT(16);
    [bottomBtn addTarget:self action:@selector(downloadBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    kViewRadius(bottomBtn, 4);
    [self.view addSubview:bottomBtn];
}

-(void)downloadBtnClick
{
    [TLAlert alertWithSucces:[LangSwitcher switchLang:@"保存成功!" key:nil]];
    
    UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}

@end
