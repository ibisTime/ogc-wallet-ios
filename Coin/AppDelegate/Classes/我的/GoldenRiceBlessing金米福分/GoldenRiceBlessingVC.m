//
//  GoldenRiceBlessingVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/3/24.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "GoldenRiceBlessingVC.h"
#import <WebKit/WebKit.h>
@interface GoldenRiceBlessingVC ()

@property (nonatomic , strong)WKWebView *webView;

@end

@implementation GoldenRiceBlessingVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self navigationwhiteColor];
    
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
    [topImage addSubview:nameLbl];
    
    
    UILabel *numbernLbl = [UILabel labelWithFrame:CGRectMake(30, (SCREEN_WIDTH - 30)/2/3, SCREEN_WIDTH, (SCREEN_WIDTH - 30)/2/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(30) textColor:kWhiteColor];
    numbernLbl.text = @"0";
    [topImage addSubview:numbernLbl];
    
    
    UILabel *blessing = [UILabel labelWithFrame:CGRectMake(30, (SCREEN_WIDTH - 30)/2/3*2- 20, SCREEN_WIDTH, (SCREEN_WIDTH - 30)/2/3) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kWhiteColor];
    blessing.text = @"我的团队：0人";
    [topImage addSubview:blessing];
    
    
    
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.code = @"805913";
    http.parameters[@"userId"] = [TLUser user].userId;
    //    http.parameters[@"parentCode"] = @"DH201810120023250400000";
    //    DH201810120023250401000
    
    
    
    [http postWithSuccess:^(id responseObject) {
        numbernLbl.text = [NSString stringWithFormat:@"%.2f",[responseObject[@"data"][@"totalAward"] floatValue]/100000000];
    } failure:^(NSError *error) {
        
    }];
    
    
    TLNetworking *http1 = [TLNetworking new];
    //    http.showView = self.view;
    http1.code = @"805123";
    http1.showView = self.view;
    http1.parameters[@"userId"] = [TLUser user].userId;
    //    http.parameters[@"parentCode"] = @"DH201810120023250400000";
    //    DH201810120023250401000
    [http1 postWithSuccess:^(id responseObject) {
//        nameLbl.text = [NSString stringWithFormat:@"我的团队：%ld人",[responseObject[@"data"][@"refrereeCount"] integerValue]];
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
    
//    UILabel *rulesLbl1 = [UILabel labelWithFrame:CGRectMake(20, rulesLbl.yy + 15, SCREEN_WIDTH - 40, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kHexColor(@"#999999")];
//
//    rulesLbl1.attributedText = [UserModel ReturnsTheDistanceBetween:@"1.邀请人A可从一级好友B（B注册一年内）和二级好友C的年化出借额中获得不同合伙人级别对应返现比例的奖励。\n2.返现奖励逐月发放，散标将在好友还款日当日发放，智选服务在好友进入服务期限的次月当日发放。"];
//    rulesLbl1.numberOfLines = 0;
//    [rulesLbl1 sizeToFit];
//    [self.view addSubview:rulesLbl1];
    
    
    
    NSString *jS = [NSString stringWithFormat:@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'); meta.setAttribute('width', %lf); document.getElementsByTagName('head')[0].appendChild(meta);",kScreenWidth];
    
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jS injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *wkUCC = [WKUserContentController new];
    
    [wkUCC addUserScript:wkUserScript];
    
    WKWebViewConfiguration *wkConfig = [WKWebViewConfiguration new];
    
    wkConfig.userContentController = wkUCC;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(20, rulesLbl.yy + 15, SCREEN_WIDTH - 40, SCREEN_HEIGHT - kNavigationBarHeight - rulesLbl.yy - 25) configuration:wkConfig];
    
    _webView.backgroundColor = kWhiteColor;
    
//    _webView.navigationDelegate = self;
    
    _webView.allowsBackForwardNavigationGestures = YES;
//    [_webView.scrollView adjustsContentInsets];
    [self.view addSubview:_webView];
    
    
    TLNetworking *http2 = [TLNetworking new];
    http2.showView = self.view;
    http2.code = USER_CKEY_CVALUE;
    
    http2.parameters[SYS_KEY] = @"activety_notice";
    
    [http2 postWithSuccess:^(id responseObject) {
        
//        self.htmlStr = ;
//        [_webView loadWebWithString:responseObject[@"data"][@"cvalue"]];
        [_webView loadHTMLString:responseObject[@"data"][@"cvalue"] baseURL:nil];
    } failure:^(NSError *error) {
        
    }];
    
    
}


@end
