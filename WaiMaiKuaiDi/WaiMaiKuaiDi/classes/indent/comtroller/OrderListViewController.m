//
//  OrderListViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderListViewController.h"
#import "IndentCell.h"
#import "IndentMainModel.h"
#import "IndentHeadView.h"
#import "IndentDetailViewController.h"
#import "OrderServer.h"
#import "MeServer.h"

@interface OrderListViewController ()<UITableViewDelegate, UITableViewDataSource, IndentCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) IndentMainModel *mainModel;
@property (nonatomic, strong) IndentHeadView *headerView;
@property (nonatomic, assign) int page;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(kOrderList, nil);
    _page = 1;
    [self initData];
    [self initTableView];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    if (!_isFinish) {
        NSLog(@"%@ ",NSLocalizedString(kOnRoad, nil));
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:NSLocalizedString(kOnRoad, nil) titleColor:ButtonColor font:[UIFont systemFontOfSize:13] size:CGSizeMake(NSLocalizedString(kOnRoad, nil).length*13+5>100?100:NSLocalizedString(kOnRoad, nil).length*13+5, 44) target:self action:@selector(onRoad)];
    }
    
}

- (void)onRoad{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kIstakeoutAllGoods, nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kConfirm, nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [MeServer onTheWaySuccess:^(id result) {
            [self initData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:verifyAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)initTableView{
    _headerView = [[IndentHeadView alloc] initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, 49)];
    _headerView.title = _zip_code;
    [self.view addSubview:_headerView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 49+TopBarHeight+5, SCREEN_WIDTH, SCREEN_HEIGHT-49-64-5) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ThemeBgColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
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
 
    [OrderServer getOrderListUrlWithPage:_page keyword:_keywork zip_code:_zip_code state:_transmitModel.state start_time:_transmitModel.start_time end_time:_transmitModel.end_time pay_method:_transmitModel.pay_method order_id:_transmitModel.order_id cust_phone:_transmitModel.cust_phone Success:^(IndentMainModel *result) {
        _mainModel = result;
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

#pragma UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderInfoModel *infoModel = _dataArray[indexPath.row];

    return [IndentCell cellHeightWithModel:infoModel];
}

static NSString *IndentCellId = @"IndentCellId";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    OrderInfoModel *infoModel = _dataArray[indexPath.row];
    IndentCell *indentCell = [tableView cellForRowAtIndexPath:indexPath];
    if (!indentCell) {
        indentCell = [[IndentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IndentCellId];
    }
    indentCell.delegate = self;
    indentCell.infoModel = infoModel;
    cell = indentCell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderInfoModel *infoModel = _dataArray[indexPath.row];

    IndentDetailViewController *detail = [[IndentDetailViewController alloc] init];
    detail.order_id = infoModel.order_id;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)endButtonClickWithModel:(OrderInfoModel *)model{
    [OrderServer sentToWithOrderId:model.order_id Success:^(id result) {
        [self arlertShowWithText:NSLocalizedString(kOrderEnd, nil)];
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
