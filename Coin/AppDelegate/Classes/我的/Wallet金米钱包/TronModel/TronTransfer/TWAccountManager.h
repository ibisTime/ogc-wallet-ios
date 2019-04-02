//
//  TWAccountManager.h
//  TronWallet
//
//  Created by chunhui on 2018/5/23.
//  Copyright © 2018年 onesmile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tron.pbobjc.h"
@interface TWAccountManager : NSObject


-(void)saveAccount:(Account *)account;

-(Account *)account;

@end
