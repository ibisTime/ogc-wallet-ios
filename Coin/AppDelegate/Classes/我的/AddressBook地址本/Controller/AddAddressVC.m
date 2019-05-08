//
//  AddAddressVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AddAddressVC.h"
@interface AddAddressVC ()<RefreshDelegate>




@end
@implementation AddAddressVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleText.text = @"添加";
    self.navigationItem.titleView = self.titleText;
    NSArray *array = @[@"请输入地址名称",@"地址类型",@"请输入地址"];
    for (int i = 0; i < 3; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 17 + i % 3 * 56,  SCREEN_WIDTH - 30, 21)];
        textField.placeholder = array[i];
        [textField setValue:FONT(15) forKeyPath:@"_placeholderLabel.font"];
        textField.font = FONT(15);
        textField.textColor = kHexColor([TLUser TextFieldTextColor]);
        [textField setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:textField];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, textField.yy + 17, SCREEN_WIDTH - 30, 0.5)];
        lineView.backgroundColor = kHexColor([TLUser TextFieldPlacColor]);
        [self.view addSubview:lineView];
        
    }
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:15];
    confirmBtn.frame = CGRectMake(15, 280, SCREEN_WIDTH - 30, 50);
    kViewRadius(confirmBtn, 2);
    [self.view addSubview:confirmBtn];
    
}

@end
