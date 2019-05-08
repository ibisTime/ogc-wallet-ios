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

+(NSArray *)FMDBqueryMnemonics
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"ChengWallet.db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
  
    NSString *wallet;
    NSArray *arr;
//    NSError *err = nil;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:picArroptions:NSJSONWritingPrettyPrinted error:&err];
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonDataencoding:NSUTF8StringEncoding];

    
    if ([dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from ChengWallet where userid like '%@'",[TLUser user].userId];
        FMResultSet *set = [dataBase executeQuery:sql];
        while ([set next])
        {
            wallet = [set stringForColumn:@"wallet"];
//            NSString *str  = [set stringForColumn:@"IMGURL"];
            
            //第三方包jsonKit转换
            
            arr = [[CustomFMDB alloc] stringToJSON:wallet];
        }
        [set close];
    }
    [dataBase close];
    
    
//    NSArray *arr =[wallet componentsSeparatedByString:@","];
    return arr;
}

- (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments |
                  NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (tmp)
        {
            if ([tmp isKindOfClass:[NSArray class]])
            {
                return tmp;
            } else if([tmp isKindOfClass:[NSString class]] || [tmp isKindOfClass:[NSDictionary class]])
            {
                return [NSArray arrayWithObject:tmp];
            } else
            {
                return nil;
            }
        } else
        {
            return nil;
        }
    } else {
        return nil;
    }
}


//NSArray *array = [str componentsSeparatedByString:@","];--分隔符

//NSString *str = [array componentsJoinedByString:@","];--分隔符


@end
