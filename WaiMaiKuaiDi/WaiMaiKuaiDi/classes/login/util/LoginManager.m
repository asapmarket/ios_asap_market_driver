//
//  LoginManager.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LoginManager.h"
#import "LoginViewController.h"
#import "WNavigationController.h"

@implementation LoginManager

+ (void)toLogin{
    LoginViewController *login = [[LoginViewController alloc] init];
    WNavigationController *loginNav = [[WNavigationController alloc] initWithRootViewController:login];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];
}

@end
