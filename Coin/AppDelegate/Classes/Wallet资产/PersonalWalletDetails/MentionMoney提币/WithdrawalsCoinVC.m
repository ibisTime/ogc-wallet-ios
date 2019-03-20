//
//  WithdrawalsCoinVC.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/13.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "WithdrawalsCoinVC.h"

#import "UIBarButtonItem+convience.h"
#import "TLAlert.h"
#import "NSString+Check.h"
#import "UIViewController+BackButtonHander.h"
#import "APICodeMacro.h"

#import "BillVC.h"
#import "TLCoinWithdrawOrderVC.h"
#import "TLTextField.h"
#import "FilterView.h"
#import "QRCodeVC.h"
#import "CoinAddressModel.h"
#import "ZQFaceAuthEngine.h"
#import "ZQOCRScanEngine.h"
#import "TLUploadManager.h"

typedef NS_ENUM(NSInteger, AddressType) {
    
    AddressTypeSelectAddress = 0,       //选择地址
    AddressTypeScan,                    //扫码
    AddressTypeCopy,                    //复制粘贴
};

@interface WithdrawalsCoinVC ()<ZQFaceAuthDelegate,ZQOcrScanDelegate>
{
    UILabel *poundageLabel;
    NSString *str1;
    NSString *str2;
    NSString *str3;
}

//可用余额
@property (nonatomic, strong) TLTextField *balanceTF;
//接收地址
@property (nonatomic, strong) UILabel *receiveAddressLbl;
//选择
@property (nonatomic, strong) FilterView *coinAddressPicker;
//转账数量
@property (nonatomic, strong) TLTextField *tranAmountTF;
//谷歌验证码
@property (nonatomic, strong) TLTextField *googleAuthTF;
//矿工费
@property (nonatomic, strong) TLTextField *minerFeeTF;
//开关
@property (nonatomic, strong) UISwitch *sw;
//提示
@property (nonatomic, strong) UIView *minerView;
//确认付币
@property (nonatomic, strong) UIButton *confirmBtn;
//手续费率
@property (nonatomic, copy) NSString *withdrawFee;
//地址类型
@property (nonatomic, assign) AddressType addressType;
//地址
@property (nonatomic, strong) CoinAddressModel *addressModel;

@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic, strong) UILabel * blanceFree;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation WithdrawalsCoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LangSwitcher switchLang:@"转出" key:nil];
    self.view.backgroundColor = kBackgroundColor;
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:[LangSwitcher switchLang:@"记录" key:nil] forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    //
    [self initSubviews];
    //获取手续费费率
    [self setWithdrawFee];
    
}

//- (BOOL)navigationShouldPopOnBackButton {
//
//    [self.navigationController popToRootViewControllerAnimated:YES];
//
//    return NO;
//}

-(void)rightButtonClick
{
    TLCoinWithdrawOrderVC *withdrawOrderVC = [[TLCoinWithdrawOrderVC alloc] init];
    withdrawOrderVC.currency = self.currency;
    withdrawOrderVC.titleString = [LangSwitcher switchLang:@"转出订单" key:nil];
    [self.navigationController pushViewController:withdrawOrderVC animated:YES];
}




- (void)initSubviews {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    backView.backgroundColor = kWhiteColor;
    [self.view addSubview:backView];
    
    


    UILabel *blance = [UILabel labelWithBackgroundColor:kClearColor textColor:[UIColor blackColor] font:13];
    blance.text = [LangSwitcher switchLang:@"可用余额" key:nil];
    [self.view addSubview:blance];
    [blance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
//        make.centerX.equalTo(bgImage.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.height.equalTo(@50);
    }];
    
    UILabel *symbolBlance = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(54, 73, 198) font:13];
    [self.view addSubview:symbolBlance];
    
