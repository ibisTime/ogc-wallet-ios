//
//  TLMoneyDetailsTableView.m
//  Coin
//
//  Created by QinBao Zheng on 2018/9/26.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "TLMoneyDetailsTableView.h"
#import "TLMoneyDetailsHeadView.h"
#import "TLMoneyDeailCell.h"
#define TLMoneyDeail @"TLMoneyDeailCell"
#import "TLMoneyDetailsAttributesCell.h"
#define TLMoneyDetailsAttributes @"TLMoneyDetailsAttributesCell"
//#import "TLMoneyDeailWebViewCell.h"
//#define TLMoneyDeailWebView @"TLMoneyDeailWebViewCell"
@interface TLMoneyDetailsTableView()<UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate>
{
    BOOL isOrOpen[5];
    CGFloat webViewHeight1;
    CGFloat webViewHeight2;
    CGFloat webViewHeight3;
    UITableViewCell *_cell1;
    UITableViewCell *_cell2;
    UITableViewCell *_cell3;

    


}

@property (nonatomic , strong)UIWebView *web1;
@property (nonatomic , strong)UIWebView *web2;
@property (nonatomic , strong)UIWebView *web3;
//声明一个区号，用来记录上一个
@property (nonatomic , assign)NSInteger selectSxtion;



@end

@implementation TLMoneyDetailsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {

        self.dataSource = self;
        self.delegate = self;
        

        [self registerClass:[TLMoneyDeailCell class] forCellReuseIdentifier:TLMoneyDeail];
        [self registerClass:[TLMoneyDetailsAttributesCell class] forCellReuseIdentifier:TLMoneyDetailsAttributes];
//        [self registerClass:[TLMoneyDeailWebViewCell class] forCellReuseIdentifier:TLMoneyDeailWebView];
//        [self registerClass:[TLMoneyDeailWebViewce class] forCellReuseIdentifier:@"cell"];



        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        //    标注区
//        isOrOpen[0] = YES;
//        self.selectSxtion = 0;
    }

    return self;
}



#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0 || section == 1) {
        return 1;
    }
