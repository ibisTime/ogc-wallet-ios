//
//  WalletLocalWebVC.m
//  Coin
//
//  Created by shaojianfei on 2018/6/15.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WalletLocalWebVC.h"
#import "AppConfig.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface WalletLocalWebVC ()<UIWebViewDelegate>
@property (nonatomic ,strong) UIWebView *web;
@end

@implementation WalletLocalWebVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleText.text = [LangSwitcher switchLang:@"更多" key:nil];
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - kNavigationBarHeight)];
//    self.web.scalesPageToFit = YES;
    [self.view addSubview:self.web];
    self.web.delegate = self;
    TLDataBase *dataBase = [TLDataBase sharedManager];
    NSString *type = self.currentModel.type;
    CoinModel *coin = [CoinUtil getCoinModel:self.currentModel.symbol];
    self.currentModel.type = coin.type;
//    if ([dataBase.dataBase open]) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT type from THALocal where symbol = '%@'",self.currentModel.symbol];
//        //        [sql appendString:[TLUser user].userId];
//        FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//        while ([set next])
//        {
//            type = [set stringForColumn:@"type"];
//            
//        }
//        [set close];
//    }
    
//    [dataBase.dataBase close];
    
    
    
    //    兼容2.0以下私钥数据库
    ////        ETH("0", "以太币"), BTC("1", "比特币"), WAN("2", "万维"), USDT("3", "泰达币")
    // 基于某条公链的token币
    //        , ETH_TOKEN("0T", "以太token币"), WAN_TOKEN("2T", "万维token币");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([self.currentModel.type isEqualToString:@"0"]) {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].ethHash,self.urlString]]]];
    }
    if ([self.currentModel.type isEqualToString:@"1"]) {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/tx/%@",[AppConfig config].btcHash,self.urlString]]]];
    }
    if ([self.currentModel.type isEqualToString:@"2"]) {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].wanHash,self.urlString]]]];
    }
    if ([self.currentModel.type isEqualToString:@"3"]) {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[AppConfig config].trxHash,@"#/transaction/search/",self.urlString]]]];
    }
    if ([self.currentModel.type isEqualToString:@"0T"]) {
        
        NSLog(@"====%@",[NSString stringWithFormat:@"%@/%@",[AppConfig config].ethHash,self.urlString]);
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].ethHash,self.urlString]]]];
    }
    if ([self.currentModel.type isEqualToString:@"2T"]) {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].ethHash,self.urlString]]]];
    }
    
//    if ([self.currentModel.symbol isEqualToString:@"USDT"]) {
//
//        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"https://omniexplorer.info/search/",self.urlString]]]];
//
//    }else
//    {
//        if ([type isEqualToString:@"0"]) {
//            if ([self.currentModel.symbol isEqualToString:@"ETH"]) {
//                [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].ethHash,self.urlString]]]];
//            }else if([self.currentModel.symbol isEqualToString:@"WAN"]){
//
//                [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].wanHash,self.urlString]]]];
//
//            }else{
//                [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/tx/%@",[AppConfig config].btcHash,self.urlString]]]];
//            }
//        }else if ([type isEqualToString:@"1"])
//        {
//            [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].ethHash,self.urlString]]]];
//
//        }else{
//
//            [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppConfig config].ethHash,self.urlString]]]];
//        }
//    }
    
    
   
   
    
    
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


@end
