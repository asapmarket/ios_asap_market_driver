//
//  RunOrderDetailVC.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderDetailVC.h"
#import "GMapViewController.h"
#import "RunOrderDetailModel.h"
#import "DetailCell.h"
#import "RunOrderDetailCell.h"
#import "HomeServer.h"
#import "RunOrderDetailParam.h"
#import "RunFBPriceView.h"
#import "OrderServer.h"
#import "RunBigImageViewLook.h"
@import CoreLocation;
@import MapKit;

@interface RunOrderDetailVC ()<RunOrderDetailCellDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) RunOrderDetailModel *mainModel;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) RunOrderDetailParam *param;
@property (nonatomic, assign) BOOL bugSuc;

@end

@implementation RunOrderDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(kIndentDetail, nil);
    _titleArray = @[NSLocalizedString(kCodeNO, nil), NSLocalizedString(kOrderTime, nil), NSLocalizedString(kPayType, nil), NSLocalizedString(kIndentNo, nil), NSLocalizedString(kPhoneNo, nil), NSLocalizedString(kOrderType, nil)];
    [self initTableView];
    _bugSuc = NO;
}

- (void)initData{
    
    _param = [[RunOrderDetailParam alloc] init];
    _param.order_id = _order_id;
    
    [HomeServer postRunOrderDetailWithParam:_param Success:^(RunOrderDetailModel *result) {
        _mainModel = result;
        
        [self.tableView reloadData];
        _orderButton.hidden = NO;

        if ([_mainModel.numState isEqualToString:@"0"]) {
            _orderButton.backgroundColor = ButtonColor;
            _orderButton.userInteractionEnabled = YES;
        }else if ([_mainModel.numState isEqualToString:@"1"]){
            _orderButton.backgroundColor = ButtonColor;
            [_orderButton setTitle:NSLocalizedString(@"FeedbackThePrice", nil) forState:UIControlStateNormal];
            _orderButton.userInteractionEnabled = YES;
        }else if ([_mainModel.numState isEqualToString:@"3"]){
            _orderButton.backgroundColor = ButtonColor;
            [_orderButton setTitle:NSLocalizedString(kOrderEnd, nil) forState:UIControlStateNormal];
            _orderButton.userInteractionEnabled = YES;
        }else if ([_mainModel.numState isEqualToString:@"8"]){
            _orderButton.backgroundColor = ButtonColor;
            [_orderButton setTitle:NSLocalizedString(kOnRoad, nil) forState:UIControlStateNormal];
            _orderButton.userInteractionEnabled = YES;
        }
        else{
            _orderButton.hidden = YES;
        }
        if (_bugSuc) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self initData];
            });
        }
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _orderButton.frame = CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
    _orderButton.backgroundColor = ButtonColor;
    [_orderButton setTitle:NSLocalizedString(kRobOrder,nil) forState:UIControlStateNormal];
    [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_orderButton addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_orderButton];
    [self.view bringSubviewToFront:_orderButton];
    
//    _orderButton.backgroundColor = [UIColor hexStringToColor:@"#808080"];
    _orderButton.hidden = YES;
    
}

- (void)orderBtnClick{
    if ([_mainModel.numState isEqualToString:@"0"]) {
        RunOrderDetailParam *orderParam = [[RunOrderDetailParam alloc] init];
        orderParam.order_id = _order_id;
        [HomeServer postTakeRunOrderWithParam:orderParam Success:^(id result) {
            [self arlertShowWithText:NSLocalizedString(kTakeOrderSuccess, nil)];
            _orderButton.backgroundColor = [UIColor hexStringToColor:@"#808080"];
            _orderButton.userInteractionEnabled = NO;
            [self initData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }else if ([_mainModel.numState isEqualToString:@"1"]) {
        FeedBackPriceParam *priceParam = [[FeedBackPriceParam alloc] init];
        priceParam.order_id = _mainModel.order_id;
        
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
                [priceView removeFromSuperview];
                _bugSuc = YES;
                [self initData];
            } failure:^(NSError *error) {
                [self errorResponsText:error];
            }];
            
        };
    }else{
        RunUpdateOrderStateParam *updateOrderParam = [[RunUpdateOrderStateParam alloc] init];
        updateOrderParam.order_id = _order_id;

        if  ([_mainModel.numState isEqualToString:@"8"]) {
            updateOrderParam.state = @"3";
        }else if ([_mainModel.numState isEqualToString:@"3"]){
            updateOrderParam.state = @"4";
        }else{
            updateOrderParam.state = @"3";
        }
        [HomeServer postUpdateRunOrderStateWithParam:updateOrderParam Success:^(id result) {
            [self initData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }
   
}

#pragma UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [RunOrderDetailCell cellHeightWithModel:_mainModel];
    }else if (indexPath.row == 5 || indexPath.row == 6){
        return 65;
    }else{
        return 55;
    }
}

static NSString *DetailHeadCellID = @"DetailHeadCellID";
static NSString *DetailCellID = @"DetailCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    __weak typeof(self) weakSelf = self;

    switch (indexPath.row) {
        case 0:{
            RunOrderDetailCell *headCell = [tableView dequeueReusableCellWithIdentifier:DetailHeadCellID];
            if (headCell == nil) {
                headCell = [[RunOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailHeadCellID];
            }
            headCell.delegate = self;
            headCell.model = _mainModel;
            headCell.imageViewDidTouchBlock = ^(RunOrderDetailModel *detailModel) {
                RunBigImageViewLook *bigImage = [[RunBigImageViewLook alloc] initWithFrame:[UIScreen mainScreen].bounds];
                [bigImage setDetailModel:detailModel];
                [weakSelf.view.window addSubview:bigImage];
            };
            cell = headCell;
        }
            break;
        case 1:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.zip_code index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 2:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.order_time index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 3:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.payment_method index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 4:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.order_id index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 5:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.cust_phone index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 6:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            NSString *state = _mainModel.state;
            if (_mainModel.pay_state == 1 && [_mainModel.numState integerValue] == 8) {
                state = NSLocalizedString(@"PaymentSuccess", nil);
            }else if(_mainModel.pay_state == 0 && [_mainModel.numState integerValue] == 8){
                state = NSLocalizedString(@"WaitPayment", nil);
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:state index:indexPath.row];
            cell = detailCell;
        }
            break;
            
        default:{
            UITableViewCell *defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
            cell = defaultCell;
        }
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 5 && _mainModel.cust_phone.length > 0) {
        UIWebView * callWebview = [[UIWebView alloc]init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_mainModel.cust_phone]]]];
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    }
    
}

- (void)addressDidClick:(RunOrderDetailModel *)mainModel{
    NSLog(@"mainModel = %@",mainModel.cust_address);
    self.urlScheme = @"BaoZouKuaiDiURI://";
    _coordinate.longitude = mainModel.addr_lng;
    _coordinate.latitude = mainModel.addr_lat;
    [self actionSheet];
}

- (void)bugButtonClick:(RunOrderDetailModel *)model{
    RunUpdateOrderStateParam *param = [[RunUpdateOrderStateParam alloc] init];
    param.order_id = _order_id;
    param.state = @"3";
    [HomeServer postUpdateRunOrderStateWithParam:param Success:^(id result) {
        [self initData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)actionSheet
{
    __block NSString *urlScheme = self.urlScheme;
    __block NSString *appName = self.appName;
    __block CLLocationCoordinate2D coordinate = self.coordinate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kSelectMaps, nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *appleAction = [UIAlertAction actionWithTitle:NSLocalizedString(kAppleMap, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }];
    
    [alert addAction:appleAction];
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(kGoogleMap, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel, nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
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
