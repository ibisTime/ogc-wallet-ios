//
//  DropletModelProtocolView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/27.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "DropletModelProtocolView.h"

@implementation DropletModelProtocolView
{
//    UIScrollView *scrollView;
    UIWebView *webView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 76, 444)];
        kViewRadius(backView, 4);
        backView.backgroundColor = kWhiteColor;
//        [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [self addSubview:backView];
        
        
//        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 76, 444 - 40)];
//        [backView addSubview:scrollView];
        
        
        UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(0, 25, SCREEN_WIDTH - 76, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:nil];
        titleLbl.textColor = kBlackColor;
        titleLbl.text = @"“水滴模型”服务使用协议";
        [backView addSubview:titleLbl];
        
//        contactLbl = [UILabel labelWithFrame:CGRectMake(15, titleLbl.yy + 20, SCREEN_WIDTH - 106, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
//        [backView addSubview:contactLbl];
        
        
        webView = [[UIWebView alloc]initWithFrame:CGRectMake(15, titleLbl.yy + 20, SCREEN_WIDTH - 106, 444 - titleLbl.yy - 20 - 60)];
        webView.delegate = self;
//        [webView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        webView.backgroundColor = kWhiteColor;
        [backView addSubview:webView];
        
        
        UIButton *cancelBtn = [UIButton buttonWithTitle:@"退出" titleColor:kTabbarColor backgroundColor:kHexColor(@"F0F0F0") titleFont:14];
        cancelBtn.frame = CGRectMake(0, 444 - 40, (SCREEN_WIDTH - 76)/2, 40);
        self.cancelBtn = cancelBtn;
//        [cancelBtn theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [backView addSubview:cancelBtn];
        
        
        
        UIButton *confirmBtn = [UIButton buttonWithTitle:@"同意" titleColor:kTabbarColor backgroundColor:kHexColor(@"F0F0F0") titleFont:14];
        confirmBtn.frame = CGRectMake((SCREEN_WIDTH - 76)/2, 444 - 40, (SCREEN_WIDTH - 76)/2, 40);
        [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:confirmBtn];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(cancelBtn.xx , cancelBtn.y + 10, 0.5, 20)];
        lineView.backgroundColor = kLineColor;
        [backView addSubview:lineView];
        
        
        
    }
    return self;
}

//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//    if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
//        //字体颜色
//
//        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"];
//
//        //页面背景色
//
//        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#282A2E'"];
//    }else
//    {
//        //字体颜色
//
//        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#282A2E'"];
//
//        //页面背景色
//
//        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#f8f8f8'"];
//    }
//
//}

-(void)setContact:(NSString *)contact
{
//    contactLbl.attributedText = [UserModel ReturnsTheDistanceBetween:contact];
//    [contactLbl sizeToFit];
    [webView loadHTMLString:contact baseURL:nil];
//    scrollView.contentSize = CGSizeMake(0, contactLbl.yy + 20);
}

-(void)confirmBtnClick
{
    [[UserModel user].cusPopView dismiss];
}

@end
