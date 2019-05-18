//
//  GeneralWebView.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/6.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "GeneralWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WYWebProgressLayer.h"
#import "UIView+Frame.h"
#import "WLWebProgressLayer.h"
#import "NSURLRequest+NSURLRequestSSLY.h"
//@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

@interface GeneralWebView ()<UIWebViewDelegate,NSURLConnectionDelegate>
{
    WYWebProgressLayer *_progressLayer; // 网页加载进度条
    UILabel *nameLable;
    
}

@property (nonatomic,strong) JSContext *jsContext;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation GeneralWebView


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    nameLable = [[UILabel alloc]initWithFrame:CGRectMake(54, kStatusBarHeight, kScreenWidth - 108, 44)];
//    nameLable.text = [LangSwitcher switchLang:@"攻略" key:nil];
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.font = Font(16);
    nameLable.textColor = kTextBlack;
    self.navigationItem.titleView = nameLable;
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 2)];
    self.webView.delegate = self;
    self.webView.backgroundColor = kWhiteColor;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
    
    nameLable.text = self.name;
    
//    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[[NSURL URLWithString:_URL] host]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    [_webView loadRequest:request];
    [self.view addSubview:self.webView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(rightBtnClick)];
    
//    [ NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:_URL];
    
//    [NSURLRequest allowsAnyHTTPSCertificateForHost:_URL];
}


-(BOOL)connection:(NSURLConnection*)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace*)protectionSpace {
    return[protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

-(void)connection:(NSURLConnection*)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge*)challenge {
//    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
//        if([trustedHosts containsObject:challenge.protectionSpace.host])
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
//如果使用web view来请求网页的话，添加这么一句



#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _progressLayer = [WYWebProgressLayer layerWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    
    [self.view.layer addSublayer:_progressLayer];
    [_progressLayer startLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressLayer finishedLoad];
//    nameLable.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


-(void)rightBtnClick
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_URL]]]];
}

@end