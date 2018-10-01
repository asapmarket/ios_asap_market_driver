//
//  HomeViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseMainModel.h"
#import "BaseViewCell.h"
#import "HomeCodeViewController.h"
#import "MapTakeOrderViewController.h"
#import "HomeServer.h"
#import "AFNetworkReachabilityManager.h"

#import "OrderSegmentView.h"
#import "HomeRunCodeVC.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *indentArray;
@property (nonatomic, strong) BaseMainModel *mainModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, strong) NSMutableArray *runArray;

@property (nonatomic, strong) BaseMainModel *runModel;

@property (nonatomic, strong) OrderSegmentView *segmentView;

@property (nonatomic, assign) NSInteger type; // 0:外卖订单  1：跑腿订单

@property (nonatomic, strong) RunOrderParam *param;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isLogin];
}

- (void)network{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == (AFNetworkReachabilityStatusNotReachable | AFNetworkReachabilityStatusUnknown))
        {
            UIButton *loadingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            loadingBtn.frame = CGRectMake((SCREEN_WIDTH-100)/2.0, (SCREEN_HEIGHT-50)/2.0, 100, 50);
            loadingBtn.backgroundColor = ThemeBgColor;
            [loadingBtn setTitle:NSLocalizedString(kLoading,nil) forState:UIControlStateNormal];
            [loadingBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
            loadingBtn.titleLabel.font = [UIFont systemFontOfSize:11];
            [loadingBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
            [loadingBtn verticalImageAndTitle:4];
            [loadingBtn addTarget:self action:@selector(loading:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:loadingBtn];
            
        }else{
            [LoginManager toLogin];
        }
    }];
}

- (void)loading:(UIButton *)btn{
    [btn removeFromSuperview];
    [self isLogin];
}

- (void)isLogin{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    if (userInfo == nil) {
        [self network];
    }else{
        [[MyRTLocation shareLocation] setSuccessBlock:^(double latitude, double longitude){
            [HomeServer uploadLocationWithLat:latitude lng:longitude Success:^(id result) {
                NSLog(@"%@",result);
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }];
        _page = 1;
        [self initData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedStringFromTable(kHomepage, nil, @"Localizable");
    _indentArray = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:NSLocalizedString(kMapRecieveOrder, nil) titleColor:ButtonColor font:[UIFont systemFontOfSize:13] size:CGSizeMake(NSLocalizedString(kMapRecieveOrder, nil).length*13+5>100?100:NSLocalizedString(kMapRecieveOrder, nil).length*13+5, 44) target:self action:@selector(mapOrderClick)];
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
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];

}

- (void)mapOrderClick{
    MapTakeOrderViewController *takeOrder = [[MapTakeOrderViewController alloc] init];
    [self.navigationController pushViewController:takeOrder animated:YES];
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
    if (_type == 0) {
        [HomeServer getHomePageInfoWithPage:_page Success:^(BaseMainModel *result) {
            [self.tableView headerEndRefreshing];
            _mainModel = result;
            if (_page == 1) {
                _indentArray = result.rows;
            }else{
                [_indentArray addObjectsFromArray:result.rows];
            }
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }else{
        _param.page = _page;
        _param.state = @"0";
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

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+TopBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-44-TopBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 0) {
        BaseModel *model = _indentArray[indexPath.section];
        HomeCodeViewController *codeCtrl = [[HomeCodeViewController alloc] init];
        codeCtrl.zip_code = model.zip_code;
        [self.navigationController pushViewController:codeCtrl animated:YES];
    }else{
        BaseModel *model = _runArray[indexPath.section];
        HomeRunCodeVC *runCodeVC = [[HomeRunCodeVC alloc] init];
        runCodeVC.zip_code = model.zip_code;
        [self.navigationController pushViewController:runCodeVC animated:YES];
    }
    
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