//    if (isOrOpen[section] == NO) {
//        return 0;
//    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        TLMoneyDeailCell *cell1 = [tableView dequeueReusableCellWithIdentifier:TLMoneyDeail forIndexPath:indexPath];

        cell1.moneyModel = self.moneyModel;

        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    if (indexPath.section == 1) {
        TLMoneyDetailsAttributesCell *cell1 = [tableView dequeueReusableCellWithIdentifier:TLMoneyDetailsAttributes forIndexPath:indexPath];
        cell1.moneyModel = self.moneyModel;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell1;
    }
    if (indexPath.section == 2) {
        static NSString *identifier = @"webCell1";
        _cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!_cell1){
            _cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            
            [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
            self.web1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            self.web1.delegate = self;
            self.web1.scrollView.bounces=NO;
            //        self.web.backgroundColor = kWhiteColor;
            [_cell1 addSubview:self.web1];
            
            switch ([LangSwitcher currentLangType]) {
                case LangTypeEnglish:
                    [self.web1 loadHTMLString:self.moneyModel.buyDescEn baseURL:nil];
                    
                    break;
                case LangTypeKorean:
                    [self.web1 loadHTMLString:self.moneyModel.buyDescKo baseURL:nil];
                    
                    break;
                case LangTypeSimple:
                    [self.web1 loadHTMLString:self.moneyModel.buyDescZhCn baseURL:nil];
                    
                    break;
                    
                default:
                    break;
            }
            
            [self.web1.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [_cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return _cell1;
    }

    if (indexPath.section == 3) {
        static NSString *identifier = @"webCell2";
        _cell2 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!_cell2){
            _cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            
            [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
            self.web2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            self.web2.delegate = self;
            self.web2.scrollView.bounces=NO;
            //        self.web.backgroundColor = kWhiteColor;
            [_cell2 addSubview:self.web2];
            
            switch ([LangSwitcher currentLangType]) {
                case LangTypeEnglish:
                    [self.web2 loadHTMLString:self.moneyModel.redeemDescEn baseURL:nil];
                    
                    break;
                case LangTypeKorean:
                    [self.web2 loadHTMLString:self.moneyModel.redeemDescKo baseURL:nil];
                    
                    break;
                case LangTypeSimple:
                    [self.web2 loadHTMLString:self.moneyModel.redeemDescZhCn baseURL:nil];
                    
                    break;
                    
                default:
                    break;
            }
            
            [self.web2.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [_cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    
        return _cell2;
    }


    static NSString *identifier = @"webCell";
    _cell3 = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!_cell3){
        _cell3 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        [self theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        self.web3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        self.web3.delegate = self;
        self.web3.scrollView.bounces=NO;
        //        self.web.backgroundColor = kWhiteColor;
        [_cell3 addSubview:self.web3];
        
        switch ([LangSwitcher currentLangType]) {
            case LangTypeEnglish:
                [self.web3 loadHTMLString:self.moneyModel.directionsEn baseURL:nil];
                
                break;
            case LangTypeKorean:
                [self.web3 loadHTMLString:self.moneyModel.directionsKo baseURL:nil];
                
                break;
            case LangTypeSimple:
                [self.web3 loadHTMLString:self.moneyModel.directionsZhCn baseURL:nil];
                
                break;
                
            default:
                break;
        }
        
        [self.web3.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [_cell3 setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return _cell3;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
        //字体颜色
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"];
        
        //页面背景色
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#282A2E'"];
    }else
    {
        //字体颜色
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#282A2E'"];
        
        //页面背景色
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#f8f8f8'"];
    }
    
}

//监听触发
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        //通过JS代码获取webview的内容高度
//        if (self.selectSxtion == 2) {
//            if (webViewHeight1 == 0) {

            webViewHeight1 = [[self.web1 stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
            self.web1.frame = CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight1);

//            }
//        }
//        if (self.selectSxtion == 3) {
//            if (webViewHeight2 == 0) {
                webViewHeight2 = [[self.web2 stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
                self.web2.frame = CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight2);

//            }
//        }
//        if (self.selectSxtion == 4) {
//            if (webViewHeight3 == 0) {
                webViewHeight3 = [[self.web3 stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
                self.web3.frame = CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight3);

//            }
//        }
        [self reloadData];
    }
}

-(void)dealloc
{
    [self.web1.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    [self.web2.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    [self.web3.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 102;
    }
    if (indexPath.section == 1) {
        return 143;
    }
    if (indexPath.section == 2) {
        return webViewHeight1;
    }
    if (indexPath.section == 3) {
        return webViewHeight2;
    }

    return webViewHeight3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        return 10;
    }
    if (section > 1) {
        return 41;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    if (section == 4) {
        return 40;
    }
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    
    if (section == 1) {
        UIView *headView = [UIView new];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [lineView theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [headView addSubview:lineView];
        
        return headView;
    }
    if (section > 1) {

        UIView *headView = [[UIView alloc]init];
//        headView.backgroundColor = [UIColor blackColor];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 40)];
//        backView.backgroundColor = kWhiteColor;;
        [backView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [headView addSubview:backView];
        
        NSArray *nameArray = @[@"购买属性",@"赎回属性",@"说明书"];
        UIButton *headButton = [UIButton buttonWithTitle:[LangSwitcher switchLang:nameArray[section - 2] key:nil] titleColor:kHexColor(@"#464646") backgroundColor:kClearColor titleFont:16];
        [headButton theme_setTitleColorIdentifier:LabelColor forState:(UIControlStateNormal) moduleName:ColorName];
        headButton.titleLabel.font = HGboldfont(16);
        headButton.frame = CGRectMake(15, 0, SCREEN_WIDTH - 45, 40);
        headButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headButton.tag = section;
        [backView addSubview:headButton];

        return headView;

    }
    return nil;
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:scrollView:)]) {
        [self.refreshDelegate refreshTableView:self scrollView:scrollView];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headView = [UIView new];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [lineView theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [headView addSubview:lineView];
        
        return headView;
    }
    return [UIView new];
}



@end
