//
//  PayTreasureVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/3.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "PayTreasureVC.h"
#import "PayTreasureView.h"
@interface PayTreasureVC ()

@end

@implementation PayTreasureVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = [LangSwitcher switchLang:@"订单详情" key:nil];

    self.navigationItem.titleView = self.titleText;
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
//        [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:[LangSwitcher switchLang:@"取消订单" key:nil] forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    PayTreasureView *backView = [[PayTreasureView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    backView.models = self.models;
    [backView.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backView];
    
}

-(void)completeBtnClick
{
//    [self complete:@"625273"];
    
    
    NSString *imageUrl = self.models.pic;
    imageUrl  = [imageUrl convertImageUrl];
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    [newImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGImageRef ref = newImage.image.CGImage;
        //2. 扫描获取的特征组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:ref]];
        //3. 获取扫描结果
        if (features.count>0) {
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scannedResult]]) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"alipayqr://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=%@",scannedResult]]];
                
                
                [TLAlert alertWithTitle:[LangSwitcher switchLang:@"支付提醒" key:nil] msg:[LangSwitcher switchLang:@"是否已成功支付" key:nil] confirmMsg:[LangSwitcher switchLang:@"支付完成" key:nil] cancleMsg:[LangSwitcher switchLang:@"前去支付" key:nil] cancle:^(UIAlertAction *action) {
                    
                    
                    [self completeBtnClick];
                    
                } confirm:^(UIAlertAction *action) {
                    [self complete:@"625273"];
                }];
                
                
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.scannedResult]];
            }else{
                [TLAlert alertWithInfo:@"请先下载支付宝App"];
                return ;
            }
        }else{
            [TLAlert alertWithInfo:@"收款码识别失败"];
        }
    }];
    
    
}

-(void)myRecodeClick
{
    [self complete:@"625272"];
}

-(void)complete:(NSString *)code
{
    CoinWeakSelf;
    TLNetworking *http = [[TLNetworking alloc] init];
    http.showView = weakSelf.view;
    http.code = code;
    http.parameters[@"code"] = self.models.code;
    
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        if ([code isEqualToString:@"625273"]) {
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"提交付款成功" key:nil]];
        }else
        {
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"订单已取消" key:nil]];
        }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"InvestmentLoadData" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {
        
    }];
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
