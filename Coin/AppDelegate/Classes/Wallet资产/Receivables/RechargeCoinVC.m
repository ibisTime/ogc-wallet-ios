//
//  RechargeCoinVC.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/10.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "RechargeCoinVC.h"

#import "UIButton+EnLargeEdge.h"
#import "NSString+CGSize.h"
#import "UILabel+Extension.h"
#import "UIBarButtonItem+convience.h"

#import "SGQRCodeGenerateManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "BillVC.h"
#import "TLCoinWithdrawOrderVC.h"
@interface RechargeCoinVC ()

@property (nonatomic, strong) UIView *topView;


@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic ,strong) UIButton *buildButton;

@property (nonatomic ,strong) UIButton *saveButton;
@property (nonatomic, strong)  UIImageView *qrIV;
@end

@implementation RechargeCoinVC




- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = [LangSwitcher switchLang:@"收款" key:nil];
    self.navigationItem.titleView = self.titleText;
    //提示框
    [self initTopView];
    //二维码
    [self initQRView];
    //地址
    [self initAddressView];

    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:[LangSwitcher switchLang:@"记录" key:nil] forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
}


-(void)rightButtonClick
{
    TLCoinWithdrawOrderVC *withdrawOrderVC = [[TLCoinWithdrawOrderVC alloc] init];
    withdrawOrderVC.currency = self.currency;
    withdrawOrderVC.titleString = [LangSwitcher switchLang:@"收款订单" key:nil];
    [self.navigationController pushViewController:withdrawOrderVC animated:YES];
}


#pragma mark - Init

- (void)initTopView {
    
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH - 30, 388)];
    self.topView.backgroundColor = kWhiteColor;
    self.topView.backgroundColor = kWhiteColor;
    self.topView.layer.cornerRadius=4;
    self.topView.layer.shadowOpacity = 0.22;// 阴影透明度
    self.topView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    self.topView.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
    self.topView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self.view addSubview:self.topView];
    

    
}

- (void)initQRView {
    
   
 

    UILabel *lab = [[UILabel alloc]init];
    lab.font = HGboldfont(14);
    lab.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:lab];
    lab.frame = CGRectMake(0, 32.5, kScreenWidth - 30, 22.5);
    lab.text = [LangSwitcher switchLang:@"钱包地址" key:nil];
    lab.textColor = [UIColor blackColor];
    
    
    //二维码
    UIImageView *qrIV = [[UIImageView alloc] init];
    self.qrIV = qrIV;
    [self.topView addSubview:qrIV];
    NSString *address ;
    qrIV.frame = CGRectMake((SCREEN_WIDTH - 30)/2 - 104, 88.5, 208, 208);
    address = self.currency.address;
    CoinModel * coin = [CoinUtil getCoinModel:self.currency.currency.length > 0 ? self.currency.currency : self.currency.symbol];

    [qrIV sd_setImageWithURL:[NSURL URLWithString:[coin.pic1 convertImageUrl]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        qrIV.image = [self generateWithLogoQRCodeData:address logoImageName:image logoScaleToSuperView:0.2];

    }];

    

}

- (UIImage *)generateWithLogoQRCodeData:(NSString *)data logoImageName:(UIImage *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 2、设置数据
    NSString *string_data = data;
    // 将字符串转换成 NSdata (虽然二维码本质上是字符串, 但是这里需要转换, 不转换就崩溃)
    NSData *qrImageData = [string_data dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:qrImageData forKey:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 图片小于(27,27),我们需要放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    // 4、将CIImage类型转成UIImage类型
    UIImage *start_image = [UIImage imageWithCIImage:outputImage];
    
    // - - - - - - - - - - - - - - - - 添加中间小图标 - - - - - - - - - - - - - - - -
    // 5、开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(start_image.size);
    
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [start_image drawInRect:CGRectMake(0, 0, start_image.size.width, start_image.size.height)];
    
    // 再把小图片画上去
//    UIImage *icon_imageName = logoImageName;
    UIImage *icon_image = logoImageName;
    CGFloat icon_imageW = start_image.size.width * logoScaleToSuperView;
    CGFloat icon_imageH = start_image.size.height * logoScaleToSuperView;
    CGFloat icon_imageX = (start_image.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (start_image.size.height - icon_imageH) * 0.5;
    
    [icon_image drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    
    return final_image;
}


- (void)initAddressView {
    


    UILabel *addressLbl = [[UILabel alloc]init];
    addressLbl.backgroundColor = kHexColor(@"#D7E2F5");
    addressLbl.textColor = kHexColor(@"#595D66");
    addressLbl.numberOfLines = 0;
    addressLbl.font = FONT(14);
    addressLbl.textAlignment = NSTextAlignmentCenter;
    addressLbl.layer.cornerRadius=4;
    NSString *address = self.currency.address;
    addressLbl.frame = CGRectMake(15, self.qrIV.yy + 25.5, SCREEN_WIDTH - 60, 40);
    addressLbl.text = [NSString stringWithFormat:@"%@", address];
    [self.topView addSubview:addressLbl];
    
    self.buildButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text =  [LangSwitcher switchLang:@"复制收款地址" key:nil];
    self.buildButton.frame = CGRectMake(15, self.topView.yy + 43, SCREEN_WIDTH - 30, 48);
    [self.buildButton setTitle:text forState:UIControlStateNormal];
    self.buildButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.buildButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.buildButton addTarget:self action:@selector(clickCopyAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.buildButton setBackgroundColor:kTabbarColor forState:UIControlStateNormal];
    [self.view addSubview:self.buildButton];
    
    
}



- (void)clickCopyAddress {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    NSString *address ;
    address = self.currency.address;

    pasteBoard.string = address;
    
    if (pasteBoard == nil) {
        
        [TLAlert alertWithError:[LangSwitcher switchLang:@"复制失败, 请重新复制" key:nil]];
        
    } else {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功" key:nil]];
    }
}
- (void)backTop
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)lookBillRecord {
    
    BillVC *billVC = [BillVC new];
    
    billVC.accountNumber = self.currency.accountNumber;
    
    billVC.billType = BillTypeRecharge;

    [self.navigationController pushViewController:billVC animated:YES];
}

- (void)clickCopy {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    NSString *address ;
    if (self.currency.symbol) {
        address = self.currency.address;
    }else{
        address = self.currency.coinAddress;
        
        
    }
    pasteBoard.string = address;
    
    if (pasteBoard == nil) {
        
        [TLAlert alertWithError:[LangSwitcher switchLang:@"复制失败, 请重新复制" key:nil]];
        
    } else {
        
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"复制成功" key:nil]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
