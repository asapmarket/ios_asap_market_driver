//
//  WTabBarController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "WTabBarController.h"
#import "WNavigationController.h"

#import "HomeViewController.h"
#import "IndentViewController.h"
#import "MineViewController.h"

@interface WTabBarController ()

@end

@implementation WTabBarController

+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor hexStringToColor:@"#2196f3"];
    
    UITabBarItem *items = [UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self addChildViewControllers];
    }
    return self;
}

#pragma mark - 添加所有子控制器
- (void)addChildViewControllers {
    [self addChildViewControllerClassName:@"HomeViewController" title:NSLocalizedString(kLobby, nil) imageName:@"home"];
    [self addChildViewControllerClassName:@"IndentViewController" title:NSLocalizedString(kUnfinished, nil) imageName:@"indent"];
    [self addChildViewControllerClassName:@"MineViewController" title:NSLocalizedString(kPersonalCenter, nil) imageName:@"me"];
}

#pragma mark - 设置所有子控制器
- (void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName
{
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    WNavigationController *nav = [[WNavigationController alloc] initWithRootViewController:viewController];
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.image = [[UIImage imageNamed: imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_click", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

- (void)WTabBarViewControllerToHome{
    self.selectedIndex = 0;
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
