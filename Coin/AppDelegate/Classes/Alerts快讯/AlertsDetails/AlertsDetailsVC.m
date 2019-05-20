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
    UIView *backView1;
}


@end
@implementation AlertsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topView.backgroundColor = kClearColor;
    self.view.backgroundColor = kWhiteColor;
    
    
    
    NSString *string = self.model.content;
    NSRange startRange = [string rangeOfString:@"【"];
    NSRange endRange = [string rangeOfString:@"】"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [string substringWithRange:range];
    NSLog(@"%@",result);
    
    
    NSRange range1 = NSMakeRange(result.length + 2, string.length - result.length - 2);
    NSString *result1 = [string substringWithRange:range1];
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 80)];
    [self.view addSubview:scrollView];
    
    
    backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scrollView addSubview:backView1];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150 - 64 + kNavigationBarHeight)];
    [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    [backView1 addSubview:backView];
    

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
    nameLbl.attributedText = [UserModel ReturnsTheDistanceBetween:result];;
    nameLbl.numberOfLines = 0;
    [nameLbl sizeToFit];
    [backView1 addSubview:nameLbl];
    
    
//    UIButton *goodBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    goodBtn.frame = CGRectMake(SCREEN_WIDTH, nameLbl.yy + 20, 0, 20);
//    [goodBtn setTitle:@"利好 0" forState:(UIControlStateNormal)];
//    [goodBtn setTitleColor:kHexColor(@"#999999") forState:(UIControlStateNormal)];
//    [goodBtn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
//    [goodBtn sizeToFit];
//    goodBtn.titleLabel.font = FONT(14);
//    goodBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    goodBtn.frame = CGRectMake(15, nameLbl.yy + 20, goodBtn.width + 26, 20);
//    [goodBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
//        [goodBtn setImage:kImage(@"利好-未点击") forState:(UIControlStateNormal)];
//        [goodBtn setImage:kImage(@"利好-点击") forState:(UIControlStateSelected)];
//    }];
//    [scrollView addSubview:goodBtn];
//
//
//    UIButton *poorBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    poorBtn.frame = CGRectMake(goodBtn.xx + 18, nameLbl.yy + 20, 0, 20);
//    [poorBtn setTitle:@"利空 0" forState:(UIControlStateNormal)];
//    [poorBtn setTitleColor:kHexColor(@"#999999") forState:(UIControlStateNormal)];
//    [poorBtn setTitleColor:kTabbarColor forState:(UIControlStateSelected)];
//    [poorBtn sizeToFit];
//    poorBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    poorBtn.titleLabel.font = FONT(14);
//    poorBtn.frame = CGRectMake(goodBtn.xx + 18, nameLbl.yy + 20, poorBtn.width + 26, 20);
//
//    [poorBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
//        [poorBtn setImage:kImage(@"利空-未点击") forState:(UIControlStateNormal)];
//        [poorBtn setImage:kImage(@"利空-点击") forState:(UIControlStateSelected)];
//    }];
//    [scrollView addSubview:poorBtn];
    
    
    UILabel *timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 165, nameLbl.yy + 20, 150, 20)];
    timeLbl.textAlignment = NSTextAlignmentRight;
    timeLbl.font = FONT(14);
    timeLbl.textColor = kHexColor(@"#999999");
    timeLbl.text = self.model.publishDatetime;
    [backView1 addSubview:timeLbl];
    
    
    
    UILabel *contactLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, timeLbl.yy + 16.5, SCREEN_WIDTH - 30, 0)];
    contactLbl.textAlignment = NSTextAlignmentRight;
    contactLbl.font = FONT(14);
    contactLbl.attributedText = [UserModel ReturnsTheDistanceBetween:result1];
    contactLbl.numberOfLines = 0;
    contactLbl.textColor = kHexColor(@"#999999");
    [contactLbl sizeToFit];
    [backView1 addSubview:contactLbl];
    
    
    UIImageView *QrCode = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 15, contactLbl.yy + 64, 80, 80)];
    
    
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"630047";
    
    http.parameters[@"ckey"] = @"invite_url";
    
    [http postWithSuccess:^(id responseObject) {
        NSString *h5String = responseObject[@"data"][@"cvalue"];
        
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
        
         NSString *address = [NSString stringWithFormat:@"%@?inviteCode=%@&lang=%@",h5String,[TLUser user].userId,lang];
        QrCode.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:address imageViewWidth:170];
    } failure:^(NSError *error) {
        
    }];
    
    
    [backView1 addSubview:QrCode];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareBtn.frame = CGRectMake(15, QrCode.yy - 20, SCREEN_WIDTH - 100, 20);
    [shareBtn setTitle:@"分享来自 金米钱包" forState:(UIControlStateNormal)];
    [shareBtn setTitleColor:kHexColor(@"#999999") forState:(UIControlStateNormal)];
    shareBtn.titleLabel.font = FONT(12);
    shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [shareBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:6 imagePositionBlock:^(UIButton *button) {
        [shareBtn setImage:kImage(@"分享-未点击") forState:(UIControlStateNormal)];
    }];
    [backView1 addSubview:shareBtn];
    
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, QrCode.yy + 50);
    backView1.frame = CGRectMake(0, 0, SCREEN_WIDTH, QrCode.yy + 50);
    
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
    
    UIGraphicsBeginImageContextWithOptions(backView1.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [backView1.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}

@end
