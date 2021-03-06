//
//  WalletSettingVC.m
//  Coin
//
//  Created by shaojianfei on 2018/6/7.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "WalletSettingVC.h"
#import "CheckForwordVC.h"
#import "SettingGroup.h"
#import "SettingTableView.h"
#import "EditEmailVC.h"
#import "WalletDelectVC.h"
#import "BuildSucessVC.h"
#import "TLTabBarController.h"
#import "BuildBackUpVC.h"
#import "TLNewPwdVC.h"
@interface WalletSettingVC ()
@property (nonatomic, strong) SettingGroup *group;
@property (nonatomic, strong) SettingTableView *tableView;
@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic ,strong) UIButton *importButton;

@end

@implementation WalletSettingVC
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [self.tableView reloadData];
//}
////如果仅设置当前页导航透明，需加入下面方法
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    
//}
- (void)viewDidLoad {
    self.title = [LangSwitcher switchLang:@"钱包工具" key:nil];
    [self setGroup];
    [self initTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Init
- (void)initTableView {
    self.tableView = [[SettingTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight) style:UITableViewStyleGrouped];
    self.tableView.group = self.group;
    [self.view addSubview:self.tableView];
    self.importButton = [UIButton buttonWithImageName:nil cornerRadius:6];
    NSString *text2 = [LangSwitcher switchLang:@"删除钱包" key:nil];
    [self.importButton setTitle:text2 forState:UIControlStateNormal];
    self.importButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.importButton setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];
    [self.importButton addTarget:self action:@selector(import) forControlEvents:UIControlEventTouchUpInside];
    [self.importButton setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
    self.importButton.layer.borderColor = (kAppCustomMainColor.CGColor);
    self.importButton.layer.borderWidth = 1;
    self.importButton.clipsToBounds = YES;
    [self.view addSubview:self.importButton];
    [self.importButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kHeight(200)));
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.height.equalTo(@50);
        
    }];
}

- (void)import
{
    WalletDelectVC *authVC = [WalletDelectVC new];
//    authVC.WalletType = WalletWordTypeThree;
    authVC.title = [LangSwitcher switchLang:@"删除钱包" key:nil];
    [TLAlert alertWithTitle:[LangSwitcher switchLang:@"请输入交易密码" key:nil]
                        msg:@""
                 confirmMsg:[LangSwitcher switchLang:@"确定" key:nil]
                  cancleMsg:[LangSwitcher switchLang:@"取消" key:nil]
                placeHolder:[LangSwitcher switchLang:@"请输入交易密码" key:nil]
                      maker:self cancle:^(UIAlertAction *action) {
                          
                      } confirm:^(UIAlertAction *action, UITextField *textField) {
                          NSDictionary *walletDic = [CustomFMDB FMDBqueryUseridMnemonicsPwdWalletName];
//                          walletName.text = walletDic[@"walletName"];
                          NSString *pwd = walletDic[@"pwd"];
                          NSString *mnemonics = walletDic[@"mnemonics"];
                          NSString *Name = walletDic[@"walletName"];
                          if ([pwd isEqualToString:textField.text]) {
                              [self deleteWallet];
                          }else{
                              [TLAlert alertWithError:@"交易密码错误"];
                              
                          }
//                          [self confirmWithdrawalsWithPwd:textField.text];

                      }];
    
}

