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
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:0];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    //开始请求
    NSError *error = nil;
    NSURLResponse* response = nil;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    NSString * str = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"str:%@",str);
    RequestUtils * reqUtil = [[[RequestUtils alloc] init] autorelease];
    [reqUtil removeHttpCredentials];
    return str;
}

//post请求
+(NSString*)requestWithPostApiAndParameter:(NSString*)apiAndParameter withUrl:(NSString*)urlStr
{
    NSLog(@"post请求地址：%@",urlStr);
    NSLog(@"请求参数:%@",apiAndParameter);
    apiAndParameter = [apiAndParameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",urlStr,apiAndParameter]] autorelease];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:0];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
    [urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    
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
    RequestUtils * reqUtil = [[[RequestUtils alloc] init] autorelease];
    [reqUtil removeHttpCredentials];
    return str;
}

//put请求
+(NSString*)requestWithPutApiAndParameter:(NSString*)apiAndParameter withUrl:(NSString*)urlStr
{
    NSLog(@"post请求地址：%@",urlStr);
    NSLog(@"请求参数:%@",apiAndParameter);
    apiAndParameter = [apiAndParameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",urlStr,apiAndParameter]] autorelease];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:5];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
    [urlRequest setHTTPMethod:@"PUT"];
    NSData *bodyData = [apiAndParameter dataUsingEncoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:bodyData];
    [urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    
    //开始请求
    NSError *error = nil;
    NSURLResponse* response = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    NSString * str = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"str:%@", str);
    RequestUtils * reqUtil = [[[RequestUtils alloc] init] autorelease];
    [reqUtil removeHttpCredentials];
    return str;
}

//查询当前服务协议
-(NSDictionary*)ordersJsonWithCallback:(callBack)callBack withView:(UIView*)view
{
//    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//    NSString * userId = [Utils getAccount];
//    NSString * password = [Utils getPassword];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,orders_json];
//    NSString * str = [RequestUtils requestWithGet:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
//   NSLog(@"查询当前服务协议返回:%@",str);
    
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callBack method:@"GET" withView:view] ;
    return nil;
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
                                callBack:(callBack)callback  withView:(UIView*)view
{
    //拼接请求参数
    NSString * api = [NSString stringWithFormat:claim_requests, order_id];
    NSString * parameter = [NSString stringWithFormat:@"?order_id=%@&contact_mobil=%@&pick_method=%i&damage=%i&store_id=%@&pick_time=%i&pick_address=%@",order_id,contact_mobil,pick_method,damage,store_id,pick_time,pick_address];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    //发送请求
//    NSString * userId = [Utils getAccount];
//    NSString * password = [Utils getPassword];
//    parameter = [parameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString * str = [RequestUtils requestWithPostApiAndParameter:parameter withUrl:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
//    NSLog(@"dic:%@",dic);
    
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:parameter withUrl:url withCallBack:callback method:@"POST" withView:view];
    
    return nil;
}

//创建支付交易
-(NSDictionary*)paymentTransactionsWithPayGateway:(NSString*)pay_gateway
                                       objectType:(NSString*)object_type
                                         objectId:(NSString*)object_id
                                          subject:(NSString*)subject
                                         totalFee:(float)total_fee
                                           detail:(NSString*)detail
                                         callback:(callBack)callback withView:(UIView *)view
{

    NSString * api = payment_transactions;
    NSString * parameter = [NSString stringWithFormat:@"?pay_gateway=%@&object_type=%@&object_id=%@",pay_gateway,object_type,object_id];
    parameter = [parameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    //请求
//    NSString * str = [RequestUtils requestWithPostApiAndParameter:parameter withUrl:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:parameter withUrl:url withCallBack:callback method:@"POST" withView:view];
    return nil;
}

//移除认证信息
-(void) removeHttpCredentials
{
    NSURLCredentialStorage *credentialsStorage = [NSURLCredentialStorage sharedCredentialStorage];
    
    NSDictionary *allCredentials = [credentialsStorage allCredentials];
    NSLog(@"移除前:%@",allCredentials);
    //iterate through all credentials to find the twitter host
    for (NSURLProtectionSpace *protectionSpace in allCredentials)
        if ([[protectionSpace host] isEqualToString:SERVER_ADDR]){
            //to get the twitter's credentials
            NSDictionary *credentials = [credentialsStorage credentialsForProtectionSpace:protectionSpace];
            //iterate through twitter's credentials, and erase them all
            for (NSString *credentialKey in credentials)
                [credentialsStorage removeCredential:[credentials objectForKey:credentialKey] forProtectionSpace:protectionSpace];
    }
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSLog(@"cookies:%@",cookies);
    for (int i = 0; i < [cookies count]; i++) {
        NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        NSLog(@"cookie %d ==== %@", i, cookie);
    }
    NSLog(@"移除后：%@",[credentialsStorage allCredentials]);
}

//获取认证信息
-(NSURLCredential*)getCredentiaWithSpace:(NSURLProtectionSpace *)protectionSpace
{
    NSURLCredentialStorage * credentialStorage = [NSURLCredentialStorage sharedCredentialStorage];
    NSDictionary * credentials = [credentialStorage allCredentials];
    NSLog(@"移除前：%@",credentials);

    NSURLCredential * credential = [[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:protectionSpace];
    return credential;
}

//-(void) saveWithUid:(NSString*)userId andPassword:(NSString*)password {
//    NSLog(@"userId:%@",userId);
//    NSLog(@"password:%@",password);
//    return;
//    
//    NSURLProtectionSpace * protectionSpace = [[NSURLProtectionSpace alloc] initWithHost: SERVER_ADDR
//                                                                                   port: 80
//                                                                               protocol: @"http"
//                                                                                  realm: @"caidancf.com"
//                                                                   authenticationMethod: NSURLAuthenticationMethodHTTPDigest];
//    
////	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential: [NSURLCredential credentialWithUser: userId
////																									   password: password
////																									persistence: NSURLCredentialPersistenceForSession]
////	 
////														forProtectionSpace: protectionSpace];
//    
//    
//    [[NSURLCredentialStorage sharedCredentialStorage] setCredential:[NSURLCredential credentialWithUser: userId
//                                                                                              password: password
//                                                                                            persistence: NSURLCredentialPersistenceForSession]
//                                                 forProtectionSpace:protectionSpace];
//  
//    
////    NSDictionary * dic1 = [[NSURLCredentialStorage sharedCredentialStorage] allCredentials];
//    
//    
//    //以下为真机
////	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential: [NSURLCredential credentialWithUser: userId
////																									   password: password
////																									persistence: NSURLCredentialPersistencePermanent]
////	 
////														forProtectionSpace: protectionSpace];
//}


//获取理财产品
+(NSDictionary*)getfinancialMarketsWithAreaID:(NSString*)area_id partyId:(id)party_id period:(NSString*)period threshold:(NSString*)threshold page:(int)page keywork:(NSString*)keyword types:(NSString *)types
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
//    if (types.length != 0) {
//        [NSString stringWithFormat:@"%@"];
//    }
    NSString * url = [NSString stringWithFormat:@"%@%@%@",SERVER_ADDR_HTTP,api,parameter];
    NSString * str = [self requestWithGet:url];
//    NSLog(@"获取理财产品:%@", str);
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    
    return dic;
}

//获取理财产品详情
-(NSDictionary*)getfinancialInfoWithProductId:(NSString*)productId Callback:(callBack)callback  withView:(UIView*)view
{
    NSString * api = [NSString stringWithFormat:financial_products_info,productId];
    NSString * account =  [Utils getAccount];
    NSString * url;
    if (account.length == 0) {
        url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
        NSString * str = [RequestUtils requestWithGet:url];
        SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
        NSDictionary* dic = [jsonParser objectWithString:str];
        callback(dic);
    } else {
        url = [NSString stringWithFormat:@"%@%@?for_user=%@",SERVER_ADDR_HTTP, api, account];
        Request * request = [[[Request alloc] init] autorelease];
        [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callback method:@"GET" withView:view];
    }
    
//    NSString * str = [RequestUtils requestWithGet:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    
    return nil;
}

//查询基础利率
+(NSDictionary*)getBaseInterestRatesWithCallback:(callBack)callback  withView:(UIView*)view
{
    NSString * api = base_interest_rates;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
//    NSString * str = [self requestWithGet:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callback method:@"GET" withView:view];
    return nil;
}

//添加收藏
+(NSDictionary*)addFavoritesWithObjectType:(NSString *) object_type withObjectId:(NSString *)object_id callback:(callBack)callBack  withView:(UIView*)view
{
    
    NSString * api = profile_favorites;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
    NSString * parameter = [NSString stringWithFormat:@"?object_type=%@&object_id=%@", object_type, object_id];
//    NSString * str = [self requestWithPostApiAndParameter:parameter withUrl:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:parameter withUrl:url withCallBack:callBack method:@"POST" withView:view];
    return nil;
}

//取消收藏
+(NSDictionary*)deleteFavoritesWithObjectType:(NSString*)objectType andObjectId:(NSString*)objectId callback:(callBack)callback  withView:(UIView*)view
{
    NSString * api = [NSString stringWithFormat:cancel_favorites, objectType, objectId];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
//    NSString * str = [self requestWithPostApiAndParameter:@"" withUrl:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callback method:@"POST" withView:view];
    return nil;
}

//我的收藏
+(NSDictionary*)getFavoritesProductsCallback:(callBack)callback  withView:(UIView*)view
{
    //添加
    NSString * api = favorites;
    NSString * url = [NSString stringWithFormat:@"%@%@", SERVER_ADDR_HTTP, api];
//    NSString * str =  [self requestWithGet:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callback method:@"GET" withView:view];
    return nil;
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
    
    NSMutableDictionary * cityCity = nil;
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
+(NSDictionary*)registerWithName:(NSString*)name password:(NSString*)password smsVerify:(NSString*)smsVerify callback:(callBack)callback  withView:(UIView*)view
{
    NSString * api = user_register;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    NSString * parameter = [NSString stringWithFormat:@"?mobile_phone=%@&user[password]=%@&verify_code=%@",name,password,smsVerify];
//    NSString * str = [self requestWithPostApiAndParameter:parameter withUrl:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:parameter withUrl:url withCallBack:callback method:@"POST" withView:view];
    return nil;
}

//查询用户基本信息
+(NSDictionary*)getUserInfoWithCallBack:(callBack)callback  withView:(UIView*)view
{
    NSString * api = user_info;
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
//    NSString * str =  [self requestWithGet:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callback method:@"GET" withView:view];
    return nil;
}

//获取私享理财推荐产品
+(NSDictionary*)getEnjoyPrivateFinanceProductsWithPage:(int)page andForUser:(NSString*)for_user callback:(callBack)callback  withView:(UIView*)view
{
    NSString * api = products_recommendation;
    NSString * parameter = nil;
    if (for_user.length == 0) {
        parameter = [NSString stringWithFormat:@"?page=%i",page];
    } else {
        parameter = [NSString stringWithFormat:@"?page=%i&for_user=%@",page,for_user];
    }
//    NSString * parameter = [NSString stringWithFormat:@"?page=%i&for_user=%@",page,for_user];
    NSString * url = [NSString stringWithFormat:@"%@%@%@",SERVER_ADDR_HTTP,api,parameter];
//    NSString * str =  [self requestWithGet:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callback method:@"GET" withView:view];
    return nil;
}

//定制私享理财推荐条件
+(NSDictionary*)customEnjoyPrivateFinanceWithAreaId:(NSString*)area_id threshold:(NSString*)threshold partyIds:(NSArray*)partys productTypes:(NSString*)productTypes callback:(callBack)callback withView:(UIView*)view
{
    NSString * partysStr = [self array2StringParameter:partys withParameterName:@"party_ids[]" andKey:@"id"];
    NSString * api = recommend_preferences;
    NSString * url = [NSString stringWithFormat:@"%@%@", SERVER_ADDR_HTTP, api];
    NSString * parameter = [NSString stringWithFormat:@"?area_id=%@&threshold=%@%@%@",area_id, threshold, partysStr,productTypes];
    NSLog(@"私享理财 定制推荐:%@",parameter);
//    NSString * str = [self requestWithPostApiAndParameter:parameter withUrl:url];
//    NSLog(@"定制str:%@",str);
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:parameter withUrl:url withCallBack:callback method:@"POST" withView:view];
    return nil;
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
+(NSDictionary*)updatePasswordWithOldPsd:(NSString *)oldPassword andNewPassword:(NSString *)newPassword callback:(callBack)callback  withView:(UIView*)view
{
    //使用用户当前输入的密码进行验证
    
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,update_password];
    NSString * parameter = [NSString stringWithFormat:@"?password=%@",newPassword];
//    NSString * str = [self requestWithPutApiAndParameter:parameter withUrl:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    Request * request = [[[Request alloc] init] autorelease];
    [request requestWithPostApiAndParameter:parameter withUrl:url withCallBack:callback method:@"PUT" withView:view];
    return nil;
}

//上传数米用户信息
+(void)uploadSumiUserInfo:(NSDictionary*)dic callback:(callBack)callback withView:(UIView*)view
{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,[NSString stringWithFormat:external_accounts,@"fund123"]];
    NSString * parameter = [NSString stringWithFormat:@"?account[username]=%@&account[identity]=%@&account[access_token]=%@&account[access_secret]=%@",[dic objectForKey:@"realName"],[dic objectForKey:@"idNumber"],[dic objectForKey:@"tokenKey"],[dic objectForKey:@"tokenSecret"]];
    Request * request = [[[Request alloc] init] autorelease];
    
    [request requestWithPostApiAndParameter:parameter withUrl:url withCallBack:callback method:@"PUT" withView:view];
}

//获取数米用户信息
+(void)getSumiUserInfoWithCallback:(callBack)callback withUIView:(UIView*)view
{
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,[NSString stringWithFormat:external_accounts,@"fund123"]];
//    NSString * str = [self requestWithGet:url];
//    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
//    NSDictionary* dic = [jsonParser objectWithString:str];
    
    Request * request = [[[Request alloc] init] autorelease];
    
    [request requestWithPostApiAndParameter:@"" withUrl:url withCallBack:callback method:@"GET" withView:view];

}


@end
