//
//  BuildBackUpVC.m
//  Coin
//
//  Created by shaojianfei on 2018/6/8.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "BuildBackUpVC.h"
#import "TLAlert.h"
#import "QHCollectionViewNine.h"
#import "CurrencyTitleModel.h"
#import "BuildCheckVC.h"
#import "CustomLayoutWallet.h"
#import "MnemonicUtil.h"
#import "CurrencyTitleModel.h"
@interface BuildBackUpVC ()<addCollectionViewDelegate>
@property (nonatomic ,strong) UILabel *nameLable;

@property (nonatomic ,strong) UILabel *contentLable;

@property (nonatomic ,strong) UIView *contentView;

@property (nonatomic ,strong) UIButton *nextButton;

@property (nonatomic ,strong) QHCollectionViewNine *bottomView;

@property (nonatomic ,strong) CurrencyTitleModel *titleModel;
@property (nonatomic ,strong)UILabel *promptLbl;

@property (nonatomic, strong) NSMutableArray <CurrencyTitleModel *> *bottomNames;

@property (nonatomic, strong) NSMutableArray <CurrencyTitleModel *> *tempNames;
@property (nonatomic ,strong) UIView *whiteView;
@property (nonatomic ,strong) UIView *showView;
@property (nonatomic ,strong) UIView * view1;
@end

@implementation BuildBackUpVC

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self navigationSetDefault];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self navigationwhiteColor];
}


- (void)viewDidLoad {
    self.titleText.text = [LangSwitcher switchLang:@"备份钱包" key:nil];
    self.navigationItem.titleView = self.titleText;

    [self initWalletUI];
    [self initShowView];
    [self inititem];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initShowView
{
    
//    UIView *bottom = []
    
    UIView * view1 = [UIView new];
    self.view1 = view1;
    view1.userInteractionEnabled = YES;
//    UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideinPut)];
    
//    [view1 addGestureRecognizer:t];
    self.view1.hidden = NO;
    
    view1.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    view1.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.45];
    
    //    view.alpha = 0.5;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:view1];
    
    UIView *showView = [UIView new];
    self.showView = showView;
    showView.backgroundColor = kHexColor(@"#FB744E");
    
    [self.view1 addSubview:showView];
    
    showView.layer.cornerRadius = 4;
    showView.clipsToBounds = YES;
    
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(@(kHeight(180)));
        make.left.equalTo(@35);
        make.right.equalTo(@-35);
        make.height.equalTo(@245);

    }];
    
    UILabel *tit = [[UILabel alloc]init];
    tit.frame = CGRectMake(0, 26, SCREEN_WIDTH - 70, 26);
    tit.text = [LangSwitcher switchLang:@"请勿截图" key:nil];
    tit.font = HGboldfont(22);
    tit.textColor = kWhiteColor;
    [showView addSubview:tit];
    tit.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *tit1 =[[UILabel alloc]init];
    tit1.textAlignment = NSTextAlignmentCenter;
    tit1.text = [LangSwitcher switchLang:@"请确保四周无人及无任何摄像头！\n勿用截图或者拍照方式保存keystore文件\n或对应二维码。" key:nil];
    tit1.font = FONT(12);
    tit1.numberOfLines = 0;
    tit1.textColor = kWhiteColor;
    [showView addSubview:tit1];
    
    [tit1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tit.mas_bottom).offset(8);
        make.centerX.equalTo(showView.mas_centerX);
 
        
    }];
    
    
    
    UIImageView *im  =[[UIImageView alloc] init];
    im.contentMode = UIViewContentModeScaleToFill;
    im.image = kImage(@"请勿截图");
    im.frame = CGRectMake((SCREEN_WIDTH - 70)/2 - 30 , 26 + 21 + 70, 60, 52.5);
    [showView addSubview:im];
    
    
    UIButton *knowBut = [UIButton buttonWithTitle:@"知道了" titleColor:kHexColor(@"#FB744E") backgroundColor:kWhiteColor titleFont:14];
    [self.view1 addSubview:knowBut];
    knowBut.layer.cornerRadius = 18;
    knowBut.clipsToBounds = YES;
    [knowBut mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(showView.mas_bottom);
        make.centerX.equalTo(showView.mas_centerX);
        
        make.width.equalTo(@122);
        make.height.equalTo(@36);
        
    }];
    
    [knowBut addTarget:self action:@selector(known) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)known
{
    
    self.view1.hidden = YES;
    
}


