//
//  TLUpdateVC.m
//  ZHCustomer
//
//  Created by  tianlei on 2017/8/17.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLUpdateVC.h"
#import "TLNetworking.h"
#import "TLProgressHUD.h"
#import "AppConfig.h"
#import "GengXinModel.h"
#import "TLTabBarController.h"
#import "AppConfig.h"
#import "BuildWalletMineVC.h"
#import "TLUserLoginVC.h"
#import "CountryModel.h"
#import "ZLGestureLockViewController.h"
#import "NSString+Check.h"
@interface TLUpdateVC ()
@property (nonatomic,strong) NSMutableArray <CountryModel *>*countrys;

@end

@implementation TLUpdateVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgIV];
    bgIV.contentMode = UIViewContentModeScaleAspectFill;
    bgIV.image = [UIImage imageNamed:@"Launch"];

    [self configurationLoadData];

//    由于无法通过，审核。如果为强制更新
}

-(void)configurationLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630508";
    http.parameters[@"status"] = @"1";
    http.parameters[@"parentCode"] = @"DH201810120023250000000";
    [http postWithSuccess:^(id responseObject) {
        
        
         TLTabBarController *tabBarCtrl = [[TLTabBarController alloc] init];
        
        ZLGestureLockViewController *vc = [ZLGestureLockViewController new];
        vc.isCheck = YES;
        
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
//        BOOL isLanch  = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLanch"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLanch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *word = [ZLGestureLockViewController gesturesPassword];
        if (word.length >0) {
            [self presentViewController:na animated:YES completion:nil];
            vc.CheckSucessBlock = ^{
                [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;
                
            };
        }else{
            
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;
            
        }
        
        
       
        //        tab.dataArray = dataArray;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TABBAR" object:@{@"data":responseObject}];
//        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        
    } failure:^(NSError *error) {
        NSString *dic = error.description;
        if ([dic containsString:@"token"])
        {
            
        }
        else
        {
            [TLAlert alertWithTitle:@"提示" msg:@"获取配置失败，是否重新获取" confirmMsg:@"确定" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
                
                } confirm:^(UIAlertAction *action) {
                    [self configurationLoadData];
            }];
        }
//        NSDictionary *dic = [self convertToDictionary:error.description];
//        NSData *jsonData = [error.description dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *err;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                            options:NSJSONReadingMutableContainers
//                                                            error:&err];
        NSLog(@"====== %@",dic);
//        if ([dic[@"errorCode"] isEqualToString:@"4"])
//        {
//
//        }
//        else
//        {
//            [TLAlert alertWithTitle:@"提示" msg:@"获取配置失败，是否重新获取" confirmMsg:@"确定" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
//
//            } confirm:^(UIAlertAction *action) {
//                [self configurationLoadData];
//            }];
//
//        }
    }];
}

-(NSDictionary *)convertToDictionary:(NSString *)jsonStr
{
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return tempDic;
}

-(NSString *)getWANIP
{
    //通过淘宝的服务来定位WAN的IP，否则获取路由IP没什么用
    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
    NSData *data = [NSData dataWithContentsOfURL:ipURL];
    if (data == nil) {
        return @"0086";
    }
    NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]; 
    NSString *ipStr = nil;
    if (ipDic && [ipDic[@"code"] integerValue] == 0) { //获取成功
        ipStr = ipDic[@"data"][@"country_id"];
    }
    return (ipStr ? ipStr : @"");
}

- (void)loadData
{
//    TLNetworking *net = [TLNetworking new];
//    net.showView = self.view;
//    net.code = @"801120";
//    net.isLocal = YES;
//    net.ISparametArray = YES;
//    net.parameters[@"status"] = @"1";
//    [net postWithSuccess:^(id responseObject) {
//        self.countrys = [CountryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
////      self.countrys = [CountryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//
////
//
//        for (int i = 0; i < self.countrys.count; i++) {
//
//            if ([dic isEqualToString:self.countrys[i].interSimpleCode]) {
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.countrys[i]];
//
//                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"chooseModel"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
////
//                NSString *str = self.countrys[i].interSimpleCode;
//                if ([str isEqualToString:@"CN"] || [str hasPrefix:@"CN"]) {
//                    [LangSwitcher changLangType:LangTypeSimple];
//                }else if ([str isEqualToString:@"KR"])
//                {
//                    [LangSwitcher changLangType:LangTypeKorean];
//
//
//                }else{
//
//                    [LangSwitcher changLangType:LangTypeEnglish];
//
//                }
//
//            }else{
//
//                //
//                [LangSwitcher changLangType:LangTypeEnglish];
//
//            }
//
//
    
        [self configUpdate];

        
        //        for (int i = 0; i < self.countrys.count; i++) {
        //
        //            CountryModel *model = self.countrys[i];
        //            NSString *code =[TLUser user].interCode;
        //            if (code == model.interCode) {
        //                NSString *url = [model.pic convertImageUrl];
        //                [self.pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kImage(@"中国国旗")];
        //                self.PhoneCode.text = [NSString stringWithFormat:@"+%@",[model.interCode substringFromIndex:2]];
        //            }
        //        }
        
        //        [self.tableView reloadData];
        //        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"data"]];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"RealNameAuthResult" object:str];
        
