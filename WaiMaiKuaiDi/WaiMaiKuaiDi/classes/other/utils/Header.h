//
//  Header.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UIColor+RGBColor.h"
#import "MJExtension.h"
#import "MBProgressHUD+NJ.h"
#import "MJRefresh.h"
#import "UrlsManager.h"
#import "UIImageView+WebCache.h"
#import "LoginManager.h"
#import "UIBarButtonItem+MJ.h"
#import "UILabel+New.h"
#import "UIButton+ImageTitleV.h"
#import "LanguageManager.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Internationalization.h"
#import "NSBundle+Language.h"

#import "UserInfo.h"
#import "UserInfoTool.h"
#import "CreateLabel.h"

#import "MyRTLocation.h"

#ifdef DEBUG //调试阶段
#define NSLog(...) NSLog(__VA_ARGS__)
#else   //发布阶段
#define NSLog(...)
#endif

//中文
#define kSetChinese   @"zh-Hans"
//英文
#define kSetEnglish   @"en"

#define MapKey @"AIzaSyBCpvCYDQXL489575b4GRtZe5uD4T9J_hI"

#define TopBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

//引导页version
#define GuidePageVersionKey @"GuidePageVersionKey"

//当前语言
#define kNowLanguage  @"kNowLanguage"
//订单页搜索
#define kOrderViewDidSearch  @"OrderViewDidSearch"

#define UserInfoChange   @"userInfoChange"

//验证码时间
#define SendNextVerifyCode (20)

// 主题色
#define ThemeColor [UIColor hexStringToColor:@"#f5f5f5"]

#define ThemeBgColor [UIColor hexStringToColor:@"#F4F5F6"]

//按钮颜色
#define ButtonColor [UIColor hexStringToColor:@"#2196f3"]

#define LanguageChange @"LanguageChange"

#define TableBorder 10  // 左右间距
#define CellBorder 10   // 上下间距

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_5 (SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (SCREEN_MAX_LENGTH == 736.0)


