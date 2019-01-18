//
//  HBAlertPasswordView.m
//  TestPassward
//
//  Created by JING XU on 17/5/21.
//  Copyright © 2017年 HB. All rights reserved.
//

#import "HBAlertPasswordView.h"

@interface HBAlertPasswordView ()
<UITextFieldDelegate>

/** 密码的TextField */
@property (nonatomic, strong) UITextField *passwordTextField;
/** 黑点的个数 */
@property (nonatomic, strong) NSMutableArray *pointArr;
/** 输入安全密码的背景View */
//@property (nonatomic, strong) UIView *BGView;

@end

// 密码点的大小
#define kPointSize CGSizeMake(10, 10)
// 密码个数
#define kPasswordCount 6
// 每一个密码框的高度
#define kBorderHeight 45
// 按钮的高度
#define kButtonHeight 49
// 宏定义屏幕的宽和高
#define HB_ScreenW [UIScreen mainScreen].bounds.size.width
#define HB_ScreenH [UIScreen mainScreen].bounds.size.height

@implementation HBAlertPasswordView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 背景颜色
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        // 输入安全密码的背景View
//        UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH - 30  , 590/2)];
//        BGView.backgroundColor = [UIColor whiteColor];
//        BGView.layer.cornerRadius = 10;
//
//        BGView.layer.masksToBounds = YES;
//        [self addSubview:BGView];
//        self.BGView = BGView;
//        BGView.center = self.center;
        
        CGFloat BGViewW = (SCREEN_WIDTH - 30);
        CGFloat BGViewH = 590/2;
        // 请输入安全密码的Label
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight(56)/2, BGViewW, 12)];
        titleLabel.font = FONT(12);
        titleLabel.text = @"卖出BTC";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = kTextColor2;
        [self addSubview:titleLabel];
        
        // 横线
//        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), BGViewW, 1)];
//        topLineView.backgroundColor = kLineColor;
//        [BGView addSubview:topLineView];
        
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(0, titleLabel.yy + 15, BGViewW, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(20) textColor:kTextBlack];
//        priceLabel.text = @"26.3BTC";
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        
        UILabel *promptLabel = [UILabel labelWithFrame:CGRectMake(0, priceLabel.yy + 30, BGViewW, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        promptLabel.text = @"请输入资金密码";
        [self addSubview:promptLabel];
//        UIView *downLineView = [[UIView alloc] initWithFrame:CGRectMake(0, BGViewH - kButtonHeight - 1, BGViewW, 1)];
//        downLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
//        [BGView addSubview:downLineView];
        
        // 取消按钮
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, BGViewH - 50, BGViewW / 2, 50);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:kTextColor2 forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        // 确定按钮
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(cancelButton.xx, BGViewH - 50, BGViewW / 2, 50);
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:kTextColor2 forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureButton];
        
        UIView *lineHView = [[UIView alloc] initWithFrame:CGRectMake(BGViewW/2 - 0.5, BGViewH - 50, 1, 50)];
        lineHView.backgroundColor = kLineColor;
        [self addSubview:lineHView];
        
        UIView *lineWView = [[UIView alloc] initWithFrame:CGRectMake(0, BGViewH - 50, BGViewW, 1)];
        lineWView.backgroundColor = kLineColor;
        [self addSubview:lineWView];
        
        // 密码框
        CGFloat passwordTextFieldY = promptLabel.yy + 15;
        UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, passwordTextFieldY , SCREEN_WIDTH - 60, 53)];
        passwordTextField.backgroundColor = kBackgroundColor;
        // 输入的文字颜色为白色
        passwordTextField.textColor = kBackgroundColor;
        // 输入框光标的颜色为白色
        passwordTextField.tintColor = kBackgroundColor;
        passwordTextField.delegate = self;
        passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        passwordTextField.layer.borderColor = kLineColor.CGColor;
        passwordTextField.layer.borderWidth = 1;
        [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:passwordTextField];
        // 页面出现时弹出键盘
        [passwordTextField becomeFirstResponder];
        self.passwordTextField = passwordTextField;
        
        // 生产分割线
        for (NSInteger i = 0; i < 5; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15 + (SCREEN_WIDTH - 60)/6 + i % 5*(SCREEN_WIDTH - 60)/6, passwordTextFieldY, 1, 53)];
            lineView.backgroundColor = kLineColor;
            [self addSubview:lineView];
        }
        
        self.pointArr = [NSMutableArray array];
        
        // 生成中间的点
        for (NSInteger i = 0; i < 6; i++) {
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake( 15 + (SCREEN_WIDTH - 60)/6/2 - 4 + i % 6*(SCREEN_WIDTH - 60)/6 ,  passwordTextFieldY + 53 /2 - 4, 8, 8)];
            pointView.backgroundColor = kTextBlack;
            pointView.layer.cornerRadius = 4;
            pointView.layer.masksToBounds = YES;
            // 先隐藏
            pointView.hidden = YES;
            [self addSubview:pointView];
            // 把创建的黑点加入到数组中
            [self.pointArr addObject:pointView];
        }
        
        // 监听键盘的高度
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"变化%@", string);
    if ([string isEqualToString:@"\n"]) {
        // 按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        // 判断是不是删除键
        return YES;
    } else if (textField.text.length >= kPasswordCount) {
        // 输入的字符个数大于6
//        NSLog(@"输入的字符个数大于6,忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 清除密码
 */
- (void)clearUpPassword {
    
    self.passwordTextField.text = @"";
    [self textFieldDidChange:self.passwordTextField];
}

/**
 重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField {
//    NSLog(@"%@", textField.text);
    for (UIView *pointView in self.pointArr) {
        pointView.hidden = YES;
    }
    for (NSInteger i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.pointArr objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kPasswordCount) {
//        NSLog(@"输入完毕,密码为%@", textField.text);
    }
}

#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
}

#pragma mark - 按钮的执行方法
// 取消按钮
- (void)cancelButtonAction {
    
//    [self removeFromSuperview];
    [self clearUpPassword];
    [[UserModel user].cusPopView dismiss];
}

// 确定按钮
- (void)sureButtonAction {
    
    if ([self.delegate respondsToSelector:@selector(sureActionWithAlertPasswordView:password:)]) {
        [self.delegate sureActionWithAlertPasswordView:self password:self.passwordTextField.text];
        [self clearUpPassword];
    }
}

#pragma mark - 键盘的出现和收回的监听方法
//- (void)keyboardWillShow:(NSNotification *)aNotification {
//    // 获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    CGFloat keyboardHeight = keyboardRect.size.height;
//    self.BGView.frame = CGRectMake(self.BGView.frame.origin.x, HB_ScreenH - keyboardHeight - self.BGView.frame.size.height - 30, self.BGView.frame.size.width, self.BGView.frame.size.height);
//}

//- (void)keyboardWillHide:(NSNotification *)aNotification {
//    self.BGView.center = CGPointMake(self.BGView.center.x, self.center.y);
//}

@end
