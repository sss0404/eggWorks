//
//  RequestUtils.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RequestUtils.h"
#import "JSON.h"
#import "PhoneEasyProduct.h"
#import "Utils.h"

@implementation RequestUtils


+(NSDictionary*)anonymouusActiveWithUser:(NSString*)for_user
                                realName:(NSString*)real_name
                             mobilePhone:(NSString*)mobile_phone
                              verifyCode:(NSString*)verify_code
                          deviceIdentity:(NSString*)device_identity
                                   brand:(NSString*)brand
                                   model:(NSString*)model
{
    NSString * apiAndParameter = [NSString stringWithFormat:@"%@?real_name=%@&mobile_phone=%@&verify_code=%@&device_identity=%@&brand=%@&model=%@",anonymous_active, real_name, mobile_phone, verify_code, device_identity, brand,model];;
    if (for_user.length != 0) {
        apiAndParameter = [NSString stringWithFormat:@"%@&for_user=%@",apiAndParameter,for_user];
    }
    NSString * resultStr = [self requestWithPostApiAndParameter:apiAndParameter withUrl:SERVER_ADDR_HTTP];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
     NSDictionary* dic = [jsonParser objectWithString:resultStr];
    
    return dic;
}

//接口废弃
//+(NSDictionary*)anonymousActiveWithName:(NSString*)real_name
//                            mobilePhone:(NSString*)mobile_phone
//                         deviceIdentity:(NSString*)device_identity
//                                  brand:(NSString*)brand
//                                  model:(NSString*)model
//{
//    NSString * apiAndParameter = [NSString stringWithFormat:@"%@?real_name=%@&mobile_phone=%@&device_identity=%@&brand=%@&model=%@", anonymous_active,real_name,mobile_phone,device_identity,brand,model];
//    NSString * resultStr = [self requestWithPostApiAndParameter:apiAndParameter withUrl:SERVER_ADDR_HTTP];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:resultStr];
//    
//    return dic;
//}

+(NSArray*)queryMobileServiceProducts
{
    NSMutableArray * array = [[[NSMutableArray alloc] init] autorelease];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,mobile_service_products];
    NSString * resultStr = [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
    NSDictionary* dic = [jsonParser objectWithString:resultStr];
    BOOL success = [[dic objectForKey:@"success"] boolValue];
    if (success) {
        PhoneEasyProduct * product = nil;
        NSArray * products = [dic objectForKey:@"products"];
        for (int i=0; i<products.count; i++) {
            NSDictionary * productItem = [products objectAtIndex:i];
            product = [[[PhoneEasyProduct alloc] init] autorelease];
            product.id_ = [productItem objectForKey:@"id"];
            product.name = [productItem objectForKey:@"name"];
            product.period = [productItem objectForKey:@"period"];
            product.termSummary = [productItem objectForKey:@"term_summary"];
            product.price = [productItem objectForKey:@"price"];
            product.terms = [productItem objectForKey:@"terms"];
            [array addObject:product];
        }
    }
    return array;
}

//匿名用户自助申购服务
+(NSDictionary*)anonymousCreateWithProductId:(NSString*)product_id
                                    realName:(NSString*)real_name
                                 mobilePhone:(NSString*)mobile_phone
                              deviceIdentity:(NSString*)device_identity
                                       brand:(NSString*)brand
                                       model:(NSString*)model
                                       force:(BOOL)force
{
    NSString * apiAndParameter = [NSString stringWithFormat:@"?product_id=%@&real_name=%@&mobile_phone=%@&device_identity=%@&brand=%@&model=%@&force=%i"
                                  ,product_id,real_name,mobile_phone,device_identity,brand,model,force];
    NSLog(@"apiAndParameter:%@",apiAndParameter);
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, anonymous_create];
    apiAndParameter = [apiAndParameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * resultStr = [self requestWithPostApiAndParameter:apiAndParameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
    NSDictionary* dic = [jsonParser objectWithString:resultStr];
    return dic;
}


+(NSString*)requestWithGet:(NSString*)urlStr
{
    
    NSURL * url = [[[NSURL alloc] initWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] autorelease];
    NSLog(@"get请求地址：%@",urlStr);
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:5];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPMethod:@"GET"];

    //开始请求
    NSError *error = nil;
    NSURLResponse* response = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    NSString * str = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"str:%@",str);
    return str;
}

