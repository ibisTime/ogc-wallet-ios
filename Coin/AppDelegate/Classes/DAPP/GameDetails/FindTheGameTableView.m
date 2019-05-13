
#import "FindTheGameTableView.h"
#import "FindTheGameHeadCell.h"
#import "GameIntroducedCell.h"
#import "StrategyCell.h"
@interface FindTheGameTableView()<UITableViewDelegate, UITableViewDataSource,GameIntroducedCellDelegate>
{
    GameIntroducedCell *_cell;
    NSInteger select;
}

@end

@implementation FindTheGameTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;

        
        [self registerClass:[FindTheGameHeadCell class] forCellReuseIdentifier:@"FindTheGameHeadCell"];
        [self registerClass:[GameIntroducedCell class] forCellReuseIdentifier:@"GameIntroducedCell"];
        [self registerClass:[StrategyCell class] forCellReuseIdentifier:@"StrategyCell"];
//        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        selectBtn.tag = 400;
        select = 0;
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 1) {
        if (select == 0) {
            return 1;
        }else
        {
            return self.model.count;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        FindTheGameHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindTheGameHeadCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([TLUser isBlankString:self.GameModel.ID] == NO) {
            cell.GameModel = self.GameModel;
        }
        [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
        [cell.actionBtn addTarget:self action:@selector(actionBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }
    GameIntroducedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameIntroducedCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell = cell;
    [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
    _cell.delegate = self;
    if ([TLUser isBlankString:self.GameModel.ID] == NO) {
        cell.GameModel = self.GameModel;
    }
    
    return cell;
//    if (select == 0) {
//        GameIntroducedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameIntroducedCell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        _cell = cell;
//        [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
//        _cell.delegate = self;
//        if ([TLUser isBlankString:self.GameModel.ID] == NO) {
//            cell.GameModel = self.GameModel;
//        }
//
//        return cell;
//    }else
//    {
//        StrategyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StrategyCell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.model = self.model[indexPath.row];
//        [cell theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
//        return cell;
//    }
}

-(void)actionBtnClick:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:0];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 114;
    }
    return _cell.scrollView.yy + 50;
    
}

-(void)GameIntroducedCellClick
{
    [self reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (select == 1) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
            [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 25;
    }
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

-(void)headBtnClick:(UIButton *)sender
{
    select = sender.tag - 400;
    [self reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [backView theme_setBackgroundColorIdentifier:HeaderColor moduleName:ColorName];
        [footView addSubview:backView];
        
        UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 15)];
        [backView1 theme_setBackgroundColorIdentifier:WhiteBlackColor moduleName:ColorName];
        [footView addSubview:backView1];
        
        
        return footView;
    }
    return [UIView new];
}

@end
