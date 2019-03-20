//
//  CustomFMDB.m
//  Coin
//
//  Created by 郑勤宝 on 2019/3/20.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "CustomFMDB.h"

@implementation CustomFMDB

+(NSDictionary *)FMDBqueryUseridMnemonicsPwdWalletName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"ChengWallet.db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    NSString *userid = @"";
    NSString *mnemonics = @"";
    NSString *pwd = @"";
    NSString *walletName = @"";
    
    
    if ([dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from ChengWallet where userid like '%@'",[TLUser user].userId];
        FMResultSet *set = [dataBase executeQuery:sql];
        while ([set next])
        {
            userid = [set stringForColumn:@"userid"];
            mnemonics = [set stringForColumn:@"mnemonics"];
            pwd = [set stringForColumn:@"pwd"];
            walletName = [set stringForColumn:@"walletName"];
            
        }
        [set close];
    }
    [dataBase close];
    
    
    
    return @{@"userid":userid,
             @"mnemonics":mnemonics,
             @"pwd":pwd,
             @"walletName":walletName
             };
}

@end