- (void)inititem
{
    NSArray *words = [self.mnemonics componentsSeparatedByString:@" "];
    
    NSArray *tempArr = words.mutableCopy;

    self.bottomNames = [NSMutableArray array];
    
    for (int i = 0; i < tempArr.count; i++) {
     CurrencyTitleModel *title =  [[CurrencyTitleModel alloc] init];
        title.symbol = words[i];
        title.IsSelect = NO;

        [self.bottomNames addObject:title];
    }
    
    self.bottomView.titles = self.bottomNames;
    NSMutableArray *tpArray = [NSMutableArray array];
    for (int i = 0; i < self.bottomNames.count; i++) {
        [tpArray addObject:self.bottomNames[i].symbol];
    }
    
    
    [self.bottomView reloadData];
    
}
- (void)initColllention
{
    CustomLayoutWallet *layout = [[CustomLayoutWallet alloc] init];
    layout.minimumLineSpacing = 0.0; // 竖
    layout.minimumInteritemSpacing = 0.0; // 横
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, , 10);
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 30)/3, 181/4);
    UIImage *image1 = [UIImage imageNamed:@"ltc"];
    UIImage *image2 = [UIImage imageNamed:@"ltc"];
    UIImage *image3 = [UIImage imageNamed:@"ltc"];
    NSArray *array = @[image2, image2, image3, image2, image3, image1, image3, image1, image1];
    QHCollectionViewNine *bottomView = [[QHCollectionViewNine alloc] initWithFrame:CGRectMake(0, self.promptLbl.yy + 19, SCREEN_WIDTH - 30, 181) collectionViewLayout:layout withImage:array];
    self.bottomView = bottomView;
    bottomView.isRead = YES;
    bottomView.refreshDelegate = self;
    self.bottomView.type = SearchTypeTop;
    [self.whiteView addSubview:bottomView];

    bottomView.backgroundColor = kWhiteColor;
}

//- (void)addBorderToLayer:(UIView *)view
//{
//    CAShapeLayer *border = [CAShapeLayer layer];
//    //  线条颜色
//    border.strokeColor = [UIColor lightGrayColor].CGColor;
//
//    border.fillColor = nil;
//
//
//    UIBezierPath *pat = [UIBezierPath bezierPath];
//    [pat moveToPoint:CGPointMake(0, 0)];
//    if (CGRectGetWidth(view.frame) > CGRectGetHeight(view.frame)) {
//        [pat addLineToPoint:CGPointMake(view.bounds.size.width, 0)];
//    }else{
//        [pat addLineToPoint:CGPointMake(0, view.bounds.size.height)];
//    }
//    border.path = pat.CGPath;
//
//    border.frame = view.bounds;
//
//    // 不要设太大 不然看不出效果
//    border.lineWidth = 0.5;
//    border.lineCap = @"butt";
//
//    //  第一个是 线条长度   第二个是间距    nil时为实线
//    border.lineDashPattern = @[@6, @10];
//
//    [view.layer addSublayer:border];
//}


