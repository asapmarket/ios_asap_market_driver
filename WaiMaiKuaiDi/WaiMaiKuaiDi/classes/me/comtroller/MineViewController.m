//
//  MineViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MineViewController.h"
#import "SetPersonalViewController.h"
#import "IndentManagerController.h"
#import "PersonalCell.h"
#import "OrderCell.h"
#import "oneCell.h"
#import "ContactUsViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kPersonalCenter,nil);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"set" highIcon:@"set" target:self action:@selector(setPersonalInfo) size:CGSizeMake(21, 19.5)];

    
}

- (void)setPersonalInfo{
    SetPersonalViewController *personalCtrl = [[SetPersonalViewController alloc] init];
    [self.navigationController pushViewController:personalCtrl animated:YES];
}


static NSString *OrderCellId = @"OrderCellId";
static NSString *PersonCellId = @"PersonCellId";
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 160;
    }else{
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if (indexPath.row == 0){
        PersonalCell *personalCell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonCellId];
        
        cell = personalCell;

    }else if(indexPath.row == 1){
        OrderCell *order = [tableView dequeueReusableCellWithIdentifier:OrderCellId];
        if (order == nil) {
            order = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderCellId];
        }
        cell = order;
    }
//    else{
//        oneCell *one = [tableView dequeueReusableCellWithIdentifier:OrderCellId];
//        if (one == nil) {
//            one = [[oneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderCellId];
//        }
//        [one setTitle:NSLocalizedString(kContactUs, nil) icon:@"call"];
//        cell = one;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        IndentManagerController *indent = [[IndentManagerController alloc] init];
        [self.navigationController pushViewController:indent animated:YES];
    }
//    else if (indexPath.row == 2){
//        ContactUsViewController *contact = [[ContactUsViewController alloc] init];
//        [self.navigationController pushViewController:contact animated:YES];
//    }
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
