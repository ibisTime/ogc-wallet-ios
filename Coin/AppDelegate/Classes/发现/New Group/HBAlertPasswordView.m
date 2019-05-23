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
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 590/2 - 50)];
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        kViewRadius(backView, 8);
        [self addSubview:backView];
        
        
        
        CGFloat BGViewW = (SCREEN_WIDTH - 30);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight(56)/2, BGViewW, 12)];
        titleLabel.font = FONT(12);
        titleLabel.text = [NSString stringWithFormat:@"%@",[LangSwitcher switchLang:@"卖出" key:nil]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.textColor = kTextColor2;
        [titleLabel theme_setTextColorIdentifier:LabelColor moduleName:ColorName];
        [self addSubview:titleLabel];

        
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(0, titleLabel.yy + 15, BGViewW, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(20) textColor:kTextBlack];
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        
        UILabel *promptLabel = [UILabel labelWithFrame:CGRectMake(0, priceLabel.yy + 30, BGViewW, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        promptLabel.text = [LangSwitcher switchLang:@"请输入交易密码" key:nil];
        [self addSubview:promptLabel];
        
        // 密码框
        CGFloat passwordTextFieldY = promptLabel.yy + 15;
        UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, passwordTextFieldY , SCREEN_WIDTH - 60, 53)];
        if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
            passwordTextField.backgroundColor = kHexColor(@"#52565D");
            // 输入的文字颜色为白色
            passwordTextField.textColor = kHexColor(@"#52565D");
            // 输入框光标的颜色为白色
            passwordTextField.tintColor = kHexColor(@"#52565D");
        }else
        {
            passwordTextField.backgroundColor = kHexColor(@"#FFFFFF");
            // 输入的文字颜色为白色
            passwordTextField.textColor = kHexColor(@"#FFFFFF");
            // 输入框光标的颜色为白色
            passwordTextField.tintColor = kHexColor(@"#FFFFFF");
        }
        
        
        //        0x282A2E
        //        0xCFD7E6
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
            [lineView theme_setBackgroundColorIdentifier:LineViewColor moduleName:ColorName];
            [self addSubview:lineView];
        }
        
        self.pointArr = [NSMutableArray array];
        
        // 生成中间的点
        for (NSInteger i = 0; i < 6; i++) {
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake( 15 + (SCREEN_WIDTH - 60)/6/2 - 4 + i % 6*(SCREEN_WIDTH - 60)/6 ,  passwordTextFieldY + 53 /2 - 4, 8, 8)];
            //            pointView.backgroundColor = kTextBlack;
            [pointView theme_setBackgroundColorIdentifier:LabelColor moduleName:ColorName];
            pointView.layer.cornerRadius = 4;
            pointView.layer.masksToBounds = YES;
            // 先隐藏
            pointView.hidden = YES;
            [self addSubview:pointView];
            // 把创建的黑点加入到数组中
            [self.pointArr addObject:pointView];
        }

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
    if (textField.text.length == 6) {
        if ([self.delegate respondsToSelector:@selector(sureActionWithAlertPasswordView:password:)]) {
            [self.delegate sureActionWithAlertPasswordView:self password:textField.text];
            [self clearUpPassword];
        }
    }
}

#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    [self clearUpPassword];
    [[UserModel user].cusPopView dismiss];
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

@end
