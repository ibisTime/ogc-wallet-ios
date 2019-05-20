//
//  TheGameCollCell.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/3.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "TheGameCollCell.h"

@implementation TheGameCollCell
{
    UIImageView *gameImg;
    UILabel *nameLbl;
    UILabel *IntroductionLabel;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 30)/2, 75)];
        
        backView.layer.cornerRadius=10;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        
        [backView theme_setBackgroundColorIdentifier:TabbarColor moduleName:ColorName];
        [self addSubview:backView];
        
        gameImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17.5,40,40)];
        gameImg.image = kImage(@"起始业背景");
        kViewRadius(gameImg, 4);
        [self addSubview:gameImg];
        
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(gameImg.xx + 11 , 12.5, (SCREEN_WIDTH - 30)/2 - gameImg.xx - 21, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(16) textColor:kHexColor(@"#000000")];
        [self addSubview:nameLbl];
        
        IntroductionLabel = [UILabel labelWithFrame:CGRectMake(gameImg.xx + 11 , nameLbl.yy + 7, (SCREEN_WIDTH - 30)/2 - gameImg.xx - 11 - 10, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#acacac")];
        [IntroductionLabel theme_setTextIdentifier:GaryLabelColor moduleName:ColorName];
        [self addSubview:IntroductionLabel];
        
        
    }
    return self;
}

-(void)setGameModel:(FindTheGameModel *)GameModel
{
    IntroductionLabel.text = GameModel.desc;
    nameLbl.text = GameModel.name;
    if ([TLUser isBlankString:GameModel.desc] == YES) {
        nameLbl.frame = CGRectMake(gameImg.xx + 11 , 12.5, (SCREEN_WIDTH - 30)/2 - gameImg.xx - 21, 22.5 + 23);
    }else
    {
        nameLbl.frame = CGRectMake(gameImg.xx + 11 , 12.5, (SCREEN_WIDTH - 30)/2 - gameImg.xx - 21, 22.5);
    }
    [gameImg sd_setImageWithURL:[NSURL URLWithString:[GameModel.picList convertImageUrl]]];
    
//    UIImageView *image1 = [self viewWithTag:1000];
//    UIImageView *image2 = [self viewWithTag:1001];
//    UIImageView *image3 = [self viewWithTag:1002];
//    UIImageView *image4 = [self viewWithTag:1003];
//    UIImageView *image5 = [self viewWithTag:1004];
//
//    switch ([GameModel.grade integerValue]) {
//
//        case 1:
//        {
//            image1.image = kImage(@"多边形亮色");
//            image2.image = kImage(@"多边形灰色");
//            image3.image = kImage(@"多边形灰色");
//            image4.image = kImage(@"多边形灰色");
//            image5.image = kImage(@"多边形灰色");
//        }
//            break;
//        case 2:
//        {
//            image1.image = kImage(@"多边形亮色");
//            image2.image = kImage(@"多边形亮色");
//            image3.image = kImage(@"多边形灰色");
//            image4.image = kImage(@"多边形灰色");
//            image5.image = kImage(@"多边形灰色");
//        }
//            break;
//        case 3:
//        {
//            image1.image = kImage(@"多边形亮色");
//            image2.image = kImage(@"多边形亮色");
//            image3.image = kImage(@"多边形亮色");
//            image4.image = kImage(@"多边形灰色");
//            image5.image = kImage(@"多边形灰色");
//        }
//            break;
//        case 4:
//        {
//            image1.image = kImage(@"多边形亮色");
//            image2.image = kImage(@"多边形亮色");
//            image3.image = kImage(@"多边形亮色");
//            image4.image = kImage(@"多边形亮色");
//            image5.image = kImage(@"多边形灰色");
//        }
//            break;
//        case 5:
//        {
//            image1.image = kImage(@"多边形亮色");
//            image2.image = kImage(@"多边形亮色");
//            image3.image = kImage(@"多边形亮色");
//            image4.image = kImage(@"多边形亮色");
//            image5.image = kImage(@"多边形亮色");
//        }
//            break;
//
//        default:
//            break;
//    }
    
}

@end
