//
//  DropletModelProtocolView.h
//  Coin
//
//  Created by 郑勤宝 on 2019/5/27.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DropletModelProtocolView : UIView<UIWebViewDelegate>
@property (nonatomic , copy)NSString *contact;
@property (nonatomic , strong)UIButton *cancelBtn;
@end

NS_ASSUME_NONNULL_END
