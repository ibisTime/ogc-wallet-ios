//
//  GoldenRiceBlessingVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/3/24.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "GoldenRiceBlessingVC.h"
#import <WebKit/WebKit.h>
@interface GoldenRiceBlessingVC ()<UIWebViewDelegate>

@property (nonatomic , strong)UIWebView *webView;

@end

@implementation GoldenRiceBlessingVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.titleText.text = @"金米福分";
    self.navigationItem.titleView = self.titleText;
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/2)];
    topImage.image = kImage(@"积分背景");
    [self.view addSubview:topImage];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(30, 20, SCREEN_WIDTH - 90, (SCREEN_WIDTH - 30)/2/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:RGB(174, 184, 239)];
    nameLbl.text = @"我的福分";
    nameLbl.textColor = kWhiteColor;
    [topImage addSubview:nameLbl];
    
    
    UILabel *numbernLbl = [UILabel labelWithFrame:CGRectMake(30, (SCREEN_WIDTH - 30)/2/3, SCREEN_WIDTH, (SCREEN_WIDTH - 30)/2/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(30) textColor:kWhiteColor];
    numbernLbl.text = @"0";
    numbernLbl.textColor = kWhiteColor;
    [topImage addSubview:numbernLbl];
    
    
    UILabel *blessing = [UILabel labelWithFrame:CGRectMake(30, (SCREEN_WIDTH - 30)/2/3*2- 20, SCREEN_WIDTH, (SCREEN_WIDTH - 30)/2/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kWhiteColor];
    blessing.text = @"我的团队：0人";
    blessing.textColor = kWhiteColor;
    [topImage addSubview:blessing];
    
    
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"805913";
    http.parameters[@"userId"] = [TLUser user].userId;

    
    [http postWithSuccess:^(id responseObject) {
        numbernLbl.text = [NSString stringWithFormat:@"%.2f",[responseObject[@"data"][@"totalAward"] floatValue]/100000000];
    } failure:^(NSError *error) {
        
    }];
    
    
    TLNetworking *http1 = [TLNetworking new];
    http1.showView = self.view;
    http1.code = @"805123";
    http1.showView = self.view;
    http1.parameters[@"userId"] = [TLUser user].userId;
    [http1 postWithSuccess:^(id responseObject) {
        blessing.text = [NSString stringWithFormat:@"我的团队：%ld人",[responseObject[@"data"][@"refrereeCount"] integerValue]];
    } failure:^(NSError *error) {
        
    }];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, topImage.yy + 30, 3, 15)];
    lineView.backgroundColor = kTabbarColor;
    kViewRadius(lineView, 1.5);
    [self.view addSubview:lineView];
    
    UILabel *rulesLbl = [UILabel labelWithFrame:CGRectMake(lineView.xx + 5, topImage.yy + 27.5, SCREEN_WIDTH - lineView.xx - 3 - 15, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kTextColor];
    rulesLbl.text = @"福分规则";
    [self.view addSubview:rulesLbl];
    
//    UILabel *rulesDetailsLbl = [UILabel labelWithFrame:CGRectMake(20, rulesLbl.yy + 15, SCREEN_WIDTH - 40, SCREEN_HEIGHT - kNavigationBarHeight - rulesLbl.yy - 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kTextColor];
////    rulesLbl.text = @"福分规则";
//    rulesDetailsLbl.numberOfLines = 0;
//    [rulesDetailsLbl sizeToFit];
//    [self.view addSubview:rulesDetailsLbl];
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, rulesLbl.yy + 15, SCREEN_WIDTH - 40, SCREEN_HEIGHT - kNavigationBarHeight - rulesLbl.yy - 25) ];
    _webView.delegate = self;
    [_webView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
    [self.view addSubview:_webView];
//
//
    TLNetworking *http2 = [TLNetworking new];
    http2.showView = self.view;
    http2.code = USER_CKEY_CVALUE;

    http2.parameters[SYS_KEY] = @"activety_notice";

    [http2 postWithSuccess:^(id responseObject) {

//        NSRange startRange = [responseObject[@"data"][@"cvalue"] rangeOfString:@"<p>"];
//        NSRange endRange = [responseObject[@"data"][@"cvalue"] rangeOfString:@"</p>"];
//        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
//        NSString * con = [responseObject[@"data"][@"cvalue"] substringWithRange:range];
//        rulesDetailsLbl.attributedText = [UserModel ReturnsTheDistanceBetween:con];
//        [rulesDetailsLbl sizeToFit];
        [_webView loadHTMLString:responseObject[@"data"][@"cvalue"] baseURL:nil];
    } failure:^(NSError *error) {

    }];
    
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
        //字体颜色

        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"];

        //页面背景色

        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#282A2E'"];
    }else
    {
        //字体颜色

        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#282A2E'"];

        //页面背景色

        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#f8f8f8'"];
    }

}


@end
