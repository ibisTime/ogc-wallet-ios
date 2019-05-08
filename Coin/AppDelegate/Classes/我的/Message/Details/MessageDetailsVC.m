//
//  MessageDetailsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MessageDetailsVC.h"

@interface MessageDetailsVC ()

@end

@implementation MessageDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"车贷详情";
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 33.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(24) textColor:kBlackColor];
    nameLbl.text = self.model.title;
    [self.view addSubview:nameLbl];
    
    UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, 64, 200, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
    timeLbl.text = [self.model.createDatetime convertToDetailDate];
    [self.view addSubview:timeLbl];
    
    UILabel *typeLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 165, 64, 150, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
    typeLbl.text = @"系统公告";
    [self.view addSubview:typeLbl];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 95, SCREEN_WIDTH - 30, 1)];
    lineView.backgroundColor = kLineColor;
    [self.view addSubview:lineView];
    
    UILabel *detailsLbl = [UILabel labelWithFrame:CGRectMake(15, 111, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 111 - kNavigationBarHeight) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
    detailsLbl.numberOfLines = 0;
    detailsLbl.text = @"车贷B端系统正式上线，赶紧去体验，如有问题请及时联系我们。";
    [detailsLbl sizeToFit];
    [self.view addSubview:detailsLbl];
    
    if ([self.model.content hasPrefix:@"<p>"]) {
        NSRange startRange = [self.model.content rangeOfString:@"<p>"];
        NSRange endRange = [self.model.content rangeOfString:@"</p>"];
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        NSString * con = [self.model.content substringWithRange:range];
        detailsLbl.text = con;
    }else
    {
        detailsLbl.text = self.model.content;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
