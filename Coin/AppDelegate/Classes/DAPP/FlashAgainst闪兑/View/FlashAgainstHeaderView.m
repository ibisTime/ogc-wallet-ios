//
//  FlashAgainstHeaderView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FlashAgainstHeaderView.h"

@implementation FlashAgainstHeaderView
{
    UILabel *symbolLbl1;
    UILabel *symbolLbl2;
    UILabel *leftLbl;
    UIImageView *leftImg;
    UILabel *rightLbl;
    UIImageView *rightImg;
    
    UILabel *balanceLbl;
    UIButton *allBtn;
    BOOL isHaveDian;
    NSString *ritAmount;
    
    NSString *poundage;
    
    CGFloat outNum;
    CGFloat inNum;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
        iconImg.image = kImage(@"头像");
        [self addSubview:iconImg];
        
        UILabel *phoneLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 10, 15, SCREEN_WIDTH - 25, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:nil];
        phoneLbl.text = [TLUser user].mobile;
        [self addSubview:phoneLbl];
        
        UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 45)];
        kViewBorderRadius(borderView, 2, 0.5, kHexColor([TLUser TextFieldPlacColor]));
        [self addSubview:borderView];
        
        symbolLbl1 = [UILabel labelWithFrame:CGRectMake(11, 0, SCREEN_WIDTH/2 - 26, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:nil];
        [symbolLbl1 theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
//        symbolLbl1.text = @"1MGC=0.001036196 ETH";
        [borderView addSubview:symbolLbl1];
        
        symbolLbl2 = [UILabel labelWithFrame:CGRectMake(symbolLbl1.xx, 0, SCREEN_WIDTH/2 - 26, 45) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(12) textColor:nil];
//        symbolLbl2.text = @"1MGC=0.023 USD";
        [symbolLbl2 theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [borderView addSubview:symbolLbl2];
        
        UIButton *conversionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [conversionBtn setImage:kImage(@"切换") forState:(UIControlStateNormal)];
        conversionBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 20, borderView.yy + 20, 40, 40);
        [self addSubview:conversionBtn];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 140, SCREEN_WIDTH/2 - 47.5, 50)];
        [leftView theme_setBackgroundColorIdentifier:@"FlashAgainstConversionColor" moduleName:ColorName];
        kViewRadius(leftView, 2);
        [self addSubview:leftView];
        
        
        
        leftLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
        leftLbl.font = FONT(14);
        [leftLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        
        [leftView addSubview:leftLbl];
        
        leftImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - leftLbl.width/2 - 20, 10, 30, 30)];
//        leftImg.image = kImage(@"BTC");
        [leftView addSubview:leftImg];
        
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(conversionBtn.xx + 12.5, 140, SCREEN_WIDTH/2 - 47.5, 50)];
        [rightView theme_setBackgroundColorIdentifier:@"FlashAgainstConversionColor" moduleName:ColorName];
        kViewRadius(rightView, 2);
        [self addSubview:rightView];
        
        rightLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
        rightLbl.font = FONT(14);
        [rightLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [rightView addSubview:rightLbl];
        
        rightImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - rightLbl.width/2 - 20, 10, 30, 30)];
        [rightView addSubview:rightImg];
        
        
        _chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _chooseBtn.frame = CGRectMake(15, 140, SCREEN_WIDTH - 30, 50);
        [self addSubview:_chooseBtn];
        
        
        
        UIView *leftNumberView = [[UIView alloc]initWithFrame:CGRectMake(15, 205, (SCREEN_WIDTH - 45)/2, 45)];
        [leftNumberView theme_setBackgroundColorIdentifier:@"leftNumberView" moduleName:ColorName];
        kViewBorderRadius(leftNumberView, 2, 1, kHexColor([TLUser LineColor]));
        [self addSubview:leftNumberView];
        
        _leftNumberTf = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH - 45)/2 - 30, 45)];
        _leftNumberTf.placeholder = [LangSwitcher switchLang:@"兑换数量" key:nil];
        [_leftNumberTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        _leftNumberTf.font = FONT(14);
        _leftNumberTf.keyboardType =  UIKeyboardTypeNumberPad;
        _leftNumberTf.textColor = kHexColor([TLUser TextFieldTextColor]);
        [_leftNumberTf setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
        _leftNumberTf.delegate = self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftNumberTfDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                                  object:_leftNumberTf];
        [leftNumberView addSubview:_leftNumberTf];
        
        UIView *rightNumberView = [[UIView alloc]initWithFrame:CGRectMake(leftNumberView.xx + 15, 205, (SCREEN_WIDTH - 45)/2, 45)];
        [rightNumberView theme_setBackgroundColorIdentifier:@"leftNumberView" moduleName:ColorName];
        kViewBorderRadius(rightNumberView, 2, 1, kHexColor([TLUser LineColor]));
        [self addSubview:rightNumberView];
        
        _rightNumberTf = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH - 45)/2 - 30, 45)];
        _rightNumberTf.placeholder = [LangSwitcher switchLang:@"收到数量" key:nil];
        [_rightNumberTf setValue:FONT(14) forKeyPath:@"_placeholderLabel.font"];
        _rightNumberTf.font = FONT(14);
        _rightNumberTf.keyboardType =  UIKeyboardTypeNumberPad;
        _rightNumberTf.textColor = kHexColor([TLUser TextFieldTextColor]);
        [_rightNumberTf setValue:kHexColor([TLUser TextFieldPlacColor]) forKeyPath:@"_placeholderLabel.color"];
        _rightNumberTf.delegate = self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rightNumberTfDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                                  object:_rightNumberTf];
        [rightNumberView addSubview:_rightNumberTf];
        
        balanceLbl = [[UILabel alloc]initWithFrame:CGRectMake(16, 250 + 20.5, 0, 16.5)];
        balanceLbl.font = FONT(12);
        [balanceLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:balanceLbl];
        
        allBtn = [[UIButton alloc]initWithFrame:CGRectMake(balanceLbl.xx + 20, 250 + 15, 50, 27)];
        [allBtn setTitle:@"全部" forState:(UIControlStateNormal)];
