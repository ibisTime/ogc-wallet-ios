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

- (void)viewDidLoad {
    self.titleText.text = [LangSwitcher switchLang:@"钱包工具" key:nil];
    self.navigationItem.titleView = self.titleText;
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
    
    //交易密码
    
    SettingModel *walletName = [SettingModel new];
    
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
    
    
    self.group = [SettingGroup new];
    self.group.sections = @[@[walletName,changeTradePwd], @[idAuth]];
    
}
- (void)deleteWallet
{

    
    
    
    
    [TLAlert alertWithTitle:[LangSwitcher switchLang:@"删除钱包" key:nil] msg:[LangSwitcher switchLang:@"请确保已备份钱包至安全的地方，TICP不承担任何钱包丢失、被盗、忘记密码等产生的资产损失!" key:nil] confirmMsg:[LangSwitcher switchLang:@"确定" key:nil] cancleMsg:[LangSwitcher switchLang:@"取消" key:nil] maker:self cancle:^(UIAlertAction *action) {
        
        
    } confirm:^(UIAlertAction *action) {
        
        NSArray *array = [CustomFMDB FMDBqueryMnemonics];
        NSMutableArray *muArray = [NSMutableArray array];
        [muArray addObjectsFromArray:array];
        for (int i = 0 ; i < muArray.count; i ++) {
            
            if ([muArray[i][@"mnemonics"] isEqualToString:[USERDEFAULTS objectForKey:@"mnemonics"]]) {
                [muArray removeObjectAtIndex:i];
            }
            
        }
        NSError *err = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:muArray options:NSJSONWritingPrettyPrinted error:&err];
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        //        NSString *str = [wallet componentsJoinedByString:@","];
        
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

        
        [USERDEFAULTS setObject:@"" forKey:@"mnemonics"];
        NSNotification *notification =[NSNotification notificationWithName:@"SwitchThePurse" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [TLAlert alertWithMsg:[LangSwitcher switchLang:@"删除成功" key:nil]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            //            创建通知
            //            self.tabBarController.selectedIndex = 3;
//            NSNotification *notification =[NSNotification notificationWithName:@"SwitchThePurse" object:nil userInfo:nil];
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