//
//    } failure:^(NSError *error) {
//
//        [self configUpdate];
//
    
    
    
}



- (void)applicationWillEnterForeground {

//    [self updateApp];
    //    [self updateApp];

}

- (void)updateApp {
    
    NSString *appId = @"1264435742"; //test
//    NSString *appId = @"1321457016";
    //
    [TLProgressHUD showWithStatus:nil];
    //获取版本
    [TLNetworking GET:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appId]
           parameters:nil
              success:^(NSString *msg, id data) {
        
        [TLProgressHUD dismiss];
        [self removePlaceholderView];
        
        NSDictionary *resutltDict = data;
//#warning 这种判断只适用于，第一次审核。审核通过之后，第二次提交审核这种判断要改掉
////        // !!!!! 这种判断
////        //1.1在审核中
//        if ([resutltDict[@"resultCount"] isEqual:@0]) {
//
//          [AppConfig config].isChecking = true;
//          [self setRootVC];
//           return;
//        }
//
//        //审核通过
//        [AppConfig config].isChecking = false;
//        [self setRootVC];

        // CFBundleVersion 构建版本号
        // CFBundleShortVersionString
        // CFBundleDisplayName
        
        // 本地版本
        NSString *currentBuildVersion = [self version];

        //线上版本
        NSString *onlineBuildVersion = resutltDict[@"results"][0][@"version"];

        //1.2在审核中
        if ([currentBuildVersion floatValue] > [onlineBuildVersion floatValue]) {

            [self setRootVC];
            return;
        }

        //2.2 用户正常使用
      [self configUpdate];
 
    } abnormality:nil failure:^(NSError *error) {
        [TLProgressHUD dismiss];
        [self addPlaceholderView];
    }];
    
    

}



- (void)tl_placeholderOperation {

//    [self updateApp];
    [self configUpdate];

}

- (NSString *)version {
    
   return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
}

//#pragma mark - Config
- (void)configUpdate {

    //1:iOS 2:安卓
    TLNetworking *http = [[TLNetworking alloc] init];

    http.code = @"660918";
    http.parameters[@"type"] = @"ios-c";

    [http postWithSuccess:^(id responseObject) {

        GengXinModel *update = [GengXinModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self removePlaceholderView];
        //获取当前版本号
        NSString *currentVersion = [self version];

       
        if ([currentVersion integerValue] < [update.version integerValue]) {

            if ([update.forceUpdate isEqualToString:@"0"]) {

                //不强制
                [TLAlert alertWithTitle:[LangSwitcher switchLang:@"更新提示" key:nil] msg:update.note confirmMsg:[LangSwitcher switchLang:@"立即升级" key:nil] cancleMsg:[LangSwitcher switchLang:@"稍后提醒" key:nil] cancle:^(UIAlertAction *action) {
                    
                    

                    [self setRootVC];

                } confirm:^(UIAlertAction *action) {

//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[update.xiaZaiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
                      [self goBcoinWeb:update.downloadUrl];
                }];

            } else {

                //强制
                [TLAlert alertWithTitle:[LangSwitcher switchLang:@"更新提醒" key:nil] message:update.note confirmMsg:[LangSwitcher switchLang:@"立即升级" key:nil] confirmAction:^{

//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[update.xiaZaiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
                    [self goBcoinWeb:update.downloadUrl];


                }];
            }
        } else {
            
            [self setRootVC];
            
        }

    } failure:^(NSError *error) {

        [self addPlaceholderView];
    }];

}


//升级修改

- (void)goBcoinWeb:(NSString *)var{
    
    NSString *urlStr = [var stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}



//

//- (void)goBcoinWeb:(NSString *)var{
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/m-help/id1436959010?mt=8"]];
//    [[UIApplication sharedApplication]openURL:url];
//}




- (void)setRootVC {
    
    //检查更新过后再
//    BuildWalletMineVC * mineVC = [[BuildWalletMineVC alloc] init];
    
    TLTabBarController *tabBarCtrl = [[TLTabBarController alloc] init];
    if( ![TLUser user].isLogin) {
        
        TLUserLoginVC *loginVC = [TLUserLoginVC new];
        
        loginVC.loginSuccess = ^{
            
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;

            

        };
        CoinWeakSelf;
        loginVC.NeedLogin = YES;
        loginVC.loginFailed = ^{
            [weakSelf setRootVC];

        };

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//        [self.navigationController pushViewController:loginVC animated:YES];
//        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    ZLGestureLockViewController *vc = [ZLGestureLockViewController new];
    vc.isCheck = YES;
    
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
    BOOL isLanch  = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *word = [ZLGestureLockViewController gesturesPassword];
    if (word.length >0) {
        [self presentViewController:na animated:YES completion:nil];
        vc.CheckSucessBlock = ^{
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;

        };
    }else{
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;

    }
    
    


}



@end
