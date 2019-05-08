//
//  SetUpTableView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "TLTableView.h"

@interface SetUpTableView : TLTableView
@property (nonatomic, copy) void (^ SwitchBlock) (NSInteger switchBlock);
@end
