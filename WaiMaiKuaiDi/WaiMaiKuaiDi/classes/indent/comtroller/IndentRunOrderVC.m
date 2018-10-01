//
//  IndentRunOrderVC.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import "IndentRunOrderVC.h"
#import "IndentHeadView.h"
#import "HomeServer.h"
#import "IndentRunOderCell.h"
#import "RunOrderDetailVC.h"
#import "RunFBPriceView.h"
#import "OrderServer.h"

@interface IndentRunOrderVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) IndentHeadView *headerView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) RunOrderParam *param;

@end

@implementation IndentRunOrderVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _page = 1;
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kOrderList, nil);
    [self initTableView];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
}

- (void)headerRefreshing{
    [self.tableView headerEndRefreshing];
    _page = 1;
    [self initData];
}

- (void)footerRefreshing{
    [self.tableView footerEndRefreshing];
    
    _page ++;
    [self initData];
}

- (void)initData{
    _param = [[RunOrderParam alloc] init];
    _param.zip_code = _zip_code;
    _param.page = _page;
    _param.state = _state;
    UserInfo *userIndo = [UserInfoTool loadLoginAccount];
    _param.exp_id = userIndo.user_id;
    [HomeServer postHomeRunCodeListWithParam:_param Success:^(HomeRunCodeModel *result) {
        if (_page == 1) {
            _dataArray = result.rows;
        }else{
            [_dataArray addObjectsFromArray:result.rows];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
}

- (void)initTableView{
    _headerView = [[IndentHeadView alloc] initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, 49)];
    _headerView.title = _zip_code;
    [self.view addSubview:_headerView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 49+TopBarHeight+5, SCREEN_WIDTH, SCREEN_HEIGHT-49-TopBarHeight-5) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ThemeBgColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeRunCodeItem *item = _dataArray[indexPath.row];
    return [IndentRunOderCell cellHeightWithModel:item];
}

static NSString *IndentCellId = @"RunOrderCellId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeRunCodeItem *item = _dataArray[indexPath.row];
    IndentRunOderCell *cell = [tableView dequeueReusableCellWithIdentifier:IndentCellId];
    if (cell == nil) {
        cell = [[IndentRunOderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IndentCellId];
    }
    [cell setItem:item];
    
//    __weak typeof(self) WeakSelf = self;
    cell.grabButtonBlock = ^(HomeRunCodeItem *item) {
        RunUpdateOrderStateParam *stateParam = [[RunUpdateOrderStateParam alloc] init];
        stateParam.order_id = item.order_id;
        
        FeedBackPriceParam *priceParam = [[FeedBackPriceParam alloc] init];
        priceParam.order_id = item.order_id;
        
        if ([item.state isEqualToString:@"1"]) {
            RunFBPriceView *priceView = [[RunFBPriceView alloc] initWithFrame:self.view.bounds];
            [self.view.window addSubview:priceView];
            priceView.verityButtonBlock = ^(NSString *price) {
                if (price.length == 0) {
                    [self arlertShowWithText:NSLocalizedString(@"TotalPrice", nil)];
                    return;
                }
                priceParam.total_money = price;
                [OrderServer postFeedBackPriceWithParam:priceParam Success:^(id result) {
                    NSLog(@"=== %@",result);
                    [self initData];
                    [priceView removeFromSuperview];
                } failure:^(NSError *error) {
                    [self errorResponsText:error];
                    [priceView removeFromSuperview];
                }];
                
            };
        }else if ([item.state isEqualToString:@"3"]){
            stateParam.state = @"4";
            [HomeServer postUpdateRunOrderStateWithParam:stateParam Success:^(id result) {
                [self arlertShowWithText:NSLocalizedString(kOrderEnd, nil)];
                [self initData];
            } failure:^(NSError *error) {
                [self errorResponsText:error];
            }];
        }else if ([item.state isEqualToString:@"8"]){
            stateParam.state = @"3";
            [HomeServer postUpdateRunOrderStateWithParam:stateParam Success:^(id result) {
                [self arlertShowWithText:NSLocalizedString(kOrderEnd, nil)];
                [self initData];
            } failure:^(NSError *error) {
                [self errorResponsText:error];
            }];
        }
        
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeRunCodeItem *item = _dataArray[indexPath.row];
    RunOrderDetailVC *detailVC = [[RunOrderDetailVC alloc] init];
    detailVC.order_id = item.order_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
