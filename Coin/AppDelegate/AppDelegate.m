//
//  AppDelegate.m
//  Coin
//
//  Created by  tianlei on 2017/10/31.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "AppDelegate.h"
#import "TLUIHeader.h"
#import "TLTabBarController.h"
#import "TLUser.h"
#import "TLNetworking.h"
#import "UITabBar+Badge.h"
#import "AppConfig.h"

#import "IQKeyboardManager.h"

#import "ZMChineseConvert.h"
#import "SettingModel.h"
#import "TLUpdateVC.h"

#import "LangSwitcher.h"
#import "RespHandler.h"
#import <NBHTTP/NBNetwork.h>
#import "CoinModel.h"
#import "BuildWalletMineVC.h"
#import "TLTabBarController.h"
#import <FMDB/FMDB.h>
#import "TLDataBase.h"
#import "TLUserLoginVC.h"
#import "ZLGestureLockViewController.h"
#import <UMMobClick/MobClick.h>
//#import <ZendeskSDK/ZendeskSDK.h>
#import "GengXinModel.h"
#import "TLWXManager.h"
#import <UMMobClick/MobClick.h>

#import "WXApi.h"
#import "IQKeyboardManager.h"
//#import <ZendeskCoreSDK/ZendeskCoreSDK.h>
//#import <ZendeskProviderSDK/ZendeskProviderSDK.h>
#import <WeiboSDK.h>
#import "NSBundle+Language.h"

@interface AppDelegate ()<WeiboSDKDelegate>

@property (nonatomic, strong) RespHandler *respHandler;
@property (nonatomic ,assign) BOOL IsEnterBack;
@property (nonatomic, strong) NSMutableArray <DataBaseModel *>*dataBaseModels;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    研发
//    [AppConfig config].runEnv = RunEnvDev;
//    测试
//    [AppConfig config].runEnv = RunEnvTest;
//    正式
    [AppConfig config].runEnv = RunEnvRelease;
    NSLog(@"================= %@",NSHomeDirectory());
    [AppConfig config].isChecking = NO;
    self.respHandler = [[RespHandler alloc] init];
    [NBNetworkConfig config].respDelegate = self.respHandler;
    //2.新版本请求
    [NBNetworkConfig config].baseUrl = [AppConfig config].apiUrl;
    [self configUpdate];
    //    配置七牛地址
    [self GetSevenCattleAddress];
    //配置键盘
    [self configIQKeyboard];
//    配置语言   默认中文
    [LangSwitcher changLangType:LangTypeSimple];
    //    NSString *lang = [[NSUserDefaults standardUserDefaults] objectForKey:@"LANG"];
    //    if ([TLUser isBlankString:lang] == YES) {
    //        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    //        NSString *languageName = [appLanguages objectAtIndex:0];
    //
    //        if ([languageName hasPrefix:@"zh-Hans"]) {
    //            [LangSwitcher changLangType:LangTypeSimple];
    //        }
    //        else
    //        {
    //            [LangSwitcher changLangType:LangTypeEnglish];
    //        }
    //    }
//    [LangSwitcher startWithTraditional];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //配置根控制器
    [self configRootViewController];
    
    //退出登录消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginOut)
                                                 name:kUserLoginOutNotification
                                               object:nil];
        
        
    [[TLUser user] updateUserInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification
                                                            object:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    });
    return YES;
}

//#pragma mark - Config
- (void)configUpdate {
    
    //1:iOS 2:安卓
    TLNetworking *http = [[TLNetworking alloc] init];
    
    http.code = @"660918";
    http.parameters[@"type"] = @"ios-c";
    
    [http postWithSuccess:^(id responseObject) {
        
        GengXinModel *update = [GengXinModel mj_objectWithKeyValues:responseObject[@"data"]];
//        [self removePlaceholderView];
        //获取当前版本号
        NSString *currentVersion = [self version];
        
        
        if ([currentVersion integerValue] < [update.version integerValue]) {
            
            if ([update.forceUpdate isEqualToString:@"0"]) {
                
                //不强制
                [TLAlert alertWithTitle:[LangSwitcher switchLang:@"更新提示" key:nil] msg:update.note confirmMsg:[LangSwitcher switchLang:@"立即升级" key:nil] cancleMsg:[LangSwitcher switchLang:@"稍后提醒" key:nil] cancle:^(UIAlertAction *action) {
                    
                    
                    
//                    [self setRootVC];
                    
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
            
//            [self setRootVC];
            
        }
        
    } failure:^(NSError *error) {
        
//        [self addPlaceholderView];
    }];
    
}

- (void)goBcoinWeb:(NSString *)var{
 
 NSString *urlStr = [var stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
 NSURL *url = [NSURL URLWithString:urlStr];
 [[UIApplication sharedApplication] openURL:url];
 }

- (NSString *)version {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
}



//获取七牛地址
-(void)GetSevenCattleAddress
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630047";
    http.parameters[SYS_KEY] = @"qiniu_domain";
    [http postWithSuccess:^(id responseObject) {
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"http://%@", responseObject[@"data"][@"cvalue"]] forKey:Get_Seven_Cattle_Address];
        
        [AppConfig config].qiniuDomain = [NSString stringWithFormat:@"http://%@", responseObject[@"data"][@"cvalue"]];
        
    } failure:^(NSError *error) {
        
    }];
    
    [CoinUtil refreshOpenCoinList:^{
        
    } failure:^{
        
    }];
}

#pragma mark- 退出登录
- (void)loginOut {

    [[TLUser user] loginOut];
    
    
//    UITabBarController *tabbarContrl = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    if ([tabbarContrl isKindOfClass:[UINavigationController class]]) {
//        return;
//    }
//    if ([tabbarContrl isKindOfClass:[BuildWalletMineVC class]]) {
//        return;
//    }
    TLUpdateVC *tab = [[TLUpdateVC alloc] init];
    TLUserLoginVC *login = [TLUserLoginVC new];
    
//
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = na;

    login.loginSuccess = ^{
        self.window.rootViewController = tab;

    };
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}


- (UITabBarController *)rootTabBarController {
    
    id obj = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([obj isKindOfClass:[UITabBarController class]]) {
        
        TLUpdateVC *tabBarController = (TLUpdateVC *)obj;
        return tabBarController;
        
    } else {
        
        return nil;
    }

}


- (void)configWeChat
{
    [[TLWXManager manager] registerApp];
}

- (void)configIQKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES; // 控制点击背景是否收起键盘
//    manager.shouldToolbarUsesTextFieldTintColor =YES; // 控制键盘上的工具条文字颜色是否用户自定义
//    manager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    manager.toolbarManageBehaviour = IQAutoToolbarByTag;
}

