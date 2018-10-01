//
//  IndentDetailViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "IndentDetailViewController.h"
#import "GMapViewController.h"
#import "DetailMainModel.h"
#import "DetailCell.h"
#import "DetailHeaderCell.h"
#import "HomeServer.h"
#import "DetailRemarkCell.h"
#import "OrderServer.h"
#import "CashPayCell.h"
@import CoreLocation;
@import MapKit;


@interface IndentDetailViewController ()<DetailHeaderCellDelegate, CashPayCellDelegate>

@property (nonatomic, strong) DetailMainModel *mainModel;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSInteger rowCount;

@end

@implementation IndentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kIndentDetail, nil);
    _titleArray = @[NSLocalizedString(kCodeNO, nil), NSLocalizedString(kOrderTime, nil), NSLocalizedString(kPayType, nil), NSLocalizedString(kIndentNo, nil), NSLocalizedString(kPhoneNo, nil), NSLocalizedString(kOrderPrice, nil), NSLocalizedString(kRemark, nil), NSLocalizedString(kOrderType, nil)];
    _rowCount = 9;
    [self initData];
}

- (void)initData{
    [HomeServer getOrderDetailWithOrderId:_order_id Success:^(DetailMainModel *result) {
        _mainModel = result;
        if ([_mainModel.payment_method isEqualToString:NSLocalizedString(kCashPayments, nil)] && [_mainModel.pay_state isEqualToString:@"0"]) {
            _rowCount = 10;
        }else{
            _rowCount = 9;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)confirmReceiptButtonClick:(UIButton *)button{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kConfirmReceipt, nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kConfirm, nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [OrderServer payOrderWithOrderId:_mainModel.order_id Success:^(id result) {
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


#pragma UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [DetailHeaderCell cellHeightWithModel:_mainModel];
    }else if (indexPath.row == 7){
        return [DetailRemarkCell cellHeightWithRemark:_mainModel.remark];
    }else if (indexPath.row == 9){
        return 90;
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
            DetailHeaderCell *headCell = [tableView cellForRowAtIndexPath:indexPath];
            if (headCell == nil) {
                headCell = [[DetailHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailHeadCellID];
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
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.create_time index:indexPath.row];
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
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:[NSString stringWithFormat:@"$%@",_mainModel.total_money] index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 7:{
            DetailRemarkCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailRemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.remark index:indexPath.row];
            cell = detailCell;
        }
            break;
        case 8:{
            DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
            if (detailCell == nil) {
                detailCell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellID];
            }
            [detailCell configWithTitle:_titleArray[indexPath.row-1] desc:_mainModel.state index:indexPath.row];
            cell = detailCell;
        }
            break;
            case 9:{
                CashPayCell *cashCell = [tableView dequeueReusableCellWithIdentifier:@"cashCellId"];
                if (cashCell == nil) {
                    cashCell = [[CashPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cashCellId"];
                }
                cashCell.delegate = self;
                cell = cashCell;
            }
            break;
        default:
        {
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
