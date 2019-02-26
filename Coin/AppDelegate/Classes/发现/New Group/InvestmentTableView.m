//
//  InvestmentTableView.m
//  Coin
//
//  Created by 郑勤宝 on 2019/1/2.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "InvestmentTableView.h"
//V
#import "InvestmentHeadCell.h"
#define InvestmentHead @"InvestmentHeadCell"
#import "InvestmentBuyCell.h"
#define InvestmentBuy @"InvestmentBuyCell"
#import "PayWayCell.h"
#define PayWay @"PayWayCell"
//#import "AccountMoneyCellTableViewCell.h"
@interface InvestmentTableView()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *selectBtn;
    UIView *lineView;
    
    NSInteger selectTag;
    
}

@end

@implementation InvestmentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InvestmentHeadCell class] forCellReuseIdentifier:InvestmentHead];
        [self registerClass:[InvestmentBuyCell class] forCellReuseIdentifier:InvestmentBuy];
        [self registerClass:[PayWayCell class] forCellReuseIdentifier:PayWay];
        selectTag = 100;
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        InvestmentHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:InvestmentHead forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (self.models.count > 0) {
//            cell.models = self.models;
//        }
//        return cell;
//    }
    
    if (indexPath.section == 0) {
        InvestmentBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:InvestmentBuy forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_price != 0) {
            cell.price = _price;
        }
        
        cell.symbol = _symbol;
        cell.Rate = self.Rate;
        cell.balance = self.balance;
        return cell;
    }
    
    PayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:PayWay forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([TLUser isBlankString:self.biggestLimit] == NO) {
        cell.biggestLimit = self.biggestLimit;
        cell.smallLimit = self.smallLimit;
    }
    if (_indexBtnTag == 0)
    {
        cell.nameLabel.text = [LangSwitcher switchLang:@"支付方式" key:nil];
        cell.payWayDic = self.payWayDic;
        [cell.payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }else
    {
        cell.nameLabel.text = [LangSwitcher switchLang:@"收款方式" key:nil];
        if ([TLUser isBlankString:self.bankModel.bankcardNumber] == YES) {
            [cell.payBtn setTitle:@"请选择收款方式" forState:(UIControlStateNormal)];
        }
        else
        {
            NSString *number;
            if (self.bankModel.bankcardNumber.length > 4) {
                number = [self.bankModel.bankcardNumber substringFromIndex:self.bankModel.bankcardNumber.length - 4];
            }else
            {
                number = self.bankModel.bankcardNumber;
            }
            if ([self.bankModel.bankName isEqualToString:@"支付宝"]) {
                [cell.payBtn setTitle:[NSString stringWithFormat:@"%@%@%@",[LangSwitcher switchLang:@"支付宝" key:nil],[LangSwitcher switchLang:@"尾号为" key:nil],number] forState:(UIControlStateNormal)];
            }else
            {
                [cell.payBtn setTitle:[NSString stringWithFormat:@"%@%@%@",[LangSwitcher switchLang:@"银行卡" key:nil],[LangSwitcher switchLang:@"尾号为" key:nil],number] forState:(UIControlStateNormal)];
            }
            
        }
        
        [cell.payBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"") forState:(UIControlStateNormal)];
        }];
        [cell.payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

-(void)payBtnClick
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:10000];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        return 220;
//    }
    if (indexPath.section == 0) {
        return 176;
    }
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return 55;
    }
    if (section == 1) {
        return 10;
    }
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UIView *headView = [UIView new];
        
        NSArray *btnArray = @[@"买入",@"卖出"];
        for (int i = 0; i < 2; i ++) {
            UIButton *btn = [UIButton buttonWithTitle:btnArray[i] titleColor:kHexColor(@"#999999") backgroundColor:kWhiteColor titleFont:16];
            btn.frame = CGRectMake(i % 2 * SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2, 45);
           
            
            if (i == 0) {
                if (selectTag == 100) {
                    [btn setTitleColor:kHexColor(@"#4064E6") forState:(UIControlStateNormal)];
                }
                
            }
            
            if (i == 1) {
                if (selectTag == 101) {
                    [btn setTitleColor:kHexColor(@"#FA7D0E") forState:(UIControlStateNormal)];
                }
            }
            
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [headView addSubview:btn];
        }
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 1)];
        bottomLine.backgroundColor = kLineColor;
        [headView addSubview:bottomLine];
        
        lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2/2 - 20 + (selectTag - 100)*SCREEN_WIDTH/2, 55 - 3, 40, 3)];
        if (selectTag == 100) {
            lineView.backgroundColor = kHexColor(@"#4064E6");
        }else
        {
            lineView.backgroundColor = kHexColor(@"#FA7D0E");
        }
        kViewRadius(lineView, 1.5);
        [headView addSubview:lineView];
        return headView;
    }
    
    return [UIView new];
}

-(void)BtnClick:(UIButton *)sender
{
    
    selectTag = sender.tag;
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag - 100];
    [self reloadData];
    
//    if (sender.tag == 100) {
//        [sender setTitleColor:kHexColor(@"#FA7D0E") forState:(UIControlStateNormal)];
//    }
    
//    sender.selected = !sender.selected;
//    selectBtn.selected = !selectBtn.selected;
//    selectBtn = sender;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
