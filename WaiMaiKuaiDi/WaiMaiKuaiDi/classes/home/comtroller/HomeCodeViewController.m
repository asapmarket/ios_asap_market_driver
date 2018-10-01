//
//  HomeCodeViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/16.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomeCodeViewController.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "IndentHeadView.h"
#import "HomeServer.h"
#import "TakeOrderDetailViewController.h"

@interface HomeCodeViewController ()<UITableViewDelegate, UITableViewDataSource, HomeCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HomeModel *mainModel;
@property (nonatomic, strong) IndentHeadView *headerView;
@property (nonatomic, assign) int page;
@end

@implementation HomeCodeViewController

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
    [HomeServer getOrderListByZipCodeWithZipCode:_zip_code page:_page Success:^(HomeModel *result) {
        _mainModel = result;
        if (_page == 1) {
            _dataArray = _mainModel.rows;
        }else{
            [_dataArray addObjectsFromArray:_mainModel.rows];
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
    OrderInfoModel *model = _dataArray[indexPath.row];
    return [HomeCell cellHeightWithModel:model];
}

static NSString *IndentCellId = @"IndentCellId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderInfoModel *infoModel = _dataArray[indexPath.row];
    
    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IndentCellId];
    }
    cell.delegate = self;
    cell.infoModel = infoModel;
    [cell setStatus:_mainModel.onwork];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderInfoModel *infoModel = _dataArray[indexPath.row];
    TakeOrderDetailViewController *orderDetail = [[TakeOrderDetailViewController alloc] init];
    orderDetail.order_id = infoModel.order_id;
    orderDetail.onwork = _mainModel.onwork;
    [self.navigationController pushViewController:orderDetail animated:YES];
}

- (void)grapButtonClickWithModel:(OrderInfoModel *)infoModel{
        [HomeServer takeOrderWithOrderId:infoModel.order_id Success:^(id result) {
            [self arlertShowWithText:NSLocalizedString(kTakeOrderSuccess, nil)];
            [self initData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
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
