//
//  AddAddressVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "AddAddressVC.h"
#import "SelectedListModel.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
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
        textField.tag = 100 + i;
        [self.view addSubview:textField];
        
        
        if (i == 1) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.frame = textField.frame;
            [btn addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
            [self.view addSubview:btn];
            
            UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 7, textField.y + 4.5, 7, 12)];
            [youImg theme_setImageIdentifier:@"我的跳转" moduleName:ImgAddress];
            [self.view addSubview:youImg];
            
        }
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, textField.yy + 17, SCREEN_WIDTH - 30, 0.5)];
        lineView.backgroundColor = kHexColor([TLUser TextFieldPlacColor]);
        [self.view addSubview:lineView];
        
    }
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kTabbarColor titleFont:15];
    confirmBtn.frame = CGRectMake(15, 280, SCREEN_WIDTH - 30, 50);
    kViewRadius(confirmBtn, 2);
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmBtn];
    
}

-(void)buttonClick
{
     NSMutableArray *arr = [[CoinModel coin] getOpenCoinList];
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < arr.count; i ++) {
//        array addObject:arr[@""]
        CoinModel *model = arr[i];
        [array addObject:model.symbol];
    }
    
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0;  i < array.count; i ++) {
        [array1 addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",array[i]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array1;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];
            UITextField *textField2 = [self.view viewWithTag:101];
            textField2.text = model.title;
//            _payWayDic = _payWayArray[model.sid];
//            self.tableView.payWayDic = self.payWayDic;
//            [self.tableView reloadData];
        }];
    };
    if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
        [LEEAlert alert].config
        .LeeHeaderColor(kHexColor(@"52565D"))
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    }else
    {
        [LEEAlert alert].config
        .LeeHeaderColor(kHexColor(@"#ffffff"))
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    }
}

-(void)confirmBtnClick:(UIButton *)sender
{
    UITextField *textField1 = [self.view viewWithTag:100];
    UITextField *textField2 = [self.view viewWithTag:101];
    UITextField *textField3 = [self.view viewWithTag:102];
    
    
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入地址名称"];
        return;
    }
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择地址类型"];
        return;
    }
    if ([textField3.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入地址"];
        return;
    }
    
    
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"802010";
    http.showView = self.view;
    http.parameters[@"address"] = textField3.text;
    http.parameters[@"symbol"] = textField2.text;
    http.parameters[@"label"] = textField1.text;
    http.parameters[@"isCerti"] = @"0";
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        NSNotification *notification =[NSNotification notificationWithName:@"addaddress" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSError *error) {
        
    }];
}

@end
