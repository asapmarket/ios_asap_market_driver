//
//  HomeRunCodeVC.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import "HomeRunCodeVC.h"
#import "IndentHeadView.h"
#import "HomeServer.h"
#import "HomeRunCodeCell.h"
#import "RunOrderDetailVC.h"

@interface HomeRunCodeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) IndentHeadView *headerView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) RunOrderParam *param;

@end

@implementation HomeRunCodeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _page = 1;
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kWaitOrder, nil);
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
    _param.state = @"0";
   
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
    return [HomeRunCodeCell cellHeightWithModel:item];
}

static NSString *IndentCellId = @"RunOrderCellId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeRunCodeItem *item = _dataArray[indexPath.row];
    HomeRunCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:IndentCellId];
    if (cell == nil) {
        cell = [[HomeRunCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IndentCellId];
    }
    [cell setItem:item];
    
    __weak typeof(self) WeakSelf = self;
    cell.grabButtonBlock = ^(HomeRunCodeItem *item) {
        RunOrderDetailParam *takeParam = [[RunOrderDetailParam alloc] init];
        takeParam.order_id = item.order_id;
        [HomeServer postTakeRunOrderWithParam:takeParam Success:^(id result) {
            [WeakSelf arlertShowWithText:NSLocalizedString(kTakeOrderSuccess, nil)];
            [WeakSelf initData];
        } failure:^(NSError *error) {
            [WeakSelf errorResponsText:error];
        }];
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
