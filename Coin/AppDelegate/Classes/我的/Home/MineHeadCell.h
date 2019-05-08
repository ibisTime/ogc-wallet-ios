//
//  MineHeadCell.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/7.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MineHeadDelegate <NSObject>

-(void)MineHeadDelegateSelectBtn:(NSInteger)tag;
@end
@interface MineHeadCell : UITableViewCell

@property (nonatomic, assign) id <MineHeadDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
