//
//  lookingForwardVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/9.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "lookingForwardVC.h"

@interface lookingForwardVC ()

@end

@implementation lookingForwardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 35, 200, 70, 70)];
    [img theme_setImageIdentifier:@"敬请期待" moduleName:ImgAddress];
    [self.view addSubview:img];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, img.yy + 20, SCREEN_WIDTH, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(14) textColor:nil];
    nameLbl.text = @"敬请期待...";
    [self.view addSubview:nameLbl];
    
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
