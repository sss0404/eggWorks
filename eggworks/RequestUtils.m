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

@implementation RequestUtils


+(NSDictionary*)anonymousActiveWithName:(NSString*)real_name
                            mobilePhone:(NSString*)mobile_phone
                         deviceIdentity:(NSString*)device_identity
                                  brand:(NSString*)brand
                                  model:(NSString*)model
{
    NSString * apiAndParameter = [NSString stringWithFormat:@"%@?real_name=%@&mobile_phone=%@&device_identity=%@&brand=%@&model=%@", anonymous_active,real_name,mobile_phone,device_identity,brand,model];
    NSString * resultStr = [self requestWithPostApiAndParameter:apiAndParameter withUrl:SERVER_ADDR_HTTP];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
    NSDictionary* dic = [jsonParser objectWithString:resultStr];
    
    return dic;
}

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
    NSURL * url = [[[NSURL alloc] initWithString:urlStr] autorelease];
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
    return str;
}

//post请求
+(NSString*)requestWithPostApiAndParameter:(NSString*)apiAndParameter withUrl:(NSString*)urlStr
{
    NSLog(@"post请求地址：%@",urlStr);
    NSURL * url = [[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",urlStr,apiAndParameter]] autorelease];
    NSMutableURLRequest * urlRequest = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPMethod:@"POST"];
//    apiAndParameter = [apiAndParameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
    NSString * userId = [userDefault objectForKey:USER_ID];
    NSString * password = [userDefault objectForKey:PASSWORD];
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
{
    //拼接请求参数
    NSString * api = [NSString stringWithFormat:claim_requests, order_id];
    NSString * parameter = [NSString stringWithFormat:@"?order_id=%@&contact_mobil=%@&pick_method=%i&damage=%i&store_id=%@&pick_time=%i&pick_address=%@",order_id,contact_mobil,pick_method,damage,store_id,pick_time,pick_address];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP,api];
    //发送请求
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * userId = [userDefault objectForKey:USER_ID];
    NSString * password = [userDefault objectForKey:PASSWORD];
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
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * userId = [userDefault objectForKey:USER_ID];
    NSString * password = [userDefault objectForKey:PASSWORD];
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
    protectionSpace = [[NSURLProtectionSpace alloc] initWithHost: SERVER_ADDR
                                                            port: 80
                                                        protocol: @"http"
                                                           realm: @"caidancf.com"
                                            authenticationMethod: NSURLAuthenticationMethodHTTPDigest];
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
+(NSDictionary*)getfinancialMarketsWithAreaID:(NSString*)area_id partyId:(NSString*)party_id period:(NSString*)period threshold:(NSString*)threshold page:(int)page
{
    NSString * api = financial_market_products;
    NSString * parameter = [NSString stringWithFormat:@"?area_id=%@&party_id=%@&period=%@&threshold=%@&page=%i",area_id,party_id,period,threshold,page];
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
    NSString * api = [NSString stringWithFormat:financial_products_info,productId];
    NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_ADDR_HTTP, api];
    NSString * str = [RequestUtils requestWithGet:url];
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
    NSDictionary* dic = [jsonParser objectWithString:str];
    return dic;
}

@end