//post请求
+(NSString*)requestWithPostApiAndParameter:(NSString*)apiAndParameter withUrl:(NSString*)urlStr
{
    NSLog(@"post请求地址：%@",urlStr);
    NSLog(@"请求参数:%@",apiAndParameter);
    apiAndParameter = [apiAndParameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",urlStr,apiAndParameter]] autorelease];
    
    NSMutableURLRequest * urlRequest = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPMethod:@"POST"];
    NSData *bodyData = [apiAndParameter dataUsingEncoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:bodyData];
    
    //开始请求
    NSError *error = nil;
    NSURLResponse* response = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    NSString * str = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"str:%@", str);
    return str;
}

//put请求
+(NSString*)requestWithPutApiAndParameter:(NSString*)apiAndParameter withUrl:(NSString*)urlStr
{
    NSLog(@"post请求地址：%@",urlStr);
    NSLog(@"请求参数:%@",apiAndParameter);
    apiAndParameter = [apiAndParameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",urlStr,apiAndParameter]] autorelease];
    
    NSMutableURLRequest * urlRequest = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPMethod:@"PUT"];
    NSData *bodyData = [apiAndParameter dataUsingEncoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:bodyData];
    
    //开始请求
    NSError *error = nil;
    NSURLResponse* response = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    NSString * str = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"str:%@", str);
    return str;
}

//查询当前服务协议
-(NSDictionary*)ordersJson
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * userId = [Utils getAccount];
    NSString * password = [Utils getPassword];
    [self saveWithUid:userId andPassword:password];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,orders_json];
    NSString * str = [RequestUtils requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
   NSLog(@"查询当前服务协议返回:%@",str);
    return dic;
}

