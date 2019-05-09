//
//  IconCollCell.h
//  Coin
//
//  Created by 郑勤宝 on 2018/11/30.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindTheGameModel.h"
@protocol IconCollDelegate <NSObject>

-(void)IconCollDelegateSelectBtn:(NSInteger)tag;


@end
@interface IconCollCell : UICollectionViewCell

@property (nonatomic, assign) id <IconCollDelegate> delegate;

@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)NSMutableArray <FindTheGameModel *>*dataArray;
@property (nonatomic , strong)UIButton *iconButton;
@property (nonatomic , strong)UIImageView *iconImage;
@property (nonatomic , strong)UILabel *nameLbl;

@end