//        [allBtn setTitleColor:kHexColor(@"#FFFFFF") forState:(UIControlStateNormal)];
        [allBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
        kViewRadius(allBtn, 4);
        allBtn.titleLabel.font = FONT(12);
        [allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:allBtn];

        _poundageLbl = [[UILabel alloc]initWithFrame:CGRectMake(16, 250 + 20.5, 0, 16.5)];
        _poundageLbl.font = FONT(12);
        _poundageLbl.numberOfLines = 2;
        [_poundageLbl theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:_poundageLbl];
        
        UIButton *exchangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, allBtn.yy + 35, SCREEN_WIDTH - 30, 48)];
        [exchangeBtn setTitle:@"兑换" forState:(UIControlStateNormal)];
        self.exchangeBtn = exchangeBtn;
        [exchangeBtn setBackgroundColor:kTabbarColor forState:(UIControlStateNormal)];
        kViewRadius(exchangeBtn, 4);
        exchangeBtn.titleLabel.font = FONT(16);
        [self addSubview:exchangeBtn];
    }
    return self;
}

-(void)allBtnClick
{

    _leftNumberTf.text = [NSString stringWithFormat:@"%@",ritAmount];
    //    输入价格l
    CGFloat allPic = [_leftNumberTf.text floatValue];
    //    比例
    CGFloat proportion = [_model.feeRate floatValue]/100;
    //    手续费
    CGFloat free = allPic * proportion;
    //    价格比例
    CGFloat proportionPic = [_InPrice floatValue] / [_OutPrice floatValue];
    
    poundage = [CoinUtil mult1:[NSString stringWithFormat:@"%f",free] mult2:@"1" scale:8];
    NSLog(@"ssssss %@",_leftNumberTf.text);
    if (allPic != 0) {
        _rightNumberTf.text = [NSString stringWithFormat:@"%.8f",proportionPic * (allPic - free)];
    }
    else
    {
        _rightNumberTf.text = @"";
    }
    [self textField];
}

-(void)leftNumberTfDidChangeOneCI:(NSNotification *)notification
{
    
    UITextField *textfield=[notification object];

//    输入价格l
    CGFloat allPic = [textfield.text floatValue];
//    比例
    CGFloat proportion = [_model.feeRate floatValue]/100;
//    手续费
    CGFloat free = allPic * proportion;
//    价格比例
    CGFloat proportionPic = [_InPrice floatValue] / [_OutPrice floatValue];
    
    poundage = [CoinUtil mult1:[NSString stringWithFormat:@"%f",free] mult2:@"1" scale:8];
    NSLog(@"ssssss %@",textfield.text);
    if (allPic != 0) {
        _rightNumberTf.text = [NSString stringWithFormat:@"%.8f",proportionPic * (allPic - free)];
    }
    else
    {
        _rightNumberTf.text = @"";
    }
    [self textField];
}


