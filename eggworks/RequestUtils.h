//
//  RequestUtils.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//
//请求网络  获取数据

#import <Foundation/Foundation.h>
#import "Request.h"

@interface RequestUtils : NSObject
{
//    NSURLProtectionSpace * protectionSpace;
}


//移除认证
-(void) removeHttpCredentials;


// 激活/注册手机无忧服务 /mobile_service/orders/active.json
+(NSDictionary*)anonymouusActiveWithUser:(NSString*)for_user realName:(NSString*)real_name mobilePhone:(NSString*)mobile_phone verifyCode:(NSString*)verify_code deviceIdentity:(NSString*)device_identity brand:(NSString*)brand model:(NSString*)model;



////匿名用户激活服务
//+(NSDictionary*)anonymousActiveWithName:(NSString*)real_name
//                            mobilePhone:(NSString*)mobile_phone
//                         deviceIdentity:(NSString*)device_identity
//                                  brand:(NSString*)brand
//                                  model:(NSString*)model;

//获取手机无忧产品
+(NSArray*)queryMobileServiceProducts;

//匿名用户自助申购服务
+(NSDictionary*)anonymousCreateWithProductId:(NSString*)product_id
                                    realName:(NSString*)real_name
                                 mobilePhone:(NSString*)mobile_phone
                              deviceIdentity:(NSString*)device_identity
                                       brand:(NSString*)brand
                                       model:(NSString*)model
                                       force:(BOOL)force;
//查询当前服务协议
-(NSDictionary*)ordersJsonWithCallback:(callBack)callBack withView:(UIView*)view;

//理赔申请
-(NSDictionary*)claimRequestsWithOrderId:(NSString*)order_id
                           contactMobile:(NSString *)contact_mobil
                              pickMethod:(int)pick_method
                                  damage:(int)damage
                                 storeId:(NSString*)store_id
                                pickTime:(int)pick_time
                             pickAddress:(NSString*)pick_address
                                  areaId:(NSString*) areaId
                                callBack:(callBack)callback
                                withView:(UIView*)view;

//创建支付交易
-(NSDictionary*)paymentTransactionsWithPayGateway:(NSString*)pay_gateway
                                       objectType:(NSString*)object_type
                                         objectId:(NSString*)object_id
                                          subject:(NSString*)subject
                                         totalFee:(float)total_fee
                                           detail:(NSString*)detail
                                         callback:(callBack)callback
  withView:(UIView*)view;

////保存用户信息到 钥匙串中

//------------------------------------------------------------------------------

//获取理财产品
+(NSDictionary*)getfinancialMarketsWithAreaID:(NSString*)area_id partyId:(id)party_id period:(NSString*)period threshold:(NSString*)threshold page:(int)page keywork:(NSString*)keyword types:(NSString *)types;

//获取理财产品详情
-(NSDictionary*)getfinancialInfoWithProductId:(NSString*)productId Callback:(callBack)callback  withView:(UIView*)view;

//查询基础利率
+(NSDictionary*)getBaseInterestRatesWithCallback:(callBack)callback  withView:(UIView*)view;

//添加收藏
+(NSDictionary*)addFavoritesWithObjectType:(NSString *) object_type withObjectId:(NSString *)object_id callback:(callBack)callBack  withView:(UIView*)view;

//取消收藏
+(NSDictionary*)deleteFavoritesWithObjectType:(NSString*)objectType andObjectId:(NSString*)objectId callback:(callBack)callback  withView:(UIView*)view;

//我的收藏
+(NSDictionary*)getFavoritesProductsCallback:(callBack)callback  withView:(UIView*)view;

//-----------------------------------基础数据-------------------------------------------
//查询所有城市 areas_cities
+(NSDictionary*)getCitys;

//获取用户所在的城市
+(NSDictionary*)getMyCity;

//
+(NSDictionary*)getInstitutionsWithInstitutions:(NSArray*)array;

//发送短信验证
+(NSDictionary*)sendSMSVerifyWithNumber:(NSString*)number;

//用户注册
+(NSDictionary*)registerWithName:(NSString*)name password:(NSString*)password smsVerify:(NSString*)smsVerify callback:(callBack)callback  withView:(UIView*)view;

//查询用户基本信息
+(NSDictionary*)getUserInfoWithCallBack:(callBack)callback  withView:(UIView*)view;

//查询手机损坏原因
+(NSDictionary*)phoneDamageReason;

//修改登录密码
+(NSDictionary*)updatePasswordWithOldPsd:(NSString *)oldPassword andNewPassword:(NSString *)newPassword callback:(callBack)callback  withView:(UIView*)view;

//-------------------------------------私享理财------------------------------------------
//获取私享理财推荐产品
+(NSDictionary*)getEnjoyPrivateFinanceProductsWithPage:(int)page andForUser:(NSString*)for_user callback:(callBack)callback  withView:(UIView*)view;
//定制私享理财推荐条件
+(NSDictionary*)customEnjoyPrivateFinanceWithAreaId:(NSString*)area_id threshold:(NSString*)threshold partyIds:(NSArray*)partys productTypes:(NSString*)productTypes callback:(callBack)callback withView:(UIView*)view;

//上传数米用户信息
+(void)uploadSumiUserInfo:(NSDictionary*)dic callback:(callBack)callback withView:(UIView*)view;
//获取数米用户信息
+(void)getSumiUserInfoWithCallback:(callBack)callback withUIView:(UIView*)view;

@end
