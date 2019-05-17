//
//  CloudCalculateForceVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/14.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "CloudCalculateForceVC.h"
#import "EggplantAccountVC.h"
#import "BuyMillListVC.h"
#import "MyMillVC.h"
#import "BeForceAccelerateVC.h"
#import "InviteRewardsVC.h"
#import "NodeLoginVC.h"
@interface CloudCalculateForceVC ()

@end

@implementation CloudCalculateForceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"云算力";
    self.navigationItem.titleView = self.titleText;
    
    NSArray *array = @[@"茄子账户",@"购买矿机",@"我的矿机",@"算力加速",@"邀请奖励",@"节点登录"];
    for (int i = 0; i < 6 ; i ++) {
        UIButton *iconBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        iconBtn.frame = CGRectMake(15 + i % 2 * (SCREEN_WIDTH - 15)/2, 15 + i / 2 * 150, (SCREEN_WIDTH - 45)/2, 130);
        [iconBtn theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        iconBtn.layer.cornerRadius=4;
        iconBtn.layer.shadowOpacity = 0.22;// 阴影透明度
        iconBtn.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        iconBtn.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
        iconBtn.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        iconBtn.tag = i;
        [self.view addSubview:iconBtn];
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 45)/2/2 - 20, 130/2 - 33.75, 40, 35)];
        iconImg.image = kImage(array[i]);
        [iconBtn addSubview:iconImg];
        
        UILabel *iconLbl = [UILabel labelWithFrame:CGRectMake(0, iconImg.yy + 12.5, (SCREEN_WIDTH - 45)/2, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:nil];
        iconLbl.text = array[i];
        [iconLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [iconBtn addSubview:iconLbl];
        
    }
    
}


-(void)iconBtnClick:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 0:
        {
            EggplantAccountVC *vc = [EggplantAccountVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            BuyMillListVC *vc = [BuyMillListVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            MyMillVC *vc = [MyMillVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            BeForceAccelerateVC *vc = [BeForceAccelerateVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            InviteRewardsVC *vc = [InviteRewardsVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            NodeLoginVC *vc = [NodeLoginVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

/*15
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
