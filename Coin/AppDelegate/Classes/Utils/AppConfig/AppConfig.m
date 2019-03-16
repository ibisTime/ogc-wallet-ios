//
//  AppConfig.m
//  YS_iOS
//
//  Created by 蔡卓越 on 2017/5/11.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "AppConfig.h"

void TLLog(NSString *format, ...) {
    
    if ([AppConfig config].runEnv != RunEnvRelease) {
        
        va_list argptr;
        va_start(argptr, format);
        NSLogv(format, argptr);
        va_end(argptr);
    }
    
}

@implementation AppConfig

+ (instancetype)config {
    
    static dispatch_once_t onceToken;
    static AppConfig *config;
    dispatch_once(&onceToken, ^{
        
        config = [[AppConfig alloc] init];
        config.isUploadCheck = NO;
        
    });
    
    return config;
}

- (void)setRunEnv:(RunEnv)runEnv {
    
    _runEnv = runEnv;
    
    self.companyCode = @"CD-OGC000021";
    self.systemCode = @"CD-OGC000021";
    self.qiniuDomain = [[NSUserDefaults standardUserDefaults]objectForKey:Get_Seven_Cattle_Address];
    switch (_runEnv) {
            
        case RunEnvTest: {
            
            self.addr = @"http://120.26.6.213:6801";
            self.ethHash = @"https://rinkeby.etherscan.io/tx";
            self.wanHash = @"http://47.104.61.26/block/trans";
            self.btcHash = @"https://testnet.blockchain.info";
        }break;
            
        case RunEnvDev: {
//            self.qiniuDomain = @"http://pajvine9a.bkt.clouddn.com";
            
//            self.addr = @"http://120.26.6.213:5801";
//金米
            self.addr = @"http://3.1.207.21:2801";
            self.ethHash = @"https://rinkeby.etherscan.io/tx";
            self.wanHash = @"http://47.104.61.26/block/trans";
            self.btcHash = @"https://testnet.blockchain.info/";

            self.ethAddress = @"";
            self.wanAddress = @"";
        }break;
            
        case RunEnvRelease: {
            
            self.addr = @"https://moorebit.io/api";
            self.ethHash = @"https://etherscan.io/tx";
            self.wanHash = @"https://www.wanscan.org/tx";
            self.btcHash = @"https://www.blockchain.com/btc/";

        } break;
            
    }
    
}

- (NSString *)apiUrl {
    
    if ([self.addr hasSuffix:@"api"]) {
        
        return self.addr;
        
    }
    
    return [self.addr stringByAppendingString:@"/forward-service/api"];
}

//- (NSString *)ipUrl {
//
//    return [self.addr stringByAppendingString:@"/forward-service/ip"];
//
//}

- (NSString *)getUrl {

    return [self.addr stringByAppendingString:@"/forward-service/api"];
}

- (NSString *)wxKey {
    
    return @"wx368e6044b7436dff";
}

@end
