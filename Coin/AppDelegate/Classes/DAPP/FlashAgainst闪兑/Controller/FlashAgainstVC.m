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
@interface FlashAgainstVC ()<RefreshDelegate>

@property (nonatomic , strong)FlashAgainstTableView *tableView;

@property (nonatomic , strong)FlashAgainstHeaderView *headView;

@property (nonatomic , strong)NSMutableArray <FlashAgainstModel *>*models;

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
    
    http.parameters[@"valueCnyIn"] = self.headView.OutPrice;
    http.parameters[@"valueCnyOut"] = self.headView.InPrice;
    
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"兑换成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self.navigationController popViewControllerAnimated:YES];
            NSNotification *notification =[NSNotification notificationWithName:@"FlashAgain" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        });
        
    } failure:^(NSError *error) {
        
    }];
}



-(void)chooseBtnClick
{
    if ([self.symbol isEqualToString:@"ET"]) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < self.models.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@ 兑 %@",self.models[i].symbolOut,self.models[i].symbolIn]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];
            self.headView.model = self.models[model.sid];
            [self loadDataPrice:self.headView.model];
            self.headView.rightNumberTf.text = @"";
            self.headView.leftNumberTf.text = @"";
            self.headView.poundageLbl.text = @"";
            [self.tableView reloadData];
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleText.text = @"闪兑";
    self.navigationItem.titleView = self.titleText;
    [self initTableView];
    [self LoadData];
    [self queryCenterTotalAmount];
    
}

- (void)initTableView {
    self.tableView = [[FlashAgainstTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.tableView theme_setBackgroundColorIdentifier:@"headerViewColor" moduleName:ColorName];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}


//交易对列表查询
-(void)LoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"802912";

    [http postWithSuccess:^(id responseObject) {
        
        self.models = [FlashAgainstModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if ([self.symbol isEqualToString:@"ET"]) {
            for (int i = 0 ; i < self.models.count; i ++) {
                if ([self.models[i].symbolIn isEqualToString:self.symbol]) {
                    self.headView.model = self.models[i];
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
        NSString *sellerPrice = responseObject[@"data"][@"sellerPrice"];
        self.headView.OutPrice = sellerPrice;

    } failure:^(NSError *error) {
    }];
    

    TLNetworking *OutHttp = [[TLNetworking alloc] init];
    OutHttp.code = @"650201";
    OutHttp.parameters[@"type"] = @"0";
    OutHttp.parameters[@"symbol"] = model.symbolOut;
    [OutHttp postWithSuccess:^(id responseObject) {
        NSString *buyPrice = responseObject[@"data"][@"buyPrice"];
        self.headView.InPrice = buyPrice;

        
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
