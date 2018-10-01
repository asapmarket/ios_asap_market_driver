//
//  AppDelegate.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "AppDelegate.h"
#import "WTabBarController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MyCLLocation.h"
#import <Bugly/Bugly.h>
#import "HomeServer.h"
#import "GuidePageViewController.h"

/**
 谷歌Key
 */
static NSString *const kAPIKey = @"AIzaSyAd5uo53TOMb313_kIYLTlEPykJOq44YUI";

#define BUGLY_APP_ID @"e172ac4c18"

@interface AppDelegate ()<GuidePageViewControllerDelegate>{
    id _services;
    NSInteger oldTime;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    oldTime = [self getDetailDate];
    [[LanguageManager shareManager] initUserLanguage];
    [[UITextField appearance] setTintColor:[UIColor hexStringToColor:@"#DBDBDB"]];
    
    // 设置NavigationBar.title
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName,  nil]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChange:) name:LanguageChange object:nil];
    
    //    [self guidePageViewController];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    WTabBarController *tabBar = [[WTabBarController alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.window.rootViewController = tabBar;
    [self GMapServer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self uploadLocation];
    });
    [self setupBugly];
    return YES;
}


- (void)guidePageViewController{
    if ([GuidePageViewController shouldShowGuidePage]) {
        GuidePageViewController *guidePage = [[GuidePageViewController alloc] init];
        guidePage.delegate = self;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.window.rootViewController = guidePage;
            
        } completion:^(BOOL finished) {
        }];
        
    }else{
        [self upgradeGiftViewCancel];
    }
    
}

- (void)upgradeGiftViewCancel{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    WTabBarController *tabBar = [[WTabBarController alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.window.rootViewController = tabBar;
}


- (void)languageChange:(NSNotification *)notifi{
    NSLog(@"%@",[notifi object]);
    [[LanguageManager shareManager] setUserLanguage:[notifi object]];
    WTabBarController *tabBar = [[WTabBarController alloc] init];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    
}

- (void)GMapServer{
    [GMSServices provideAPIKey:kAPIKey];
    _services = [GMSServices sharedServices];
    
}

- (void)uploadLocation{
    NSInteger newTime = [self getDetailDate];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 100)];
//    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    [self.window addSubview:view];
//    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
//    label.textColor = [UIColor whiteColor];
//    [view addSubview:label];
    
    if (newTime - oldTime >=5) {
        [[MyCLLocation shareManager] startLocation:^(CLLocation *location) {
            [HomeServer uploadLocationWithLat:location.coordinate.latitude lng:location.coordinate.longitude Success:^(id result) {
                oldTime = newTime;
//                label.text = [NSString stringWithFormat:@"latitude:%f /n   longitude:%f",location.coordinate.latitude, location.coordinate.longitude];
                NSLog(@"%@",result);
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            NSLog(@"MyCLLocation;   %f,   %f",location.coordinate.longitude, location.coordinate.latitude);
        }];
    }
    
}

- (void)setupBugly {
    // Get the default config
    BuglyConfig * config = [[BuglyConfig alloc] init];
    
    // Open the debug mode to print the sdk log message.
    // Default value is NO, please DISABLE it in your RELEASE version.
    //#if DEBUG
    config.debugMode = YES;
    //#endif
    
    // Open the customized log record and report, BuglyLogLevelWarn will report Warn, Error log message.
    // Default value is BuglyLogLevelSilent that means DISABLE it.
    // You could change the value according to you need.
    //    config.reportLogLevel = BuglyLogLevelWarn;
    
    // Open the STUCK scene data in MAIN thread record and report.
    // Default value is NO
    config.blockMonitorEnable = YES;
    
    // Set the STUCK THRESHOLD time, when STUCK time > THRESHOLD it will record an event and report data when the app launched next time.
    // Default value is 3.5 second.
    config.blockMonitorTimeout = 1.5;
    
    // Set the app channel to deployment
    config.channel = @"Bugly";
    
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = NO;
    
    // NOTE:Required
    // Start the Bugly sdk with APP_ID and your config
    [Bugly startWithAppId:BUGLY_APP_ID
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    
    // Set the customizd tag thats config in your APP registerd on the  bugly.qq.com
    // [Bugly setTag:1799];
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    
}


//获取日期
- (NSInteger)getDetailDate{
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    NSInteger d = [dd day];
    NSInteger h = [dd hour];
    NSInteger min = [dd minute];
    NSInteger s = [dd second];
    //    NSString *nowDate = [NSString stringWithFormat:@"%d%d%d%d",d,h,min,s];
    NSInteger nowTime = d*24*3600 + h*3600 + min*60 + s;
    return nowTime;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