-(void)rightNumberTfDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];

    
    CGFloat fee = [_model.feeRate floatValue]/100;
    CGFloat A;
    CGFloat A1 = [_InPrice floatValue];
    CGFloat B = [textfield.text floatValue];
    CGFloat B1 = [_OutPrice floatValue];

    A = B * B1 / (A1 * (1 - fee));
    
    
    
    
    _leftNumberTf.text = [NSString stringWithFormat:@"%.8f",A];
    if ([_leftNumberTf.text floatValue] == 0) {
        _leftNumberTf.text = @"";
    }
    poundage = [CoinUtil mult1:[NSString stringWithFormat:@"%f",A * [_model.feeRate floatValue]/100] mult2:@"1" scale:8];
    [self textField];
}

-(void)textField
{
//    [CoinUtil mult1:[NSString stringWithFormat:@"%f",[_leftNumberTf.text floatValue]*[_model.feeRate floatValue]/100] mult2:@"1" scale:8];
    
    
    _poundageLbl.text = [NSString stringWithFormat:@"手续费：≈%@%@",poundage,_model.symbolOut];
    _poundageLbl.frame = CGRectMake(allBtn.xx + 30, 250 + 20.5,SCREEN_WIDTH - allBtn.xx - 45, 16.5);
    [_poundageLbl sizeToFit];
}



-(void)setCurrenctModel:(NSMutableArray<CurrencyModel *> *)currenctModel
{
    _currenctModel = currenctModel;
    for (int i = 0; i < _currenctModel.count; i ++) {
        
        _platforms = _currenctModel[i];
        
        if ([_platforms.currency isEqualToString:self.model.symbolOut]) {
            NSString *amount = [CoinUtil convertToRealCoin:_platforms.amount coin:_platforms.currency];
            NSString *rightAmount = [CoinUtil convertToRealCoin:_platforms.frozenAmount coin:_platforms.currency];
            ritAmount = [amount subNumber:rightAmount];
            balanceLbl.text = [NSString stringWithFormat:@"余额 %@ %@",ritAmount,_platforms.currency];
        }
    }
    
    [balanceLbl sizeToFit];
    balanceLbl.frame = CGRectMake(16, 250 + 20.5, balanceLbl.width, 16.5);
    allBtn.frame = CGRectMake(balanceLbl.xx + 20, 250 + 15, 50, 27);
    
    [_poundageLbl sizeToFit];
    _poundageLbl.frame = CGRectMake(allBtn.xx + 30, 250 + 20.5,SCREEN_WIDTH - allBtn.xx - 45, 16.5);
    
}

-(void)setModel:(FlashAgainstModel *)model
{
    _model = model;
    CoinModel *InCoin = [CoinUtil getCoinModel:model.symbolOut];
    leftLbl.text = model.symbolOut;
    [leftLbl sizeToFit];
    leftLbl.frame = CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - leftLbl.width/2 + 20, 0, leftLbl.width, 50);
    [leftImg sd_setImageWithURL:[NSURL URLWithString:[InCoin.pic1 convertImageUrl]] placeholderImage:kImage(@"")];
    leftImg.frame = CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - leftLbl.width/2 - 20, 10, 30, 30);
    
    CoinModel *OutCoin = [CoinUtil getCoinModel:model.symbolIn];
    rightLbl.text = model.symbolIn;
    [rightLbl sizeToFit];
    rightLbl.frame = CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - rightLbl.width/2 + 20, 0, rightLbl.width, 50);
    [rightImg sd_setImageWithURL:[NSURL URLWithString:[OutCoin.pic1 convertImageUrl]] placeholderImage:kImage(@"BTC")];
    rightImg.frame = CGRectMake((SCREEN_WIDTH/2 - 47.5)/2 - rightLbl.width/2 - 20, 10, 30, 30);
    
    
}


-(void)setInPrice:(NSString *)InPrice
{
    _InPrice = InPrice;
    symbolLbl1.text = [NSString stringWithFormat:@"1%@=%@CNY",_model.symbolOut,InPrice];
}

-(void)setOutPrice:(NSString *)OutPrice
{
    _OutPrice = OutPrice;
    symbolLbl2.text = [NSString stringWithFormat:@"1%@=%@CNY",_model.symbolIn,OutPrice];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{


    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {

                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }

            return YES;
        }else{
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }else
    {
        return YES;
    }


}



@end
