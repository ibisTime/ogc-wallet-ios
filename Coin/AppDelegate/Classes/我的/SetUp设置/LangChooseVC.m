//
//  LangChooseVC.m
//  Coin
//
//  Created by  tianlei on 2017/12/11.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "LangChooseVC.h"
#import "SettingModel.h"
#import <CDCommon/UIScrollView+TLAdd.h>
#import "TLTabBarController.h"
#import "LangSwitcher.h"
#import <ZendeskSDK/ZendeskSDK.h>
#import "NSBundle+Language.h"
//#import <ZendeskSDK/ZendeskSDK.h>
#import <ZendeskCoreSDK/ZendeskCoreSDK.h>
#import <ZendeskProviderSDK/ZendeskProviderSDK.h>
@interface LangChooseVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *langChooseTV;
@property (nonatomic, strong) NSMutableArray <SettingModel *>*models;
//@property (nonatomic, strong) UIImageView *bgImage;
//
//@property (nonatomic, strong) UIButton *backButton;
//
//@property (nonatomic, strong) UILabel *nameLable;
@end

@implementation LangChooseVC

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

    self.titleText.text = [LangSwitcher switchLang:@"语言" key:nil];
    self.navigationItem.titleView = self.titleText;

    
    __weak typeof(self) weakself = self;
    self.models = [[NSMutableArray alloc] init];
    
    SettingModel *simpleModel = [[SettingModel alloc] init];
    simpleModel.text = @"简体中文";
    
    simpleModel.isSelect = [LangSwitcher currentLangType] == LangTypeSimple;
    [simpleModel setAction:^{
        
        [weakself langType:LangTypeSimple];
    }];
    
    
    SettingModel *EnglishModel = [[SettingModel alloc] init];
    //    EnglishModel.text = [LangSwitcher switchLang:@"英文" key:nil];
    EnglishModel.text = @"English";
    
    EnglishModel.isSelect = [LangSwitcher currentLangType] == LangTypeEnglish;
    [EnglishModel setAction:^{
        
        [weakself langType:LangTypeEnglish];
        
    }];
//    SettingModel *KorenModel = [[SettingModel alloc] init];
//    KorenModel.text = @"한국어";
//
//    KorenModel.isSelect = [LangSwitcher currentLangType] == LangTypeKorean;
//    [KorenModel setAction:^{
//
//        [weakself langType:LangTypeKorean];
//
//    }];
    
    [self.models addObjectsFromArray:@[simpleModel,EnglishModel]];
    
    
    self.langChooseTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStylePlain];
    
    self.langChooseTV.rowHeight = 55;

    self.langChooseTV.delegate = self;
    self.langChooseTV.dataSource = self;
    self.langChooseTV.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.langChooseTV adjustsContentInsets];
    
    [self.view addSubview:self.langChooseTV];
    
}

- (void)langType:(LangType)type {
    
        [TLAlert alertWithTitle:[LangSwitcher switchLang:@"切换语言" key:nil]
                            msg:nil
                     confirmMsg:[LangSwitcher switchLang:@"确定" key:nil]
                      cancleMsg:[LangSwitcher switchLang:@"取消" key:nil]
                         cancle:^(UIAlertAction *action) {
    
                         } confirm:^(UIAlertAction *action) {

                             [ZDKZendesk initializeWithAppId: @"572a044301abb3cec5bc7efba47802dc225375622ee399eb"
                                                    clientId: @"mobile_sdk_client_1315e07d5bbe64e76b61"
                                                  zendeskUrl: @"JMQBWALLEThelp.zendesk.com"];
                             id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:nil email:nil];
                             [[ZDKZendesk instance] setIdentity:userIdentity];
                             
                             [ZDKSupport initializeWithZendesk: [ZDKZendesk instance]];
                             NSString *lan;
                             if (type == LangTypeSimple || type == LangTypeTraditional) {
                                 lan = @"zh-cn";
                             }else if (type == LangTypeKorean)
                             {
                                 lan = @"ko";
                             }
                             else
                             {
                                 lan = @"en-us";
                             }
                             
//                             [NSBundle setLanguage:lan];
                             [ZDKSupport instance].helpCenterLocaleOverride = lan;


                             [[NSUserDefaults standardUserDefaults] setValue:@[lan] forKey:@"AppleLanguages"];

                             [[NSUserDefaults standardUserDefaults] synchronize];


                             
                             
                             
                             [LangSwitcher changLangType:type];
                             [LangSwitcher startWithTraditional];

                             //                             UIView *v = nil;
                             if (type == LangTypeKorean) {
                                 [LangSwitcher startWithTraditional];
                                 TLUpdateVC *tabBarCtrl = [[TLUpdateVC alloc] init];
                                 [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;
                                 return ;
                             }
                             TLUpdateVC *tabBarCtrl = [[TLUpdateVC alloc] init];
                      [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;

                         }];
    
}



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
//    if (indexPath.row != 0) {
//        UILabel *beat = [UILabel labelWithBackgroundColor:kAppCustomMainColor textColor:kWhiteColor font:12];
//
//        [cell addSubview:beat];
//        beat.text = @"Beta";
//
//        [beat mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(cell.mas_top).offset(20);
//
//            make.left.equalTo(cell.mas_left).offset(70);
//        }];
//    }
   
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
