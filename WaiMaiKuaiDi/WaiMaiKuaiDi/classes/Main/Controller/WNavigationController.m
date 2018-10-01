//
//  WNavigationController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "WNavigationController.h"
#import "UIBarButtonItem+MJ.h"

@interface WNavigationController ()

@end

@implementation WNavigationController

#pragma mark push到一个viewController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_back" highIcon:@"icon_back" target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self.view endEditing:YES];
    
    [self popViewControllerAnimated:YES];
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
