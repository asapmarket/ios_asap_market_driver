//
//  UrlsManager.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UrlsManager.h"
 #import<CommonCrypto/CommonDigest.h>

@implementation UrlsManager

+ (NSString *)token{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    return userInfo.token;
}

+ (NSString *)userID{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    return userInfo.user_id;
}

+ (NSString *)updateLocationWithLat:(double)lat lng:(double)lng{
    return [NSString stringWithFormat:@"%@?%@&lat=%f&lng=%f",kUploadLocationUrl,kUserBaseUrl,lat,lng];
}

+ (NSString *)getUserBaseUrl{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    return [NSString stringWithFormat:@"user_id=%@&token=%@",userInfo.user_id,userInfo.token];
}

+ (NSString *)getCerCodeUrlWithPhoneNo:(NSString *)phoneNo{
    return [NSString stringWithFormat:@"%@?phone=%@",kCerCodeUrl,phoneNo];
}

+ (NSString *)getMapOrderList{
    return [NSString stringWithFormat:@"%@?%@",kOrderListMapUrl,kUserBaseUrl];
}

//登录
+ (NSString *)getLoginUrlWithPhoneNo:(NSString *)phoneNo pwd:(NSString *)pwd{
    pwd = [UrlsManager md5:pwd];
    return [NSString stringWithFormat:@"%@?phone=%@&pwd=%@",kLoginUrl,phoneNo,pwd];
}

//注册
+ (NSString *)getUserRegUrlWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code{
    pwd = [UrlsManager md5:pwd];
    return [NSString stringWithFormat:@"%@?phone=%@&pwd=%@&code=%@",kUserRegUrl,phone,pwd,code];
}
//首页
+ (NSString *)getHomePageUrlWithPage:(int)page{
    return [NSString stringWithFormat:@"%@?page_size=10&page=%d",kHomePageUrl,page];
}

//首页邮编查询订单
+ (NSString *)getOrderListByZipCodeWithPage:(int)page zipCode:(NSString *)zipCode{
    return [NSString stringWithFormat:@"%@?%@&zip_code=%@&page_size=10&page=%d",kOrderListByZipCode,kUserBaseUrl,zipCode,page];
}

//订单详情
+ (NSString *)getOrderDetailUrlWithOrderId:(NSString *)orderId{
    return [NSString stringWithFormat:@"%@?order_id=%@",kOrderDetailUrl,orderId];
}

//订单页
+ (NSString *)getOrderListUrlWithPage:(int)page keyword:(NSString *)keyword zip_code:(NSString *)zipCode state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone{
    return [NSString stringWithFormat:@"%@?%@&page=%d&page_size=10&keyword=%@&zip_code=%@&state=%@&start_time=%@&end_time=%@&pay_method=%@&order_id=%@&cust_phone=%@",kExpOrderListByZipCode,kUserBaseUrl,page,keyword,zipCode,state,start_time,end_time,pay_method,orderId,cust_phone];

}

//订单列表页
+ (NSString *)getExpOrderCodeListUrlWithPage:(int)page keyword:(NSString *)keyword state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone{
     return [NSString stringWithFormat:@"%@?%@&page=%d&page_size=10&keyword=%@&state=%@&start_time=%@&end_time=%@&pay_method=%@&order_id=%@&cust_phone=%@",kExpOrderCodeListUrl,kUserBaseUrl,page,keyword,state,start_time,end_time,pay_method,orderId,cust_phone];
}

//修改昵称
+ (NSString *)getUpDateNickNameUrlWithNickName:(NSString *)nickName{
    return [NSString stringWithFormat:@"%@?%@&nick_name=%@",kUpDateNickNameUrl,kUserBaseUrl,nickName];
}

//忘记密码
+ (NSString *)getForgetPwdUrlWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd{
    pwd = [UrlsManager md5:pwd];
    return [NSString stringWithFormat:@"%@?phone=%@&new_pwd=%@&code=%@",kForgetPwdUrl,phone,pwd,code];
}

//修改头像
+ (NSString *)getUpdateHeadUrlWithHead_image:(NSString *)head_image{
    return [NSString stringWithFormat:@"%@?%@&head_image=%@",kUpDateHeadUrl,kUserBaseUrl,head_image];
}

//取件
+ (NSString *)getPickupOrderFoodsUrlWithOrderId:(NSString *)orderId foodId:(NSString *)foodId storeId:(NSString *)storeId{
    return [NSString stringWithFormat:@"%@?%@&order_id=%@&foods_id=%@&store_id=%@",kPickupOrderFoodsUrl,kUserBaseUrl,orderId, foodId, storeId];
}

//接单
+ (NSString *)getTakeOrdersUrlWithOrderId:(NSString *)orderId{
    return [NSString stringWithFormat:@"%@?%@&order_id=%@",kTakeOrdersUrl,kUserBaseUrl,orderId];
}

//订单完成
+ (NSString *)getSentToUrlWithOrderId:(NSString *)order_id{
    return [NSString stringWithFormat:@"%@?%@&order_id=%@",kSendToUrl,kUserBaseUrl,order_id];
}

+ (NSString *)getUpdatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd{
    oldPwd = [UrlsManager md5:oldPwd];
    newPwd = [UrlsManager md5:newPwd];
    return [NSString stringWithFormat:@"%@?%@&old_pwd=%@&new_pwd=%@",kUpdatePwdUrl,kUserBaseUrl,oldPwd,newPwd];
}

//在路上
+ (NSString *)getOnTheWayUrl{
    return [NSString stringWithFormat:@"%@?%@",kOnTheWayUrl,kUserBaseUrl];
}

+ (NSString *)getPayOrderUrlWithOrderId:(NSString *)order_id{
    return [NSString stringWithFormat:@"%@?%@&order_id=%@",kPayOrder,kUserBaseUrl,order_id];
}

//md5加密
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
    
}
@end