- (void)initWalletUI
{

    
    UIView *whiteView = [[UIView alloc] init];
    self.whiteView = whiteView;
    whiteView.backgroundColor = kWhiteColor;
    whiteView.layer.cornerRadius=4;
    whiteView.layer.shadowOpacity = 0.22;// 阴影透明度
    whiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    whiteView.layer.shadowRadius=3;// 阴影扩散的范围控制iiiiiiiu
    whiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    whiteView.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 482);
    [self.view addSubview:whiteView];

    
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 28, SCREEN_WIDTH - 70, 0)];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.textColor = kHexColor(@"#333333");
    self.nameLable.numberOfLines = 0;
    self.nameLable.font = FONT(16);
    self.nameLable.text = [LangSwitcher switchLang:@"您的恢复词是12个，在纸上记下他们并安全的保存它" key:nil];
    [self.nameLable sizeToFit];
    [whiteView addSubview:self.nameLable];
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(20, self.nameLable.yy + 19, SCREEN_WIDTH - 70, 40)];
    backView.backgroundColor = kHexColor(@"#F3F5F7");
    [whiteView addSubview:backView];
    

    self.contentLable = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, SCREEN_WIDTH - 70 - 12, 40)];
    self.contentLable.textColor = kHexColor(@"#B5B5B5");
    self.contentLable.numberOfLines = 0;
    self.contentLable.font = FONT(11);
    self.contentLable.textAlignment = NSTextAlignmentLeft;
    self.contentLable.text = [LangSwitcher switchLang:@"在您的手机丢失或者忘记密码的情况下，恢复词可用于你的钱包或者资金" key:nil];
    [backView addSubview:self.contentLable];
    
    
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, backView.yy + 40, SCREEN_WIDTH - 70, 1)];
    lineImage.backgroundColor = kLineColor;
    [whiteView addSubview:lineImage];

   
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, lineImage.yy + 48.5, 10, 5)];
    lineView.backgroundColor = kTabbarColor;
    [whiteView addSubview:lineView];
    
    UILabel *promptLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, lineImage.yy + 40.5, SCREEN_WIDTH - 20 - 30, 20)];
    promptLbl.textColor = kTextColor;
    promptLbl.font = FONT(14);
    promptLbl.text = [LangSwitcher switchLang:@"现在写下这些词" key:nil];
    [whiteView addSubview:promptLbl];
    self.promptLbl = promptLbl;
    [self initColllention];
    
    self.nextButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text = [LangSwitcher switchLang:@"下一步" key:nil];
    [self.nextButton setTitle:text forState:UIControlStateNormal];
    self.nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.nextButton.frame = CGRectMake(15, whiteView.yy + 26, SCREEN_WIDTH - 30, 48);
    [self.nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(buildBackUpWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton setBackgroundColor:kAppCustomMainColor forState:UIControlStateNormal];
    [self.view addSubview:self.nextButton];

}

-(void)buildBackUpWallet
{
    
    
    
    NSArray *tempArr = self.bottomNames;
    
    self.tempNames = [NSMutableArray array];
    
    for (int i = 0; i < self.bottomNames.count; i++) {
        CurrencyTitleModel *title = tempArr[i];
        title.IsSelect = NO;
        
        [self.tempNames addObject:title];
    }
    
//    self.bottomView.titles = self.bottomNames;
    //验证助记词
    BuildCheckVC *checkVC= [[BuildCheckVC alloc] init];
    checkVC.pwd = self.pwd;
    checkVC.name = self.name;
//    checkVC.view.backgroundColor = kClearColor;
    
//    self.mnemonics =  [MnemonicUtil getGenerateMnemonics];
    NSArray *words = [self.mnemonics componentsSeparatedByString:@" "];
    
    NSArray *tmpArr = words.mutableCopy;
    
    self.bottomNames = [NSMutableArray array];
    
    for (int i = 0; i < tmpArr.count; i++) {
        CurrencyTitleModel *title =  [[CurrencyTitleModel alloc] init];
        title.symbol = words[i];
        title.IsSelect = NO;
        
        [self.bottomNames addObject:title];
    }
    
    self.bottomView.titles = self.bottomNames;

    checkVC.userTitles = self.bottomNames.mutableCopy;
    NSArray *result = [self.bottomNames sortedArrayUsingComparator:^NSComparisonResult( CurrencyTitleModel* obj1,  CurrencyTitleModel* obj2) {
        
        NSLog(@"%@~%@",obj1,obj2);
        
        //乱序
        
        if (arc4random_uniform(2) == 0) {
            
            return [obj2.symbol compare:obj1.symbol]; //降序
            
        }
        
        else{
            
            return [obj1.symbol compare:obj2.symbol]; //升序
            
        }
        
    }];
    
    
    NSLog(@"result=%@",result);
    self.bottomNames = [NSMutableArray arrayWithArray:result];
    
    checkVC.bottomtitles = self.bottomNames;
    checkVC.isSave = self.isSave;
    checkVC.state = @"100";
    checkVC.titleWord = self.mnemonics;
    
    [self.navigationController pushViewController:checkVC animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
