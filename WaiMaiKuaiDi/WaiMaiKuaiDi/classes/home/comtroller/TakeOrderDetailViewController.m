//
//  TakeOrderDetailViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/18.
//  Copyright © 2017年 王. All rights reserved.
//

#import "TakeOrderDetailViewController.h"
#import "GMapViewController.h"
#import "DetailMainModel.h"
#import "DetailCell.h"
#import "TakeDetailCell.h"
#import "HomeServer.h"
@import CoreLocation;
@import MapKit;

@interface TakeOrderDetailViewController ()<TakeDetailCellDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DetailMainModel *mainModel;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation TakeOrderDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(kIndentDetail, nil);
    _titleArray = @[NSLocalizedString(kCodeNO, nil), NSLocalizedString(kOrderTime, nil),
                    NSLocalizedString(@"DistributionTime", nil),NSLocalizedString(kPayType, nil), NSLocalizedString(kIndentNo, nil), NSLocalizedString(kPhoneNo, nil), NSLocalizedString(kOrderType, nil)];
    [self initTableView];
}

- (void)initData{
    
    [HomeServer getOrderDetailWithOrderId:_order_id Success:^(DetailMainModel *result) {
        _mainModel = result;
        [self.tableView reloadData];
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
    
    if ([_onwork isEqualToString:@"0"] || _onwork == nil) {
        _orderButton.backgroundColor = [UIColor hexStringToColor:@"#808080"];
        _orderButton.userInteractionEnabled = NO;
    }
    
}

- (void)orderBtnClick{
    [HomeServer takeOrderWithOrderId:_order_id Success:^(id result) {
        [self arlertShowWithText:NSLocalizedString(kTakeOrderSuccess, nil)];
        _orderButton.backgroundColor = [UIColor hexStringToColor:@"#808080"];
        _orderButton.userInteractionEnabled = NO;
        [self initData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

#pragma UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [TakeDetailCell cellHeightWithModel:_mainModel];
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
    switch (indexPath.row) {
        case 0:{
            TakeDetailCell *headCell = [tableView dequeueReusableCellWithIdentifier:DetailHeadCellID];
            if (headCell == nil) {
                headCell = [[TakeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailHeadCellID];
            }
            headCell.delegate = self;
            headCell.model = _mainModel;
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
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.distribution_time index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 4:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.payment_method index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 5:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.order_id index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 6:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.cust_phone index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 7:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.state index:indexPath.row];
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
    
    if (indexPath.row == 6 && _mainModel.cust_phone.length > 0) {
        UIWebView * callWebview = [[UIWebView alloc]init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_mainModel.cust_phone]]]];
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    }
    
}

- (void)addressDidClick:(DetailMainModel *)mainModel{
    NSLog(@"mainModel = %@",mainModel.cust_address);
    self.urlScheme = @"BaoZouKuaiDiURI://";
    _coordinate.longitude = mainModel.lng;
    _coordinate.latitude = mainModel.lat;
    [self actionSheet];
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
