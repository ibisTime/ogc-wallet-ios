//
//  ChangeLocalMoneyVC.m
//  Coin
//
//  Created by shaojianfei on 2018/7/2.
//  Copyright © 2018年 chengdai. All rights reserved.
//

#import "ChangeLocalMoneyVC.h"
#import "LangChooseVC.h"
#import "SettingModel.h"
#import <CDCommon/UIScrollView+TLAdd.h>
#import "TLTabBarController.h"
@interface ChangeLocalMoneyVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *langChooseTV;
@property (nonatomic, strong) NSMutableArray <SettingModel *>*models;
@property (nonatomic, copy)  NSString *type;
@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *nameLable;
@end

@implementation ChangeLocalMoneyVC
- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleText.text = [LangSwitcher switchLang:@"本地货币" key:nil];
    self.navigationItem.titleView = self.titleText;
    self.models = [[NSMutableArray alloc] init];
    

    self.langChooseTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStylePlain];
    self.langChooseTV.rowHeight = 55;
    [self.view addSubview:self.langChooseTV];
    self.langChooseTV.delegate = self;
    self.langChooseTV.dataSource = self;
    self.langChooseTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakself = self;
   self.type =   [[NSUserDefaults standardUserDefaults] objectForKey:KLocalMoney];
    SettingModel *simpleModel = [[SettingModel alloc] init];

    simpleModel.text = @"CNY";
    
    simpleModel.isSelect = [simpleModel.text isEqualToString:self.type];
    if (!self.type) {
        simpleModel.isSelect = YES;
    }
    [simpleModel setAction:^{
        
        [weakself langType:LangTypeSimple];
    }];
    //
    SettingModel *tridationModel = [[SettingModel alloc] init];
    //    tridationModel.text = [LangSwitcher switchLang:@"繁体中文" key:nil];
    tridationModel.text = @"USD";
    
    tridationModel.isSelect = [tridationModel.text isEqualToString:self.type];
    [tridationModel setAction:^{
        
        [weakself langType:LangTypeEnglish];
        
    }];
    
//    SettingModel *tridationModel1 = [[SettingModel alloc] init];
//    //    tridationModel.text = [LangSwitcher switchLang:@"繁体中文" key:nil];
//    tridationModel1.text = @"KRW";
//
//    tridationModel1.isSelect = [tridationModel1.text isEqualToString:self.type];
//    [tridationModel1 setAction:^{
//
//        [weakself langType:LangTypeKorean];
//
//    }];
    
    [self.models addObjectsFromArray:@[simpleModel,tridationModel]];

}
- (void)buttonClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)langType:(LangType)type {
    
    NSString *money ;
    if (type == LangTypeSimple) {
        money = @"CNY";
    }else if (type == LangTypeKorean)
    {
        
        money = @"KRW";

    }
    else{
        
        money = @"USD";
    }
    
    [TLAlert alertWithTitle:[LangSwitcher switchLang:@"切换货币" key:nil]
                        msg:nil
                 confirmMsg:[LangSwitcher switchLang:@"确定" key:nil]
                  cancleMsg:[LangSwitcher switchLang:@"取消" key:nil]
                     cancle:^(UIAlertAction *action) {
                         
                     } confirm:^(UIAlertAction *action) {
                         
//                         TLDataBase *db = [TLDataBase sharedManager];
//
//                         if ([db.dataBase open]) {
//                              NSString *sql = [NSString stringWithFormat:@"UPDATE THAWallet SET MoneyType = '%@' WHERE userId = '%@'",money,[TLUser user].userId];
//                           BOOL sucess =   [db.dataBase executeUpdate:sql];
//
//                             NSLog(@"保存本地货币选择%d",sucess);
//                             if (sucess == 1) {
//                                 [TLUser user].localMoney = money;
//                             }
//                         }
//                         [db.dataBase close];
                         [TLUser user].localMoney = money;
                         [[NSUserDefaults standardUserDefaults] setObject:money forKey:KLocalMoney];

//                         [LangSwitcher changLangType:type];
                         //                             UIView *v = nil;
                         TLTabBarController *tabBarCtrl = [[TLTabBarController alloc] init];
                         [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;
//                         [LangSwitcher startWithTraditional];
                         //                             [v sizeToFit];
                         
                         
                         //                             NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                         //                             dict[nil] = @"";
                     }];
    
}

//- (void)viewDidLayoutSubviews {
//    self.langChooseTV.frame = self.view.bounds;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.models[indexPath.row].action) {
        
        self.models[indexPath.row].action();
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellId"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellId"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = kWhiteColor;
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kLineColor;
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.7);
            make.left.equalTo(@15);
            make.right.equalTo(@15);
            make.bottom.equalTo(@0);
        }];
        
        
        
    }
    
    // 判断出当前类型
    
    SettingModel *settingModel = self.models[indexPath.row];
    cell.textLabel.text = settingModel.text;
    
    if (settingModel.isSelect) {
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 11)];
        //        iv.backgroundColor = [UIColor orangeColor];
        [cell addSubview:iv];
        iv.image = [UIImage imageNamed:@"打勾"];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-20);
        }];
        
    }else{
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 11)];
        //        iv.backgroundColor = [UIColor orangeColor];
        [cell addSubview:iv];
        iv.image = [UIImage imageNamed:@""];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(cell.mas_right).offset(-20);
            make.height.width.mas_equalTo(20);
        }];
        
    }
    
    
    return cell;
    
}



@end