//    NSString *leftAmount = [self.currency.amountString subNumber:self.currency.frozenAmountString];
//    NSString *currentCurrency = self.currency.currency;
//    symbolBlance.text = [NSString stringWithFormat:@"%@ %@",[CoinUtil convertToRealCoin:leftAmount coin:currentCurrency],currentCurrency];

    NSString *leftAmount = [self.currency.amount subNumber:self.currency.frozenAmount];
    symbolBlance.text = [NSString stringWithFormat:@"%@%@",[CoinUtil convertToRealCoin:leftAmount coin:self.currency.currency],self.currency.currency];
    
    [symbolBlance mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(blance.mas_right).offset(15);
        make.height.equalTo(@50);
    }];
    
    CGFloat heightMargin = 50;
    
    


    self.balanceTF = [[TLTextField alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth - 30, 50) leftTitle:[LangSwitcher switchLang:@"接收地址" key:nil] titleWidth:80 placeholder:[LangSwitcher switchLang:@"请输入付币地址或扫码" key:nil]];
    
    self.balanceTF.textColor = kHexColor(@"#109ee9");
    self.balanceTF.leftLbl.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.balanceTF];

    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:kImage(@"扫一扫-黑色")];
    rightArrow.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:rightArrow];
    rightArrow.userInteractionEnabled = YES;
    [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.centerY.equalTo(self.balanceTF.mas_centerY);
        make.width.equalTo(@18);
        make.height.equalTo(@18);
        
    }];
    
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [rightArrow addGestureRecognizer:ta];

    //
    UIButton *receiveBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, self.balanceTF.yy + 10, kScreenWidth, heightMargin)];

    [receiveBtn addTarget:self action:@selector(selectCoinAddress) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:receiveBtn];

    //谷歌验证码
    self.googleAuthTF = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.balanceTF.yy, kScreenWidth, heightMargin) leftTitle:[LangSwitcher switchLang:@"谷歌验证码" key:nil] titleWidth:80 placeholder:[LangSwitcher switchLang:@"请输入谷歌验证码" key:nil] ];
    
    self.googleAuthTF.keyboardType = UIKeyboardTypeNumberPad;
    self.googleAuthTF.hidden = NO;
    [self.view addSubview:self.googleAuthTF];
    
    //复制
    UIView *authView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 95, self.googleAuthTF.height)];
    
    UIButton *pasteBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"粘贴" key:nil] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:13.0 cornerRadius:5];
    pasteBtn.frame = CGRectMake(0, 0, 85, self.googleAuthTF.height - 15);
    pasteBtn.centerY = authView.height/2.0;
    [pasteBtn addTarget:self action:@selector(clickPaste) forControlEvents:UIControlEventTouchUpInside];
    [authView addSubview:pasteBtn];
    self.googleAuthTF.rightView = authView;
    

    
    
    //转账数量
    self.tranAmountTF = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.balanceTF.yy, kScreenWidth, heightMargin) leftTitle:[LangSwitcher switchLang:@"提币数量" key:nil] titleWidth:80 placeholder:[LangSwitcher switchLang:@"请填写数量" key:nil]];
    
    [self.tranAmountTF setValue:kPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    self.tranAmountTF.keyboardType = UIKeyboardTypeDecimalPad;

    
    [self.view addSubview:self.tranAmountTF];
    
    
    for (int i = 0; i < 2; i ++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5 + i % 2 * 50, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
    }
    
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 102)];
    backView1.backgroundColor = kWhiteColor;
    [self.view addSubview:backView1];
    

    UILabel *absenteeismLbl = [UILabel labelWithFrame:CGRectMake(15, 0, 0, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:[UIColor blackColor]];
    absenteeismLbl.text = [LangSwitcher switchLang:@"手续费" key:nil];
    [absenteeismLbl sizeToFit];
    absenteeismLbl.frame = CGRectMake(15, 0, absenteeismLbl.width, 50);
    [backView1 addSubview:absenteeismLbl];

    UILabel *promptLabel = [UILabel labelWithFrame:CGRectMake(absenteeismLbl.xx + 10, 15 + 2, SCREEN_WIDTH - absenteeismLbl.xx - 25, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:RGB(246, 246, 246) font:FONT(11) textColor:RGB(207, 207, 207)];
    promptLabel.text = [LangSwitcher switchLang:@"  手续费将在可用余额中扣除，余额不足将从转账金额扣除" key:nil];
    kViewRadius(promptLabel, 2);
    [backView1 addSubview:promptLabel];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kLineColor;
    [self.view addSubview:lineView];
    
    UILabel *poundageNameLbl = [UILabel labelWithFrame:CGRectMake(15, 51, 0, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:[UIColor blackColor]];
    poundageNameLbl.text = [LangSwitcher switchLang:@"手续费" key:nil];
    [poundageNameLbl sizeToFit];
    poundageNameLbl.frame = CGRectMake(15, 51, poundageNameLbl.width, 50);
    [backView1 addSubview:poundageNameLbl];
    
    
    
    
    poundageLabel = [UILabel labelWithFrame:CGRectMake(poundageNameLbl.xx + 10, 15 +51 + 2, SCREEN_WIDTH - poundageNameLbl.xx - 25, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:kTabbarColor];
    
    
    
    if ([self.currency.currency isEqualToString:@"BTC"]) {
        [self AcquisitionFeeCurrency:@"btc_withdraw_fee"];
    }else
    {
        [self AcquisitionFeeCurrency:@"usdt_withdraw_fee"];
    }
    
    
    
    [backView1 addSubview:poundageLabel];
    
    //确认付币
    UIButton *confirmPayBtn = [UIButton buttonWithTitle:[LangSwitcher switchLang:@"确认提币" key:nil]
                                             titleColor:kWhiteColor
                                        backgroundColor:kTabbarColor
                                              titleFont:16.0
                                           cornerRadius:5];

    [confirmPayBtn addTarget:self action:@selector(clickConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmPayBtn];
    [confirmPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(@(15));
        make.top.equalTo(backView1.mas_bottom).offset(100);
        make.right.equalTo(@(-15));
        make.height.equalTo(@50);

    }];

    self.confirmBtn = confirmPayBtn;
}


-(void)AcquisitionFeeCurrency:(NSString *)currency
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630047";
    http.parameters[SYS_KEY] = currency;
    [http postWithSuccess:^(id responseObject) {
        
        
        self.withdrawFee = responseObject[@"data"][@"cvalue"];
        poundageLabel.text = [NSString stringWithFormat:@"%@ %@", responseObject[@"data"][@"cvalue"], self.currency.currency];
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)click
{
    QRCodeVC *qrCodeVC = [QRCodeVC new];
    CoinWeakSelf;
    qrCodeVC.scanSuccess = ^(NSString *result) {
        
        weakSelf.balanceTF.text = result;
        //        weakSelf.receiveAddressLbl.textColor = kTextColor;
        weakSelf.addressType = AddressTypeScan;
                        [weakSelf setGoogleAuth];
        
    };
    
    [self.navigationController pushViewController:qrCodeVC animated:YES];
    
}
- (FilterView *)coinAddressPicker {
    
    if (!_coinAddressPicker) {
        
        CoinWeakSelf;
        
        NSArray *textArr = @[
//                              [LangSwitcher switchLang:@"选择地址" key:nil],
                              [LangSwitcher switchLang:@"扫描二维码" key:nil],
                              [LangSwitcher switchLang:@"粘贴地址" key:nil]
                              ];
        
        _coinAddressPicker = [[FilterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        _coinAddressPicker.title = [LangSwitcher switchLang:@"付币地址" key:nil];
        
        _coinAddressPicker.selectBlock = ^(NSInteger index) {
            
            [weakSelf pickerEventWithIndex:index];
        };
        _coinAddressPicker.tagNames = textArr;
        
    }
    
    return _coinAddressPicker;
}



- (void)clickConfirm:(UIButton *)sender {

    [self.view endEditing:YES];
    if ([TLUser isBlankString:[TLUser user].idNo] == YES)
    {

        [TLAlert alertWithTitle:@"提示" msg:@"您还未完成实名认证，是否前去认证" confirmMsg:@"确认" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {

        } confirm:^(UIAlertAction *action) {
            ZQOCRScanEngine *engine = [[ZQOCRScanEngine alloc] init];
            engine.delegate = self;
            engine.appKey = @"nJXnQp568zYcnBdPQxC7TANqakUUCjRZqZK8TrwGt7";
            engine.secretKey = @"887DE27B914988C9CF7B2DEE15E3EDF8";
            [engine startOcrScanIdCardInViewController:self];
        }];

    }else
    {
        if ([self.balanceTF.text isEqualToString:@"请选择付币地址或扫码录入"]) {
            
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请选择接收地址" key:nil] ];
            return ;
        }
        
        [self setGoogleAuth];
        
        CGFloat amount = [self.tranAmountTF.text doubleValue];
        
        if (amount <= 0 || ![self.tranAmountTF.text valid]) {
            
            [TLAlert alertWithInfo:@"提币金额需大于0"];
            return ;
        }
        
        if ([TLUser user].isGoogleAuthOpen) {
            
            if (!(self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:@"1"])) {
                
                if (![self.googleAuthTF.text valid]) {
                    
                    [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入谷歌验证码" key:nil]];
                    return;
                    
                }
                
                //判断谷歌验证码是否为纯数字
                if (![NSString isPureNumWithString:self.googleAuthTF.text]) {
                    
                    [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的谷歌验证码" key:nil]];
                    return ;
                }
                
                //判断谷歌验证码是否为6位
                if (self.googleAuthTF.text.length != 6) {
                    
                    [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入正确的谷歌验证码" key:nil]];
                    return ;
                }
                
            }
        }
        
        if (self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:@"1"]) {
            
            [self confirmWithdrawalsWithPwd:nil];
            
            return ;
            
        }
        
        [TLAlert alertWithTitle:[LangSwitcher switchLang:@"请输入交易密码" key:nil]
                            msg:@""
                     confirmMsg:[LangSwitcher switchLang:@"确定" key:nil]
                      cancleMsg:[LangSwitcher switchLang:@"取消" key:nil]
                    placeHolder:[LangSwitcher switchLang:@"请输入交易密码" key:nil]
                          maker:self cancle:^(UIAlertAction *action) {
                              
                          } confirm:^(UIAlertAction *action, UITextField *textField) {
                              
                              [self confirmWithdrawalsWithPwd:textField.text];
                              
                          }];
    }
    

}



- (void)faceAuthFinishedWithResult:(NSInteger)result userInfo:(id)userInfo
{
    NSLog(@"Swift authFinish");
}

- (void)idCardOcrScanFinishedWithResult:(ZQFaceAuthResult)result userInfo:(id)userInfo
{
    NSLog(@"OC OCR Finish");
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = @"即将进入活体识别";
    //    [SVProgressHUD showInfoWithStatus:@"正在认证中"];
    
    UIImage *frontcard = [userInfo objectForKey:@"frontcard"];
    UIImage *portrait = [userInfo objectForKey:@"portrait"];
    UIImage *backcard = [userInfo objectForKey:@"backcard"];
    if(result  == ZQFaceAuthResult_Done && frontcard != nil && portrait != nil && backcard !=nil)
    {
        NSData *imgData = UIImageJPEGRepresentation(frontcard, 0.6);
        NSData *imgData1 = UIImageJPEGRepresentation(backcard, 0.6);
        //进行上传
        [TLProgressHUD show];
        TLUploadManager *manager = [TLUploadManager manager];
        
        manager.imgData = imgData;
        manager.image = frontcard;
        [manager getTokenShowView:self.view succes:^(NSString *key) {
            
            str1 = key;
            //            [weakSelf changeHeadIconWithKey:key imgData:imgData];
            [TLProgressHUD show];
            TLUploadManager *manager1 = [TLUploadManager manager];
            
            manager1.imgData = imgData1;
            manager1.image = backcard;
            [manager1 getTokenShowView:self.view succes:^(NSString *key) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
                str2 = key;
                ZQFaceAuthEngine * engine = [[ZQFaceAuthEngine alloc]init];
                engine.delegate = self;
                engine.appKey = @"nJXnQp568zYcnBdPQxC7TANqakUUCjRZqZK8TrwGt7";
                engine.secretKey = @"887DE27B914988C9CF7B2DEE15E3EDF8";
                [engine startFaceAuthInViewController:self];
                //            [weakSelf changeHeadIconWithKey:key imgData:imgData];
                
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            }];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        }];
    }
    else
    {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

#pragma mark - ZQFaceAuthDelegate
- (void)faceAuthFinishedWithResult:(ZQFaceAuthResult)result UserInfo:(id)userInfo{
    
    UIImage * livingPhoto = [userInfo objectForKey:@"livingPhoto"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.labelText = @"正在认证中";
    if(result  == ZQFaceAuthResult_Done && livingPhoto !=nil){
        [TLProgressHUD show];
        TLUploadManager *manager = [TLUploadManager manager];
        NSData *imgData = UIImageJPEGRepresentation(livingPhoto, 0.6);
        manager.imgData = imgData;
        manager.image = livingPhoto;
        [manager getTokenShowView:self.view succes:^(NSString *key) {
            str3 = key;
            
            TLNetworking *http = [TLNetworking new];
            //            http.showView = self.view;
            http.code = @"805197";
            http.parameters[@"userId"] = [TLUser user].userId;
            http.parameters[@"frontImage"] = str1;
            http.parameters[@"backImage"] = str2;
            http.parameters[@"faceImage"] = str3;
            //
            [http postWithSuccess:^(id responseObject) {
                [TLAlert alertWithMsg:[LangSwitcher switchLang:@"实名认证成功" key:nil]];
                [self requesUserInfoWithResponseObject];
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
            }];
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        }];
    }else
    {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    }
}

- (void)requesUserInfoWithResponseObject{
    
    //1.获取用户信息
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        NSDictionary *userInfo = responseObject[@"data"];
        //保存用户信息
        [[TLUser user] saveUserInfo:userInfo];
        //初始化用户信息
        [[TLUser user] setUserInfoWithDict:userInfo];
        
//        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}



- (void)clickPaste {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    if (pasteboard.string != nil) {
        
        self.googleAuthTF.text = pasteboard.string;
        
    } else {
        
        [TLAlert alertWithInfo:@"粘贴内容为空"];
    }
}

//- (void)textDidChange:(UITextField *)sender {

//    NSDecimalNumber *m = [NSDecimalNumber decimalNumberWithString:self.tranAmountTF.text];
//
//    NSDecimalNumber *n = [NSDecimalNumber decimalNumberWithString:self.withdrawFee];
//
//    NSDecimalNumber *o = [m decimalNumberByMultiplyingBy:n];
//
//    self.minerFeeTF.text = [NSString stringWithFormat:@"%@ %@", [o stringValue], self.currency.currency];
//}

- (void)selectCoinAddress {
    
    [self.coinAddressPicker show];
}

- (void)pickerEventWithIndex:(NSInteger)index {
    
    CoinWeakSelf;
    
    switch (index) {
        //选择地址

        //扫描二维码
        case 0:
        {
            QRCodeVC *qrCodeVC = [QRCodeVC new];
            
            qrCodeVC.scanSuccess = ^(NSString *result) {
                
                weakSelf.receiveAddressLbl.text = result;
                weakSelf.receiveAddressLbl.textColor = kTextColor;
                weakSelf.addressType = AddressTypeScan;
                [weakSelf setGoogleAuth];

            };
            
            [self.navigationController pushViewController:qrCodeVC animated:YES];
            
        }break;
        //粘贴地址
        case 1:
        {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
            if (pasteboard.string != nil) {
                
                self.receiveAddressLbl.text = pasteboard.string;
                
                self.receiveAddressLbl.textColor = kTextColor;
                
                self.addressType = AddressTypeCopy;
                
                [weakSelf setGoogleAuth];

            } else {
                
                [TLAlert alertWithInfo:@"粘贴内容为空"];
            }
            
        }break;
            
        default:
            break;
    }
}

- (void)setGoogleAuth {
    
    if (![TLUser user].isGoogleAuthOpen) {
        
        return ;
    }
    
    if ((self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:kAddressCertified])) {

        [UIView animateWithDuration:0 animations:^{
            
            self.googleAuthTF.transform = CGAffineTransformIdentity;
            self.minerFeeTF.transform = CGAffineTransformIdentity;
            self.minerView.transform = CGAffineTransformIdentity;
            self.confirmBtn.transform = CGAffineTransformIdentity;
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0 animations:^{
            
            self.googleAuthTF.transform = CGAffineTransformMakeTranslation(0, 50);
            self.minerFeeTF.transform = CGAffineTransformMakeTranslation(0, 50);
            self.minerView.transform = CGAffineTransformMakeTranslation(0, 50);
            self.confirmBtn.transform = CGAffineTransformMakeTranslation(0, 50);
            
        }];
    }
}

#pragma mark - Data
- (void)confirmWithdrawalsWithPwd:(NSString *)pwd {
    
    if (!(self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:@"1"])) {
        
        if (![pwd valid]) {
            
            [TLAlert alertWithInfo:[LangSwitcher switchLang:@"请输入交易密码" key:nil]];
            return ;
        }
    }
    
    if (self.sw.on) {
        
        [self doTransfer:pwd];
        
    } else {
        
        [self doWithdraw:pwd];
        
    }
    
    
    
}

- (void)doWithdraw:(NSString *)pwd {
    
    TLNetworking *http = [TLNetworking new];
    
    http.code = @"802350";
    http.showView = self.view;
    http.parameters[@"accountNumber"] = self.currency.accountNumber;
    http.parameters[@"amount"] = [CoinUtil convertToSysCoin:self.tranAmountTF.text
                                                       coin:self.currency.currency];
    http.parameters[@"applyNote"] = [NSString stringWithFormat:@"%@提现", self.currency.currency];
    //    http.parameters[@"applyNote"] = @"ios-提现";
    http.parameters[@"applyUser"] = [TLUser user].userId;
    http.parameters[@"payCardInfo"] = self.currency.currency;
    http.parameters[@"payCardNo"] = self.balanceTF.text;
    http.parameters[@"token"] = [TLUser user].token;
    //    http.parameters[@"fee"] = @"-0.1";
    //    http.parameters[@"fee"] = @"-10";
    
    
    if ([TLUser user].isGoogleAuthOpen) {
        
        if (!(self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:@"1"])) {
            
            http.parameters[@"googleCaptcha"] = self.googleAuthTF.text;
            
        }
    }
    
    if (!(self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:@"1"])) {
        
        http.parameters[@"tradePwd"] = pwd;
        
    }
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"提币申请提交成功" key:nil]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kWithDrawCoinSuccess object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}


- (void)doTransfer:(NSString *)pwd {
    
    TLNetworking *http = [TLNetworking new];
    
    http.code = @"802004";
    http.showView = self.view;
    http.parameters[@"fromUserId"] = [TLUser user].userId;
    http.parameters[@"fromAddress"] = self.currency.coinAddress;
    http.parameters[@"toAddress"] = self.receiveAddressLbl.text;
    http.parameters[@"transAmount"] = [CoinUtil convertToSysCoin:self.tranAmountTF.text
                                                       coin:self.currency.currency];
    http.parameters[@"currency"] = self.currency.currency;
    http.parameters[@"token"] = [TLUser user].token;
    //    http.parameters[@"fee"] = @"-0.1";
    //    http.parameters[@"fee"] = @"-10";
    
    
    if ([TLUser user].isGoogleAuthOpen) {
        
        if (!(self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:@"1"])) {
            
            http.parameters[@"googleCaptcha"] = self.googleAuthTF.text;
            
        }
    }
    
    if (!(self.addressType == AddressTypeSelectAddress && [self.addressModel.status isEqualToString:@"1"])) {
        
        http.parameters[@"tradePwd"] = pwd;
        
    }
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"内部转账成功" key:nil]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kWithDrawCoinSuccess object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark- 获取手续费
- (void)setWithdrawFee {
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


@end