//理赔申请
-(NSDictionary*)claimRequestsWithOrderId:(NSString*)order_id
                           contactMobile:(NSString *)contact_mobil
                              pickMethod:(int)pick_method
                                  damage:(int)damage
                                 storeId:(NSString*)store_id
                                pickTime:(int)pick_time
                             pickAddress:(NSString*)pick_address
                                  areaId:(NSString*) areaId
{
    //拼接请求参数
    NSString * api = [NSString stringWithFormat:claim_requests, order_id];
    NSString * parameter = [NSString stringWithFormat:@"?order_id=%@&contact_mobil=%@&pick_method=%i&damage=%i&store_id=%@&pick_time=%i&pick_address=%@",order_id,contact_mobil,pick_method,damage,store_id,pick_time,pick_address];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    //发送请求
    NSString * userId = [Utils getAccount];
    NSString * password = [Utils getPassword];
    [self saveWithUid:userId andPassword:password];
    parameter = [parameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * str = [RequestUtils requestWithPostApiAndParameter:parameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
//    NSLog(@"dic:%@",dic);
    return dic;
}

//创建支付交易
-(NSDictionary*)paymentTransactionsWithPayGateway:(NSString*)pay_gateway
                                       objectType:(NSString*)object_type
                                         objectId:(NSString*)object_id
                                          subject:(NSString*)subject
                                         totalFee:(float)total_fee
                                           detail:(NSString*)detail
{
    NSString * userId = [Utils getAccount];
    NSString * password = [Utils getPassword];
    [self saveWithUid:userId andPassword:password];
    NSString * api = payment_transactions;
    NSString * parameter = [NSString stringWithFormat:@"?pay_gateway=%@&object_type=%@&object_id=%@",pay_gateway,object_type,object_id];
    parameter = [parameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    //请求
    NSString * str = [RequestUtils requestWithPostApiAndParameter:parameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

-(void) saveWithUid:(NSString*)userId andPassword:(NSString*)password {
    NSLog(@"userId:%@",userId);
    NSLog(@"password:%@",password);
    
    protectionSpace = [[NSURLProtectionSpace alloc] initWithHost: SERVER_ADDR
                                                            port: 80
                                                        protocol: @"http"
                                                           realm: @"caidancf.com"
                                            authenticationMethod: NSURLAuthenticationMethodHTTPDigest];
    
    if (userId.length == 0) {
        NSURLCredential * urlCredential = [[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:protectionSpace];
        if (urlCredential != nil) {
            [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:urlCredential forProtectionSpace:protectionSpace];
        }
        return;
    }
    
    
    //模拟器使用
	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential: [NSURLCredential credentialWithUser: userId
																									   password: password
																									persistence: NSURLCredentialPersistencePermanent]
	 
														forProtectionSpace: protectionSpace];
    
    //以下为真机
//	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential: [NSURLCredential credentialWithUser: userId
//																									   password: password
//																									persistence: NSURLCredentialPersistencePermanent]
//	 
//														forProtectionSpace: protectionSpace];
}


//获取理财产品
+(NSDictionary*)getfinancialMarketsWithAreaID:(NSString*)area_id partyId:(id)party_id period:(NSString*)period threshold:(NSString*)threshold page:(int)page keywork:(NSString*)keyword
{
    NSString * party_id_str = @"&party_id=";
    if (party_id != nil) {
        if ([party_id isKindOfClass:[NSString class]]) {//事字符串
            party_id_str = [NSString stringWithFormat:@"%@%@",party_id_str,party_id];
        } else {
            party_id_str = [self array2StringParameter:party_id withParameterName:@"party_ids[]" andKey:@"id"];
        }
    }
        
    NSString * api = financial_market_products;
    NSString * parameter = [NSString stringWithFormat:@"?area_id=%@%@&period=%@&threshold=%@&page=%i&keyword=%@",area_id,party_id_str,period,threshold,page,keyword];
    NSString * url = [NSString stringWithFormat:@"%@%@%@",SERVER_ADDR_HTTP,api,parameter];
    NSString * str = [self requestWithGet:url];
//    NSLog(@"获取理财产品:%@", str);
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    
    return dic;
}

//获取理财产品详情
-(NSDictionary*)getfinancialInfoWithProductId:(NSString*)productId
{
    [RequestUtils setUserAndPsd];
    NSString * api = [NSString stringWithFormat:financial_products_info,productId];
    NSString * account =  [Utils getAccount];
    NSString * url;
    if (account.length == 0) {
        url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    } else {
        url = [NSString stringWithFormat:@"%@%@?for_user=%@",SERVER_ADDR_HTTP, api, account];
    }
    
    NSString * str = [RequestUtils requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//查询基础利率
+(NSDictionary*)getBaseInterestRates
{
    NSString * api = base_interest_rates;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
    NSString * str = [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    
    return dic;
}

//添加收藏
+(NSDictionary*)addFavoritesWithObjectType:(NSString *) object_type withObjectId:(NSString *)object_id
{
    [self setUserAndPsd];
    
    NSString * api = profile_favorites;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
    NSString * parameter = [NSString stringWithFormat:@"?object_type=%@&object_id=%@", object_type, object_id];
    NSString * str = [self requestWithPostApiAndParameter:parameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//取消收藏
+(NSDictionary*)deleteFavoritesWithObjectType:(NSString*)objectType andObjectId:(NSString*)objectId
{
    [self setUserAndPsd];
    
    NSString * api = [NSString stringWithFormat:cancel_favorites, objectType, objectId];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
    NSString * str = [self requestWithPostApiAndParameter:@"" withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

+(void)setUserAndPsd
{
    NSString * userId = [Utils getAccount];
    NSString * password = [Utils getPassword];
    RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
    [requestUtils saveWithUid:userId andPassword:password];
}


//我的收藏
+(NSDictionary*)getFavoritesProducts
{
    //添加
    NSString * userId = [Utils getAccount];
    NSString * password = [Utils getPassword];
    RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
    [requestUtils saveWithUid:userId andPassword:password];
    
    NSString * api = favorites;
    NSString * url = [NSString stringWithFormat:@"%@%@", SERVER_ADDR_HTTP, api];
    NSString * str =  [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//查询所有城市 areas_cities
+(NSDictionary*)getCitys
{
    NSString * api = areas_cities;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
    NSString * str = [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//获取用户所在的城市
+(NSDictionary*)getMyCity
{
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, city_of_ip];
    NSString * str = [self requestWithGet:url];
    SBJsonParser * jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary * dic = [jsonParser objectWithString:str];
    
    NSMutableDictionary * cityCity;
    if ([[dic objectForKey:@"success"] boolValue]) {
        cityCity = [[[NSMutableDictionary alloc] init] autorelease];
        [cityCity setValue:[dic objectForKey:@"city_name"] forKey:@"name"];//当前测试城市
        [cityCity setValue:[dic objectForKey:@"city_id"] forKey:@"id"];
    }
    return cityCity;
}

//查询机构
+(NSDictionary*)getInstitutionsWithInstitutions:(NSArray*)array
{
    
    NSString * arrayParameter = [self array2StringParameter:array withKey:@"types[]"];
    NSString * api = institutions_parties;
    NSString * parameter = [NSString stringWithFormat:@"%@?per_page=1000%@",api,arrayParameter];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, parameter];
    NSString * str = [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//参数拼接
+(NSString*)array2StringParameter:(NSArray*)array withKey:(NSString *)parameterName
{
    NSString * str = @"";
    
    for (int i=0; i<array.count; i++) {
        str = [NSString stringWithFormat:@"%@&%@=%@",str,parameterName,[array objectAtIndex:i]];
    }
    return str;
}



//拼接参数
+(NSString*)array2StringParameter:(NSArray*)array withParameterName:(NSString *)parameterName andKey:(NSString*)key
{
    NSString * str = @"";
    
    for (int i=0; i<array.count; i++) {
        
        str = [NSString stringWithFormat:@"%@&%@=%@",str,parameterName,[[array objectAtIndex:i] objectForKey:key]];
    }
    return str;
}

//发送短信验证
+(NSDictionary*)sendSMSVerifyWithNumber:(NSString*)number
{
    NSString * api = send_sms_verify;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    NSString * parameter = [NSString stringWithFormat:@"?mobile_phone=%@",number];
    NSString * str = [self requestWithPostApiAndParameter:parameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//用户注册
+(NSDictionary*)registerWithName:(NSString*)name password:(NSString*)password smsVerify:(NSString*)smsVerify
{
    NSString * api = user_register;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    NSString * parameter = [NSString stringWithFormat:@"?mobile_phone=%@&user[password]=%@&verify_code=%@",name,password,smsVerify];
    NSString * str = [self requestWithPostApiAndParameter:parameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//查询用户基本信息
+(NSDictionary*)getUserInfo
{
    RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
    [requestUtils saveWithUid:[Utils getAccount] andPassword:[Utils getPassword]];
    NSString * api = user_info;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    NSString * str =  [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//获取私享理财推荐产品
+(NSDictionary*)getEnjoyPrivateFinanceProductsWithPage:(int)page andForUser:(NSString*)for_user
{
    [self setUserAndPsd];
    
    NSString * api = products_recommendation;
    NSString * parameter = [NSString stringWithFormat:@"?page=%i&for_user=%@",page,for_user];
    NSString * url = [NSString stringWithFormat:@"%@%@%@",SERVER_ADDR_HTTP,api,parameter];
    NSString * str =  [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    
    return dic;
}

//定制私享理财推荐条件
+(NSDictionary*)customEnjoyPrivateFinanceWithAreaId:(NSString*)area_id threshold:(NSString*)threshold partyIds:(NSArray*)partys productTypes:(NSString*)productTypes
{
    NSString * partysStr = [self array2StringParameter:partys withParameterName:@"party_ids[]" andKey:@"id"];
    NSString * api = recommend_preferences;
    NSString * url = [NSString stringWithFormat:@"%@%@", SERVER_ADDR_HTTP, api];
    NSString * parameter = [NSString stringWithFormat:@"?area_id=%@&threshold=%@%@%@",area_id, threshold, partysStr,productTypes];
    NSLog(@"私享理财 定制推荐:%@",parameter);
    NSString * str = [self requestWithPostApiAndParameter:parameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//查询手机损坏原因
+(NSDictionary*)phoneDamageReason
{
    NSString * url = [NSString stringWithFormat:@"%@%@?type=%@",SERVER_ADDR_HTTP,damage_reason,@"damage_reason"];
    NSString * str = [self requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

//修改登录密码
+(NSDictionary*)updatePasswordWithOldPsd:(NSString *)oldPassword andNewPassword:(NSString *)newPassword
{    NSString * userId = [Utils getAccount];
    RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
    //使用用户当前输入的密码进行验证
    [requestUtils saveWithUid:userId andPassword:oldPassword];
    
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,update_password];
    NSString * parameter = [NSString stringWithFormat:@"?password=%@",newPassword];
    NSString * str = [self requestWithPutApiAndParameter:parameter withUrl:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}
@end
