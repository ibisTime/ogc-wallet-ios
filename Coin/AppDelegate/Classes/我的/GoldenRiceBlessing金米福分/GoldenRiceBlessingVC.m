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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationwhiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    // Do any additional setup after loading the view.
    self.title = @"金米福分";
    
    
    
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 100) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(30) textColor:kTextColor];
    [self.view addSubview:nameLbl];
    
    
    UILabel *blessing = [UILabel labelWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 100) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(30) textColor:kTextColor];
    blessing.text = [NSString stringWithFormat:@"我的福分：%ld分",self.blessing];
    [self.view addSubview:blessing];
    
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.code = @"805123";
    http.parameters[@"userId"] = [TLUser user].userId;
    //    http.parameters[@"parentCode"] = @"DH201810120023250400000";
    //    DH201810120023250401000
    [http postWithSuccess:^(id responseObject) {
        nameLbl.text = [NSString stringWithFormat:@"我的团队：%ld人",[responseObject[@"data"][@"refrereeCount"] integerValue]];
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
