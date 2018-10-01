//
//  IndentViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "IndentViewController.h"
#import "BaseMainModel.h"
#import "BaseViewCell.h"
#import "OrderSearchView.h"
#import "OrderListViewController.h"
#import "SearchViewController.h"
#import "OrderServer.h"
#import "TransmitModel.h"
#import "IndentManagerController.h"
#import "OrderSegmentView.h"
#import "HomeServer.h"
#import "IndentRunOrderVC.h"

@interface IndentViewController ()<UITableViewDelegate, UITableViewDataSource, OrderSearchViewDelegate>
@property (nonatomic, strong) OrderSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *indentArray;
@property (nonatomic, strong) BaseMainModel *mainModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) TransmitModel *transmitModel;

@property (nonatomic, strong) OrderSegmentView *segmentView;
@property (nonatomic, assign) NSInteger type; // 0:外卖订单  1：跑腿订单
@property (nonatomic, strong) RunOrderParam *param;
@property (nonatomic, strong) NSMutableArray *runArray;


@end

@implementation IndentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _page = 1;
    _transmitModel = [[TransmitModel alloc] init];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kUnfinished, nil);
    __weak typeof(self) WeakSelf = self;
    _type = 0;
    _param = [[RunOrderParam alloc] init];
    _segmentView = [[OrderSegmentView alloc] initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, 44)];
    _segmentView.oderButtonBlock = ^(UIButton *button) {
        
        if (WeakSelf.type == 0) {
            [WeakSelf.tableView reloadData];
            return ;
        }else{
            WeakSelf.type = 0;
            if (WeakSelf.indentArray.count > 0) {
                [WeakSelf.tableView reloadData];
            }else{
                [WeakSelf initData];
            }
        }
    };
    
    _segmentView.runButtonBlock = ^(UIButton *button) {
        if (WeakSelf.type == 1) {
            [WeakSelf.tableView reloadData];
            return ;
        }else{
            WeakSelf.type = 1;
            if (WeakSelf.runArray.count > 0) {
                [WeakSelf.tableView reloadData];
            }else{
                [WeakSelf initData];
            }
        }
    };
    [self.view addSubview:_segmentView];
    
    [self initTableView];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:NSLocalizedString(kOrderManager, nil) titleColor:ButtonColor font:[UIFont systemFontOfSize:13] size:CGSizeMake(NSLocalizedString(kOrderManager, nil).length*13+5>100?100:NSLocalizedString(kOrderManager, nil).length*13+5, 44) target:self action:@selector(orderManager)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
}

- (void)orderManager{
    IndentManagerController *indentManager = [[IndentManagerController alloc] init];
    [self.navigationController pushViewController:indentManager animated:YES];
}

//- (void)searchViewDid:(NSNotification *)nofi{
//    _transmitModel = [nofi object];
//    
//    [self initData];
//}

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
    
    if (_type == 0) {
        _transmitModel.state = @"6";
        [OrderServer getExpOrderCodeListWithPage:_page keyword:_searchView.searchTextField.text state:_transmitModel.state start_time:_transmitModel.start_time end_time:_transmitModel.end_time pay_method:_transmitModel.pay_method order_id:_transmitModel.order_id cust_phone:_transmitModel.cust_phone Success:^(BaseMainModel *result) {
            _mainModel = result;
            if (_page == 1) {
                _indentArray = _mainModel.rows;
            }else{
                [_indentArray addObjectsFromArray:_mainModel.rows];
            }
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }else{
        UserInfo *userIndo = [UserInfoTool loadLoginAccount];
        _param.page = _page;
        _param.state = @"6";
        _param.cust_phone = _transmitModel.cust_phone;
        _param.exp_id = userIndo.user_id;
        [HomeServer postHomeRunOrderListWithParam:_param Success:^(BaseMainModel *result) {
            if (_page == 1) {
                _runArray = result.rows;
            }else{
                [_runArray addObjectsFromArray:result.rows];
            }
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }
   
}

- (void)initTableView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopBarHeight+44, SCREEN_WIDTH, 1)];
    view.backgroundColor = [UIColor hexStringToColor:@"#f5f5f5"];
    [self.view addSubview:view];
    _searchView = [[OrderSearchView alloc] initWithFrame:CGRectMake(0, TopBarHeight+45, SCREEN_WIDTH, 49)];
    _searchView.backgroundColor = [UIColor whiteColor];
    _searchView.delegate = self;
    [self.view addSubview:_searchView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 49+45+TopBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-TopBarHeight-49-44-45) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ThemeBgColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}


#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_type == 0) {
        return _indentArray.count;
    }else{
        return _runArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type==0) {
        BaseModel *model = _indentArray[indexPath.section];
        BaseViewCell *cell = [BaseViewCell cellWithTableView:tableView];
        [cell setModel:model];
        return cell;
    }else{
        BaseModel *model = _runArray[indexPath.section];
        BaseViewCell *cell = [BaseViewCell cellWithTableView:tableView];
        [cell setModel:model];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 0) {
        BaseModel *model = _indentArray[indexPath.section];
        OrderListViewController *orderListCtrl = [[OrderListViewController alloc] init];
        orderListCtrl.transmitModel = _transmitModel;
        orderListCtrl.zip_code = model.zip_code;
        orderListCtrl.keywork = _searchView.searchTextField.text;
        orderListCtrl.isFinish = NO;
        [self.navigationController pushViewController:orderListCtrl animated:YES];
    }else{
        BaseModel *model = _runArray[indexPath.section];
        IndentRunOrderVC *runOrderVC = [[IndentRunOrderVC alloc] init];
        runOrderVC.zip_code = model.zip_code;
        runOrderVC.state = @"6";
        [self.navigationController pushViewController:runOrderVC animated:YES];
    }
    
}

#pragma SearchViewDelegate
- (void)returnButtonClick:(NSString *)text{
    _transmitModel.cust_phone = text;
    [self initData];
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