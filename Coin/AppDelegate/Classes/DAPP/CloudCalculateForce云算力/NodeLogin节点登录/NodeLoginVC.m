//
//  NodeLoginVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/16.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "NodeLoginVC.h"
#import "NodesSummarizedVC.h"
@interface NodeLoginVC ()

@end

@implementation NodeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleText.text = @"节点登录";
    self.navigationItem.titleView = self.titleText;
    
    NSArray *array = @[@"请输入账号",@"请输入密码"];
    for (int i = 0; i < 2; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 20 + i% 2 * 60, SCREEN_WIDTH - 30, 50)];
        textField.placeholder = [LangSwitcher switchLang:array[i] key:nil];
        [textField setValue:FONT(16) forKeyPath:@"_placeholderLabel.font"];
        textField.font = FONT(16);
        
        textField.tag = 100 + i;
        if (i == 0) {
            textField.text = [TLUser user].mobile;
            textField.enabled = YES;
        }
        
        textField.textColor = kHexColor([TLUser TextFieldTextColor]);
        [textField setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
        [self.view addSubview:textField];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, textField.yy, SCREEN_WIDTH - 30, 1)];
        [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
        [self.view addSubview:lineView];
    }
    
    UIButton *changePwdBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确定" key:nil] titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:16.0 cornerRadius:5];
    changePwdBtn.frame = CGRectMake(15, 290, SCREEN_WIDTH - 30, 48);
    [changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePwdBtn];
}

-(void)changePwd
{
    
    UITextField *textField1 = [self.view viewWithTag:100];
    UITextField *textField2 = [self.view viewWithTag:101];

    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入账号"];
        return;
    }
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入密码"];
        return;
    }

    TLNetworking *http = [TLNetworking new];
    http.code = @"805097";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"logName"] = textField1.text;
    http.parameters[@"nodePwd"] = textField2.text;
    [http postWithSuccess:^(id responseObject) {
    
        
        NodesSummarizedVC *vc = [NodesSummarizedVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
        
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
