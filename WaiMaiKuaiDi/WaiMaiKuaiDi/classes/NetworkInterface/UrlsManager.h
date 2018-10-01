//
//  UrlsManager.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/15.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

//导航
#define kMapUrl  @"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&key=AIzaSyBCpvCYDQXL489575b4GRtZe5uD4T9J_hI"


/**
 主机地址
 */
#ifdef DEBUG //调试阶段
#define KBaseUrl @"http://123.56.234.98:8080/waimai_exp/app/"
#else   //发布阶段
#define KBaseUrl @"http://47.90.202.220:9000/app/"
#endif


#define kUserBaseUrl [UrlsManager getUserBaseUrl]

//登录
#define kLoginUrl [NSString stringWithFormat:@"%@expLogin/login.do",KBaseUrl]

//注册
#define kUserRegUrl [NSString stringWithFormat:@"%@expLogin/expReg.do",KBaseUrl]
//获取验证码
#define kCerCodeUrl  [NSString stringWithFormat:@"%@expLogin/getCerCode.do",KBaseUrl]
//获取首页接口
#define kHomePageUrl [NSString stringWithFormat:@"%@order/getOrderCodeList.do",KBaseUrl]
//首页邮编查询订单
#define kOrderListByZipCode [NSString stringWithFormat:@"%@order/getOrderListByZipCode.do",KBaseUrl]
//订单页
#define kExpOrderListByZipCode [NSString stringWithFormat:@"%@order/getExpOrderListByZipCode.do",KBaseUrl]
//订单详情
#define kOrderDetailUrl [NSString stringWithFormat:@"%@order/getOrderDetail.do",KBaseUrl]
//订单列表页
#define kExpOrderCodeListUrl [NSString stringWithFormat:@"%@order/getExpOrderCodeList.do",KBaseUrl]
//地图接单
#define kOrderListMapUrl  [NSString stringWithFormat:@"%@order/getOrderList4Map.do",KBaseUrl]

//取件
#define kPickupOrderFoodsUrl [NSString stringWithFormat:@"%@order/pickupOrderFoods.do",KBaseUrl]

//完成接单order/sendTo.do
#define kSendToUrl [NSString stringWithFormat:@"%@order/sendTo.do",KBaseUrl]

//接单
#define kTakeOrdersUrl [NSString stringWithFormat:@"%@order/takeOrders.do",KBaseUrl]

//快递坐标order/uploadLocation.do
#define kUploadLocationUrl [NSString stringWithFormat:@"%@order/uploadLocation.do",KBaseUrl]


//忘记密码
#define kForgetPwdUrl  [NSString stringWithFormat:@"%@expLogin/forgetPwd.do",KBaseUrl]

//确认付款
#define kPayOrder    [NSString stringWithFormat:@"%@order/payOrder.do",KBaseUrl]


/*
 个人中心
 **/
//修改昵称
#define kUpDateNickNameUrl [NSString stringWithFormat:@"%@expLogin/updateNickName.do",KBaseUrl]
//修改头像
#define kUpDateHeadUrl [NSString stringWithFormat:@"%@expLogin/updateHead.do",KBaseUrl]

//修改密码expLogin/updatePwd
#define kUpdatePwdUrl [NSString stringWithFormat:@"%@expLogin/updatePwd",KBaseUrl]

// 文件上传
#define kUploadURL [NSString stringWithFormat:@"%@common/upload.do",KBaseUrl]

//在路上
#define kOnTheWayUrl [NSString stringWithFormat:@"%@order/onTheWay.do",KBaseUrl]

//跑腿订单
#define kRunHomeOrderUrl [NSString stringWithFormat:@"%@orderErrands/getExpOrderCodeList.do",KBaseUrl]

//跑腿首页订单列表
#define kRunHomeCodeUrl [NSString stringWithFormat:@"%@orderErrands/getOrderListByZipCode.do",KBaseUrl]
//跑腿接单
#define kRunTakeOrderUrl [NSString stringWithFormat:@"%@orderErrands/takeOrders.do",KBaseUrl]

//跑腿订单详情
#define kRunTakeOrderDetailUrl [NSString stringWithFormat:@"%@orderErrands/getOrderDetail.do",KBaseUrl]

//修改订单状态
#define kUpDateRunOrderStateUrl [NSString stringWithFormat:@"%@orderErrands/updateOrderErrandsState.do",KBaseUrl]

//反馈订单价格orderErrands/updateOrderErrandsTotalMoney.do
#define kFeedBackOrderPriceUrl [NSString stringWithFormat:@"%@orderErrands/updateOrderErrandsTotalMoney.do",KBaseUrl]

@interface UrlsManager : NSObject


+ (NSString *)token;

+ (NSString *)userID;

+ (NSString *)getUserBaseUrl;

+ (NSString *)updateLocationWithLat:(double)lat lng:(double)lng;

//登录
+ (NSString *)getLoginUrlWithPhoneNo:(NSString *)phoneNo pwd:(NSString *)pwd;
//注册
+ (NSString *)getUserRegUrlWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code;
//验证码
+ (NSString *)getCerCodeUrlWithPhoneNo:(NSString *)phoneNo;

+ (NSString *)getForgetPwdUrlWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd;

+ (NSString *)getMapOrderList;

//首页
+ (NSString *)getHomePageUrlWithPage:(int)page;
//首页邮编查询订单
+ (NSString *)getOrderListByZipCodeWithPage:(int)page zipCode:(NSString *)zipCode;
//订单详情
+ (NSString *)getOrderDetailUrlWithOrderId:(NSString *)orderId;
//订单页接口
+ (NSString *)getOrderListUrlWithPage:(int)page keyword:(NSString *)keyword zip_code:(NSString *)zipCode state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone;
//订单列表页
+ (NSString *)getExpOrderCodeListUrlWithPage:(int)page keyword:(NSString *)keyword state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone;
//修改昵称
+ (NSString *)getUpDateNickNameUrlWithNickName:(NSString *)nickName;

//修改头像
+ (NSString *)getUpdateHeadUrlWithHead_image:(NSString *)head_image;
//修改密码
+ (NSString *)getUpdatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd;

//取件
+ (NSString *)getPickupOrderFoodsUrlWithOrderId:(NSString *)orderId foodId:(NSString *)foodId storeId:(NSString *)storeId;

+ (NSString *)getTakeOrdersUrlWithOrderId:(NSString *)orderId;

+ (NSString *)getSentToUrlWithOrderId:(NSString *)order_id;

+ (NSString *)getOnTheWayUrl;

+ (NSString *)getPayOrderUrlWithOrderId:(NSString *)order_id;
@end
