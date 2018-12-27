//
//  AssetsHeadView.h
//  Coin
//
//  Created by 郑勤宝 on 2018/12/21.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AssetsHeadViewDelegate <NSObject>

-(void)AssetsHeadViewDelegateSelectBtn:(NSInteger)tag;
@end

@interface AssetsHeadView : UIView
@property (nonatomic, assign) id <AssetsHeadViewDelegate> delegate;
@property (nonatomic , strong)UIView *whiteView;
@property (nonatomic , strong)UIImageView *announcementImage;
@property (nonatomic , strong)UILabel *announcementLbl;
@property (nonatomic , strong)UIImageView *announcementDeleteBtn;

@property (nonatomic , strong)UILabel *allAssetsLabel;
@property (nonatomic , strong)UILabel *allAssetsPriceLabel;
@property (nonatomic , strong)UIButton *eyesBtn;



@property (nonatomic, strong) UIImageView *bgIV;
@property (nonatomic, strong) UIButton *accountNameBtn;
@property (nonatomic, strong) UILabel *priceLabel;


@property (nonatomic , copy)NSString *usdRate;
@property (nonatomic , strong)NSDictionary *dataDic;

@end
