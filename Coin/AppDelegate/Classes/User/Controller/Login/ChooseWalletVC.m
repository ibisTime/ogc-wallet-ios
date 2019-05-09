//
//  ChooseWalletVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/9.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "ChooseWalletVC.h"
#import "WalletImportVC.h"
#import "BuildWalletMineVC.h"
@interface ChooseWalletVC ()

@end

@implementation ChooseWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [USERDEFAULTS setObject:@"" forKey:@"mnemonics"];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(19, 77 - 64   + 33.5 - 6, 85, 4)];
    lineView.backgroundColor = kTabbarColor;
    [self.view addSubview:lineView];
    
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 77 - 64, SCREEN_WIDTH - 30, 33.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(24) textColor:nil];
    nameLabel.text = @"钱包选择";
    [self.view addSubview:nameLabel];
    
    NSArray *array = @[@"零用钱包",@"创建钱包",@"导入钱包"];
    for (int i = 0; i < 3; i ++) {
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backBtn.frame = CGRectMake(15, nameLabel.yy + 30 + i % 3 * 165, SCREEN_WIDTH - 30, 150);
        kViewRadius(backBtn, 5);
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backBtn.tag = i;
        [backBtn theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        [self.view addSubview:backBtn];
        
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 30)/2 - 25, 37.5, 50, 45)];
        [backBtn addSubview:iconImg];
        [iconImg theme_setImageIdentifier:array[i] moduleName:ImgAddress];
        UILabel *iconLbl = [UILabel labelWithFrame:CGRectMake(0, iconImg.yy + 11, SCREEN_WIDTH - 30, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(16) textColor:nil];
        
        iconLbl.text = array[i];
        [backBtn addSubview:iconLbl];
    }
    
}

-(void)backBtnClick:(UIButton *)sender
{
 
    if (sender.tag == 0) {
        TLUpdateVC *tab   = [[TLUpdateVC alloc] init];
        [USERDEFAULTS setObject:@"" forKey:@"mnemonics"];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    }
    if (sender.tag == 1) {
        BuildWalletMineVC *vc = [BuildWalletMineVC new];
        vc.state = @"100";
        [self.navigationController pushViewController:vc animated:YES];
//        UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
//        [UIApplication sharedApplication].keyWindow.rootViewController = nv;
    }
    if (sender.tag == 2) {
        
        WalletImportVC *vc = [WalletImportVC new];
        vc.state = @"100";
        [self.navigationController pushViewController:vc animated:YES];
    }
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
