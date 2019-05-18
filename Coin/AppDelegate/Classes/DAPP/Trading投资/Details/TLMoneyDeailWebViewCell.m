//
//  TLMoneyDeailWebViewCell.m
//  Coin
//
//  Created by QinBao Zheng on 2018/10/16.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLMoneyDeailWebViewCell.h"

@implementation TLMoneyDeailWebViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        
        
        self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        self.web.delegate = self;
        self.web.scrollView.bounces=NO;
        self.web.scrollView.showsHorizontalScrollIndicator = NO;
        self.web.scrollView.scrollEnabled = NO;
        self.web.backgroundColor = kWhiteColor;
        self.web.dataDetectorTypes=UIDataDetectorTypeNone;
        [self.web theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [self addSubview:self.web];
    }
    return self;
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
