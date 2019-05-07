//
//  AlertsVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/5.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AlertsVC.h"

@interface AlertsVC ()




@end

@implementation AlertsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array = @[@"白色",@"黑色"];
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [UIButton buttonWithTitle:array[i] titleColor:kWhiteColor backgroundColor:[UIColor redColor] titleFont:18];
        button.frame = CGRectMake(0, 100 + i % 2 * 100, SCREEN_WIDTH, 100);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = i;
        [self.view addSubview:button];
    }
}

-(void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        NSString *path = [NSBundle mainBundle].bundlePath;
        path = [path stringByAppendingPathComponent:@"Theme/Theme1"];
        [MTThemeManager.manager setThemePath:path];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    }else
    {
        NSString *path = [NSBundle mainBundle].bundlePath;
        path = [path stringByAppendingPathComponent:@"Theme/Theme2"];
        
        [MTThemeManager.manager setThemePath:path];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }

}



@end
