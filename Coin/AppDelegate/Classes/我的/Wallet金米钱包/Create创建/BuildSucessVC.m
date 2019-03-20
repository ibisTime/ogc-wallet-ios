//
//  BuildSucessVC.m
//  Coin
//
//  Created by shaojianfei on 2018/6/8.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "BuildSucessVC.h"
#import "BuildBackUpVC.h"
#import "MnemonicUtil.h"
#import "HTMLStrVC.h"
@interface BuildSucessVC ()

@property (nonatomic ,strong) UIImageView *iconImage;

@property (nonatomic ,strong) UILabel *nameLable;

@property (nonatomic ,strong) UILabel *messageLable;

@property (nonatomic ,strong) UILabel *bottomLable;

@property (nonatomic ,strong) UIButton *buildButton;

@property (nonatomic ,strong) UIButton *importButton;

@property (nonatomic ,strong) UIButton *introduceButton;

@property (nonatomic ,copy) NSString *mnemonics;

@property (nonatomic ,strong) UIButton *howButton;

@end

@implementation BuildSucessVC

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
    self.titleText.text = [LangSwitcher switchLang:@"创建钱包" key:nil];
    self.titleText.textColor = kWhiteColor;
    self.navigationItem.titleView = self.titleText;
    [self initViews];
//    self.mnemonics =  [MnemonicUtil getGenerateMnemonics];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)initViews
{
    self.view.backgroundColor = kWhiteColor;

    UIView *topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    topView.backgroundColor = kTabbarColor;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(kHeight(66)));
    }];
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = kWhiteColor;
    [self.view addSubview:whiteView];
    UIImageView *bgImage = [[UIImageView alloc] init];
    bgImage.image = kImage(@"打勾 大");
    [whiteView addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(@(kHeight(50)));
        make.centerX.equalTo(whiteView.mas_centerX);
        make.width.height.equalTo(@(kHeight(80)));
    }];
    
    UILabel *newWallet = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:20];
    
    [whiteView addSubview:newWallet];
    newWallet.text = [LangSwitcher switchLang:@"新钱包创建成功" key:nil];
    newWallet.textAlignment = NSTextAlignmentCenter;
    [newWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(bgImage.mas_bottom).offset(16);
        make.centerX.equalTo(whiteView.mas_centerX);
//        make.width.height.equalTo(@(kHeight(80)));
    }];
    
    UILabel *introduce = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:12];
    
    [whiteView addSubview:introduce];
    introduce.numberOfLines = 0;
    introduce.text = [LangSwitcher switchLang:@"强烈建议您在使用钱包前做好备份，导出[助记词]存储到安全的地方。然后开始尝试转入小额资金启用" key:nil];
    introduce.textAlignment = NSTextAlignmentLeft;
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(newWallet.mas_bottom).offset(8);
        make.left.equalTo(whiteView.mas_left).offset(30);
        make.right.equalTo(whiteView.mas_right).offset(-30);

//        make.centerX.equalTo(whiteView.mas_centerX);
        //        make.width.height.equalTo(@(kHeight(80)));
    }];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top);
        
        make.height.equalTo(@(kHeight(292)));
    }];
    
    whiteView.layer.cornerRadius = 4;
    whiteView.clipsToBounds = YES;

    
    self.buildButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text = [LangSwitcher switchLang:@"备份钱包" key:nil];
    [self.buildButton setTitle:text forState:UIControlStateNormal];
    self.buildButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.buildButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.buildButton addTarget:self action:@selector(buildBackUpWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.buildButton setBackgroundColor:kTabbarColor forState:UIControlStateNormal];
    [self.view addSubview:self.buildButton];
    [self.buildButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_bottom).offset(26);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(@45);
        
    }];
    
    self.howButton = [UIButton buttonWithImageName:nil cornerRadius:6];
        NSString *text1 = [LangSwitcher switchLang:@"如何备份钱包?" key:nil];
//    NSString *text1 = NSLocalizedString(@"如何备份钱包?", nil);
    
    [self.howButton setTitle:text1 forState:UIControlStateNormal];
    self.howButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.howButton setTitleColor:kTabbarColor forState:UIControlStateNormal];
    [self.howButton addTarget:self action:@selector(backUpWalletIntroduce) forControlEvents:UIControlEventTouchUpInside];
    [self.howButton setBackgroundColor:kClearColor forState:UIControlStateNormal];
    [self.view addSubview:self.howButton];
    [self.howButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buildButton.mas_bottom).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(@45);
        
    }];
}

- (void)buildBackUpWallet
{
    
    

//    if ([dataBase open])
//    {
//        NSString *sql = [NSString stringWithFormat:@"select * from ChengWallet"];
//
//        FMResultSet *resultSet = [dataBase executeQuery:sql];
//
//        while (resultSet.next)
//        {
////            NSString *userid = [resultSet stringForColumn:@"userid"];
//            NSString *mnemonics = [resultSet stringForColumn:@"mnemonics"];
//            NSString *walletList = [resultSet stringForColumn:@"walletList"];
////            NSLog(@"======= %@%@%@",userid,mnemonics,walletList);
//        }
//    }
//    [dataBase close];
    
        
//    }
    self.mnemonics = [MnemonicUtil getGenerateMnemonics];
    //点击备份钱包 生成助记词
    BuildBackUpVC *backUpVC = [BuildBackUpVC new];
    backUpVC.pwd = self.PWD;
    backUpVC.name = self.name;
    backUpVC.mnemonics = self.mnemonics;
    [self.navigationController pushViewController:backUpVC animated:YES];
//    TLDataBase *dataBase = [TLDataBase sharedManager];
//    NSString *word;
//    if ([dataBase.dataBase open]) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT Mnemonics from THAUser where userId = '%@'",[TLUser user].userId];
//        FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//        while ([set next])
//        {
//            word = [set stringForColumn:@"Mnemonics"];
//
//        }
//        [set close];
//    }
//    [dataBase.dataBase close];
//    if (word.length > 0) {
//        self.mnemonics = word;
//        backUpVC.mnemonics = self.mnemonics;
//        backUpVC.isCopy = self.isCopy;
//        [self.navigationController pushViewController:backUpVC animated:YES];
//    }else{
//    self.mnemonics = [MnemonicUtil getGenerateMnemonics];
//
//    NSArray *words = [self.mnemonics componentsSeparatedByString:@" "];
//    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
//
//    for (unsigned i = 0; i < [words count]; i++){
//
//        if ([categoryArray containsObject:[words objectAtIndex:i]] == NO){
//
//            [categoryArray addObject:[words objectAtIndex:i]];
//
//        }
//
//
//
//    }
//    if (categoryArray.count < 12) {
//        self.mnemonics = [MnemonicUtil getGenerateMnemonics];
//        NSArray *words = [self.mnemonics componentsSeparatedByString:@" "];
//        NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
//
//        for (unsigned i = 0; i < [words count]; i++){
//
//            if ([categoryArray containsObject:[words objectAtIndex:i]] == NO){
//
//                [categoryArray addObject:[words objectAtIndex:i]];
//
//            }
//
//
//
//        }
//    }
//    if (categoryArray.count < 12) {
//        [self buildBackUpWallet];
//     }
    
//    }


}




- (void)backUpWalletIntroduce
{
    
    HTMLStrVC *htmlVC = [[HTMLStrVC alloc] init];
    self.navigationController.navigationBar.hidden = NO;
    
    htmlVC.type = HTMLTypeMnemonic_backup;
    
    [self.navigationController pushViewController:htmlVC animated:YES];
    
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