- (void)configRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    if ([TLUser user].isLogin == NO) {
        TLUserLoginVC *updateVC = [[TLUserLoginVC alloc] init];
        TLNavigationController *na = [[TLNavigationController alloc] initWithRootViewController:updateVC];
        if ([TLUser user].checkLogin == NO) {
            
        }
        self.window.rootViewController = na;
    }else{
        TLUpdateVC *tabBarCtrl = [[TLUpdateVC alloc] init];
        self.window.rootViewController = tabBarCtrl;
    }
    
}

+ (id)sharedAppDelegate
{
    return [UIApplication  sharedApplication ].delegate;
}

#pragma mark- 本地推送
//- (void)configLocalPushNotification {
//
//    // 创建分类，注意使用可变子类
//    UIMutableUserNotificationCategory *category = [UIMutableUserNotificationCategory new];
//    // 设置标识符，注意与发送通知设置的category标识符一致~！
//    category.identifier = @"category";
//    // 设置按钮，注意使用可变子类UIMutableUserNotificationAction
//    // 设置前台按钮，点击后能使程序回到前台的叫做前台按钮
//    UIMutableUserNotificationAction *action1 = [UIMutableUserNotificationAction new];
//    action1.identifier = @"qiantai";
//    action1.activationMode = UIUserNotificationActivationModeForeground;
//    // 设置按钮的标题，即按钮显示的文字
//    action1.title = @"呵呵";
//
//    // 设置后台按钮，点击后程序还在后台执行，如QQ的消息
//    UIMutableUserNotificationAction *action2 = [UIMutableUserNotificationAction new];
//    action2.identifier = @"houtai";
//    action2.activationMode = UIUserNotificationActivationModeBackground;
//    // 设置按钮的标题，即按钮显示的文字
//    action1.title = @"后台呵呵";
//    // 给分类设置按钮
//    [category setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];
//
//    // 注册，请求授权的时候将分类设置给授权，注意是 NSSet 集合
//    NSSet *categorySet = [NSSet setWithObject:category];
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:categorySet];
//    // 注册通知
//    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//
//
//}


#pragma mark - 微信和芝麻认证回调
// iOS9 NS_AVAILABLE_IOS
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

        if ([url.host containsString:@"response"]) {
            [WeiboSDK handleOpenURL:url delegate:self];
            }
         else {
            
            return [WXApi handleOpenURL:url delegate:[TLWXManager manager]];
        }
        
        return YES;

}

#pragma mark- 应用进入前台，改变登录时间
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if([TLUser user].isLogin) {

      [[TLUser user] changLoginTime];

    }

    if ([TLUser user].isLogin == YES) {
        //验证手势密码
        
      NSString *pwd =  [ZLGestureLockViewController gesturesPassword];
        if (!pwd) {
            return;
        }
        ZLGestureLockViewController *vc = [ZLGestureLockViewController new];
        vc.isCheck = YES;
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
        BOOL isLanch  = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLanch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (isLanch == YES) {
            return;
        }
        [self.window.rootViewController presentViewController:na animated:YES completion:nil];
    }
}

#pragma mark- 应用切后台
- (void)applicationDidEnterBackground:(UIApplication *)application  {
    
    //
    self.IsEnterBack = YES;
    __block UIBackgroundTaskIdentifier bgTaskID;
    bgTaskID = [application beginBackgroundTaskWithExpirationHandler:^ {
        
        //不管有没有完成，结束background_task任务
        [application endBackgroundTask: bgTaskID];
        bgTaskID = UIBackgroundTaskInvalid;
    }];
    
    
}

#pragma mark- 应用切前台
- (void)applicationWillEnterForeground:(UIApplication *)application {

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSString *) dataFilePath//应用程序的沙盒路径
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [path objectAtIndex:0];
    return[document stringByAppendingPathComponent:@"THAWallet.sqlite"];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if(response.statusCode == WeiboSDKResponseStatusCodeSuccess){
//            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"分享成功" key:nil]];
        }else{
//            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"分享失败" key:nil]];

        }
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        
    }
    
}




@end
