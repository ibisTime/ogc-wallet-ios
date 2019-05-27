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
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    self.titleText.text = [LangSwitcher switchLang:@"创建钱包" key:nil];
    self.navigationItem.titleView = self.titleText;
    [self initViews];
//    self.mnemonics =  [MnemonicUtil getGenerateMnemonics];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)initViews
{
    self.mnemonics = [MnemonicUtil getGenerateMnemonics];
    
    NSArray *array = [CustomFMDB FMDBqueryMnemonics];
    NSMutableArray *wallet = [NSMutableArray array];
    [wallet addObjectsFromArray:array];
    
    NSDictionary *dic = @{
                          @"mnemonics":self.mnemonics,
                          @"pwd":self.PWD,
                          @"walletName":self.name
                          };
    [wallet addObject:dic];
    
    
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:wallet options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"JMQBWALLET.db"];
    NSLog(@"dbPath = %@",dbPath);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    
    if ([dataBase open])
    {
        [dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS JMQBWALLET (rowid INTEGER PRIMARY KEY AUTOINCREMENT, userid text,wallet text)"];
    }
    [dataBase close];
    [dataBase open];
    [dataBase executeUpdate:@"INSERT INTO JMQBWALLET (userid,wallet) VALUES (?,?)",[TLUser user].userId,jsonStr];
    [dataBase close];
    
    [USERDEFAULTS setObject:self.mnemonics forKey:@"mnemonics"];

    NSNotification *notification =[NSNotification notificationWithName:@"SwitchThePurse" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40, 68.5, 80, 80)];
    [topImg theme_setImageIdentifier:@"钱包新建成功" moduleName:ImgAddress];
    [self.view addSubview:topImg];
    
    UILabel *newWallet = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextBlack font:20];
    newWallet.text = [LangSwitcher switchLang:@"新钱包创建成功" key:nil];
    newWallet.textAlignment = NSTextAlignmentCenter;
    newWallet.frame = CGRectMake(0, topImg.yy + 12.5, SCREEN_WIDTH, 28);
    [self.view addSubview:newWallet];
    
    
    UILabel *introduce = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor2 font:12];
    introduce.numberOfLines = 0;
    introduce.text = [LangSwitcher switchLang:@"强烈建议您在使用钱包钱做好备份，导出[助记词]或keystore存储到安全的地方。然后开始尝试转入小额资金启用。" key:nil];
    introduce.textAlignment = NSTextAlignmentLeft;
    introduce.frame = CGRectMake(45, newWallet.yy + 13, SCREEN_WIDTH - 90, 0);
    [introduce sizeToFit];
    [introduce theme_setTextColorIdentifier:GaryLabelColor moduleName:ColorName];
    [self.view addSubview:introduce];
    
   

    
    self.buildButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text = [LangSwitcher switchLang:@"备份钱包" key:nil];
    [self.buildButton setTitle:text forState:UIControlStateNormal];
    self.buildButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.buildButton.frame = CGRectMake(15, introduce.yy + 76, SCREEN_WIDTH - 30, 50);
    [self.buildButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.buildButton addTarget:self action:@selector(buildBackUpWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.buildButton setBackgroundColor:kTabbarColor forState:UIControlStateNormal];
    [self.view addSubview:self.buildButton];
    
    
    self.howButton = [UIButton buttonWithImageName:nil cornerRadius:6];
        NSString *text1 = [LangSwitcher switchLang:@"如何备份钱包?" key:nil];
    self.howButton.frame = CGRectMake(15, self.buildButton.yy + 5, SCREEN_WIDTH - 30, 50);
    [self.howButton setTitle:text1 forState:UIControlStateNormal];
    self.howButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.howButton setTitleColor:kTabbarColor forState:UIControlStateNormal];
    [self.howButton addTarget:self action:@selector(backUpWalletIntroduce) forControlEvents:UIControlEventTouchUpInside];
    [self.howButton setBackgroundColor:kClearColor forState:UIControlStateNormal];
    [self.view addSubview:self.howButton];
    
}

- (void)buildBackUpWallet
{

    self.mnemonics = [MnemonicUtil getGenerateMnemonics];
    //点击备份钱包 生成助记词
    BuildBackUpVC *backUpVC = [BuildBackUpVC new];
    backUpVC.pwd = self.PWD;
    backUpVC.name = self.name;
    backUpVC.mnemonics = self.mnemonics;
    backUpVC.isSave = YES;
    backUpVC.state = self.state;
    [self.navigationController pushViewController:backUpVC animated:YES];
    
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