- (void)setGroup {
    
    CoinWeakSelf;
    
    //资金密码
    
    SettingModel *walletName = [SettingModel new];
    
//    TLDataBase *dataBase = [TLDataBase sharedManager];
//    NSString *word;
//    if ([dataBase.dataBase open]) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT name from THAUser where userId = '%@'",[TLUser user].userId];
//        //        [sql appendString:[TLUser user].userId];
//        FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//        while ([set next])
//        {
//            word = [set stringForColumn:@"name"];
//
//        }
//        [set close];
//    }
//    [dataBase.dataBase close];
//    if (word || word.length > 0) {
//        walletName.text = [LangSwitcher switchLang:word key:nil];
//
//    }else{
//        walletName.text =@"";
//
//
//    }
    NSDictionary *walletDic = [CustomFMDB FMDBqueryUseridMnemonicsPwdWalletName];
    walletName.text = walletDic[@"walletName"];
    NSString *pwd = walletDic[@"pwd"];
    NSString *mnemonics = walletDic[@"mnemonics"];
    NSString *Name = walletDic[@"walletName"];
    
    SettingModel *changeTradePwd = [SettingModel new];
    changeTradePwd.text = [LangSwitcher switchLang:@"修改密码" key:nil];
    [changeTradePwd setAction:^{
        
        TLNewPwdVC *new = [[TLNewPwdVC alloc] init];
        new.title = [LangSwitcher switchLang:@"修改交易密码" key:nil];

        [weakSelf.navigationController pushViewController:new animated:YES];
        
    }];
    
    
    //实名认证
    SettingModel *idAuth = [SettingModel new];
    idAuth.text = [LangSwitcher switchLang:@"钱包备份" key:nil];
    
    
//    NSDictionary *walletDic = [CustomFMDB FMDBqueryUseridMnemonicsPwdWalletName];
//    NSString *pwd = walletDic[@"pwd"];
    
    [idAuth setAction:^{
        
        [TLAlert alertWithTitle:[LangSwitcher switchLang:@"请输入交易密码" key:nil]
                            msg:@""
                     confirmMsg:[LangSwitcher switchLang:@"确定" key:nil]
                      cancleMsg:[LangSwitcher switchLang:@"取消" key:nil]
                    placeHolder:[LangSwitcher switchLang:@"请输入交易密码" key:nil]
                          maker:self cancle:^(UIAlertAction *action) {
                              
                          } confirm:^(UIAlertAction *action, UITextField *textField) {
                              if ([pwd isEqualToString:textField.text]) {
                                  BuildBackUpVC *vc =[BuildBackUpVC new];
                                  vc.title = [LangSwitcher switchLang:@"钱包备份" key:nil];
                                  vc.mnemonics = mnemonics;
                                  vc.pwd = pwd;
                                  vc.name = Name;
                                  vc.isSave = NO;
                                  [self.navigationController pushViewController:vc animated:YES];
                              }else{
                                  [TLAlert alertWithError:@"交易密码错误"];
                                  
                              }
                              
                          }];
        
    }];
                              
//                              TLDataBase *dataBase = [TLDataBase sharedManager];
//
//                              if ([dataBase.dataBase open]) {
//                                  NSString *sql = [NSString stringWithFormat:@"SELECT PwdKey from THAUser where userId = '%@'",[TLUser user].userId];
//                                  //        [sql appendString:[TLUser user].userId];
//                                  FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//                                  while ([set next])
//                                  {
//                                      pwd = [set stringForColumn:@"PwdKey"];
//
//                                  }
//                                  [set close];
//                              }
//                              [dataBase.dataBase close];
//                              if ([pwd isEqualToString:textField.text]) {
//
//                                  TLDataBase *dataBase = [TLDataBase sharedManager];
//                                  NSString *word;
//                                  NSString *name;
//
//                                  if ([dataBase.dataBase open]) {
//                                      NSString *sql = [NSString stringWithFormat:@"SELECT Mnemonics,name from THAUser where userId = '%@'",[TLUser user].userId];
//                                      //        [sql appendString:[TLUser user].userId];
//                                      FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//                                      while ([set next])
//                                      {
//                                          word = [set stringForColumn:@"Mnemonics"];
//                                          name = [set stringForColumn:@"name"];
//
//                                      }
//                                      [set close];
//                                  }
//                                  [dataBase.dataBase close];
                              
//                                  if (word.length > 0) {
                              

//                                  }else{
//
//                                      return ;
//                                  }
                              
//                              }else{
//                                  [TLAlert alertWithError:@"交易密码错误"];
//
//                              }
//                              if (word || word.length > 0) {
//                                  walletName.text = [LangSwitcher switchLang:word key:nil];
//
//                              }else{
//                                  walletName.text = [LangSwitcher switchLang:@"钱包名称" key:nil];
//
//
//                              }
                              //                          [self confirmWithdrawalsWithPwd:textField.text];
                              

    
    //绑定邮箱
//    SettingModel *bindEmail = [SettingModel new];
//    bindEmail.text = [LangSwitcher switchLang:@"导出私钥" key:nil];
//    [bindEmail setAction:^{
//
//        CheckForwordVC *editVC = [[CheckForwordVC alloc] init];
//        editVC.WalletType = WalletWordTypeThree;
//
//        editVC.title = [LangSwitcher switchLang:@"导出私钥" key:nil];
//
//
//        [weakSelf.navigationController pushViewController:editVC animated:YES];
//    }];
    

    
//    SettingModel *changeLoginPwd = [SettingModel new];
//    changeLoginPwd.text = [LangSwitcher switchLang:@"删除钱包" key:nil];
//    [changeLoginPwd setAction:^{
//
//        WalletDelectVC *changeLoginPwdVC = [WalletDelectVC new];
//        [weakSelf.navigationController pushViewController:changeLoginPwdVC animated:YES];
//
//    }];
    
  
    
    self.group = [SettingGroup new];
    self.group.sections = @[@[walletName,changeTradePwd], @[idAuth]];
    
}
- (void)deleteWallet
{
    
//    TLDataBase *dataBase = [TLDataBase sharedManager];
//    NSString *word;
//    if ([dataBase.dataBase open]) {
//
//
//        NSString *sql = [NSString stringWithFormat:@"SELECT Mnemonics from THAUser where userId = '%@'",[TLUser user].userId];
//        //        [sql appendString:[TLUser user].userId];
//        FMResultSet *set = [dataBase.dataBase executeQuery:sql];
//        while ([set next])
//        {
//            word = [set stringForColumn:@"Mnemonics"];
//
//        }
//        [set close];
//    }
//    [dataBase.dataBase close];
//    if (!word) {
//        return;
//    }
//    [NSString stringWithFormat:@"select * from ChengWallet where userid like '%@'",[TLUser user].userId]
    [TLAlert alertWithTitle:[LangSwitcher switchLang:@"删除钱包" key:nil] msg:[LangSwitcher switchLang:@"请确保已备份钱包至安全的地方，金米钱包不承担任何钱包丢失、被盗、忘记密码等产生的资产损失!" key:nil] confirmMsg:[LangSwitcher switchLang:@"确定" key:nil] cancleMsg:[LangSwitcher switchLang:@"取消" key:nil] maker:self cancle:^(UIAlertAction *action) {
        
        
    } confirm:^(UIAlertAction *action) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"ChengWallet.db"];
        FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
        
        if ([dataBase open]) {
            NSString *Sql2 =[NSString stringWithFormat:@"delete from ChengWallet where userid = '%@'",[TLUser user].userId];
            
            BOOL sucess2  = [dataBase executeUpdate:Sql2];
            NSLog(@"删除自选表%d",sucess2);
            
            
//            NSString *Sql =[NSString stringWithFormat:@"delete from THAUser WHERE userId = '%@'",[TLUser user].userId];
//
//            BOOL sucess  = [db.dataBase executeUpdate:Sql];
//
//            NSLog(@"删除钱包表%d",sucess);
            
            
        }
        
        [dataBase close];

        [TLAlert alertWithMsg:[LangSwitcher switchLang:@"删除成功" key:nil]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            //            创建通知
            //            self.tabBarController.selectedIndex = 3;
//            NSNotification *notification =[NSNotification notificationWithName:@"PrivateKeyWalletCreat" object:nil userInfo:nil];
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
        });
    }];
    
    
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
