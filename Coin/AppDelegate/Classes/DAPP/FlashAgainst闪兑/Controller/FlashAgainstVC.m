//
//  FlashAgainstVC.m
//  Coin
//
//  Created by 郑勤宝 on 2019/5/13.
//  Copyright © 2019 chengdai. All rights reserved.
//

#import "FlashAgainstVC.h"
#import "FlashAgainstHeaderView.h"
#import "FlashAgainstTableView.h"
#import "FlashAgainstModel.h"
#import "SelectedListModel.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
#import "FlashAgainstModel.h"
@interface FlashAgainstVC ()<RefreshDelegate>

@property (nonatomic , strong)FlashAgainstTableView *tableView;

@property (nonatomic , strong)FlashAgainstHeaderView *headView;

@property (nonatomic , strong)NSMutableArray <FlashAgainstModel *>*models;

@property (nonatomic , strong)NSMutableArray <FlashAgainstModel *>*addmModels;

@property (nonatomic , strong)NSMutableArray <FlashAgainstModel *>*recordModels;

@end

@implementation FlashAgainstVC

-(FlashAgainstHeaderView *)headView
{
    if (!_headView) {
        _headView = [[FlashAgainstHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 402)];
        [_headView theme_setBackgroundColorIdentifier:BackColor moduleName:ColorName];
        [_headView.exchangeBtn addTarget:self action:@selector(exchangeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_headView.chooseBtn addTarget:self action:@selector(chooseBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headView;
}

-(void)exchangeBtnClick
{
    
    if ([self.headView.leftNumberTf.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入兑换数量"];
        return;
    }
    if ([self.headView.rightNumberTf.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入收到数量"];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"802920";
    http.showView = self.view;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"symbolIn"] = self.headView.model.symbolIn;
    http.parameters[@"symbolOut"] = self.headView.model.symbolOut;
    
    NSString *inPic =  [CoinUtil convertToSysCoin:self.headView.rightNumberTf.text coin:self.headView.model.symbolIn];
    NSString *outPic =  [CoinUtil convertToSysCoin:self.headView.leftNumberTf.text coin:self.headView.model.symbolOut];
    
    http.parameters[@"countIn"] = inPic;
    http.parameters[@"countOutTotal"] = outPic;
    
    http.parameters[@"valueCnyIn"] = @(self.headView.InPrice);
    http.parameters[@"valueCnyOut"] = @(self.headView.OutPrice);
    
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"兑换成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.headView.leftNumberTf.text = @"";
            self.headView.rightNumberTf.text = @"";
            self.headView.poundageLbl.text = @"手续费：0";
            
            [self RecordLoadData];
            
//            [self.navigationController popViewControllerAnimated:YES];
            NSNotification *notification =[NSNotification notificationWithName:@"FlashAgain" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        });
        
    } failure:^(NSError *error) {
        
    }];
}



-(void)chooseBtnClick
{
//    if ([self.symbol isEqualToString:@"H"]) {
//        return;
//    }
    NSMutableArray *array = [NSMutableArray array];
    
    
    
    if ([self.symbol isEqualToString:@"H"]) {
        for (int i = 0;  i < self.addmModels.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@ 兑 %@",self.addmModels[i].symbolOut,self.addmModels[i].symbolIn]]];
        }
    }else
    {
        for (int i = 0;  i < self.models.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@ 兑 %@",self.models[i].symbolOut,self.models[i].symbolIn]]];
        }
        
    }
    
    
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];
            if ([self.symbol isEqualToString:@"H"]) {
                self.headView.model = self.addmModels[model.sid];
                [self loadDataPrice:self.headView.model];
            }else
            {
                self.headView.model = self.models[model.sid];
                [self loadDataPrice:self.headView.model];
            }
            
            
            self.headView.rightNumberTf.text = @"";
            self.headView.leftNumberTf.text = @"";
            self.headView.poundageLbl.text = @"";
            [self.tableView reloadData];
        }];
    };
    if ([[USERDEFAULTS objectForKey:COLOR] isEqualToString:BLACK]) {
        [LEEAlert alert].config
        .LeeHeaderColor(kHexColor(@"52565D"))
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    }else
    {
        [LEEAlert alert].config
        .LeeHeaderColor(kHexColor(@"#ffffff"))
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = @"闪兑";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
//    [self LoadData];
//    [self queryCenterTotalAmount];
    [self RecordLoadData];
    [self LoadData];
    [self.view addSubview:self.headView];
    
}

- (void)initTableView {
    self.tableView = [[FlashAgainstTableView alloc] initWithFrame:CGRectMake(0, 402, kScreenWidth, kScreenHeight - kNavigationBarHeight - 402) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.tableView theme_setBackgroundColorIdentifier:@"headerViewColor" moduleName:ColorName];
    [self.view addSubview:self.tableView];
}

-(void)RecordLoadData
{
    CoinWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"802930";
    helper.parameters[@"userId"] = [TLUser user].userId;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[FlashAgainstModel class]];
    
    [self.tableView addRefreshAction:^{
       
        
        [weakSelf queryCenterTotalAmount];
        
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            
            weakSelf.recordModels = objs;
            weakSelf.tableView.recordModels = objs;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            if (weakSelf.tl_placeholderView.superview != nil) {
                
                [weakSelf removePlaceholderView];
            }
            weakSelf.recordModels = objs;
            
            weakSelf.tableView.recordModels = objs;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}

//交易对列表查询
-(void)LoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"802912";

    [http postWithSuccess:^(id responseObject) {
        
        self.models = [FlashAgainstModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if ([self.symbol isEqualToString:@"H"]) {
            self.addmModels = [NSMutableArray array];
            for (int i = 0 ; i < self.models.count; i ++) {
                if ([self.models[i].symbolIn isEqualToString:self.symbol]) {
                    
                    
                    [self.addmModels addObject:self.models[i]];
                    self.headView.model = self.addmModels[0];
                    [self loadDataPrice:self.headView.model];
                }
                
            }
        }else
        {
            if (self.models.count > 0) {
                self.headView.model = self.models[0];
                [self loadDataPrice:self.headView.model];
            }
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self.tableView endRefreshHeader];
    }];
}







//   个人钱包余额查询
- (void)queryCenterTotalAmount
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"802303";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
//        self.headView.dataDic = responseObject[@"data"];
        self.headView.currenctModel = [CurrencyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

//买入价   卖出价
-(void)loadDataPrice:(FlashAgainstModel *)model
{
    TLNetworking *InHttp = [[TLNetworking alloc] init];
    InHttp.code = @"650201";
    InHttp.parameters[@"type"] = @"0";
    InHttp.parameters[@"symbol"] = model.symbolIn;
    [InHttp postWithSuccess:^(id responseObject) {
//        NSString *sellerPrice = responseObject[@"data"][@"buyPrice"];
        self.headView.InPrice = [responseObject[@"data"][@"buyPrice"] floatValue];
    } failure:^(NSError *error) {
        
    }];
    

    TLNetworking *OutHttp = [[TLNetworking alloc] init];
    OutHttp.code = @"650201";
    OutHttp.parameters[@"type"] = @"0";
    OutHttp.parameters[@"symbol"] = model.symbolOut;
    [OutHttp postWithSuccess:^(id responseObject) {
//        NSString *buyPrice = ;
        self.headView.OutPrice = [responseObject[@"data"][@"sellerPrice"] floatValue];

        
    } failure:^(NSError *error) {
        
    }];
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
