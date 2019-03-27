//
//  GoldenRiceBlessingVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/3/24.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "GoldenRiceBlessingVC.h"

@interface GoldenRiceBlessingVC ()

@end

@implementation GoldenRiceBlessingVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self navigationwhiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    // Do any additional setup after loading the view.
    self.title = @"金米福分";
    
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
        numbernLbl.text = [NSString stringWithFormat:@"%ld",[responseObject[@"data"][@"regAcount"] integerValue]];
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
