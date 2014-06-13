//
//  APIs.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#ifndef eggworks_APIs_h
#define eggworks_APIs_h



#endif

//手机保险接口

//匿名用户激活服务
#define anonymous_active                @"/mobile_service/orders/active.json"
//查询手机无忧产品
#define mobile_service_products         @"/mobile_service/products.json"
//匿名用户自助申购服务
#define anonymous_create                @"/mobile_service/orders/anonymous_create.json"
//查询当前服务协议
#define orders_json                          @"/mobile_service/orders.json"
//理赔申请
#define claim_requests                  @"/mobile_service/orders/%@/claim_requests.json"
//创建支付交易
#define payment_transactions            @"/payment_transactions.json"

//=====================================理财产品api
//获取理财产品
#define financial_market_products       @"/products.json"
//理财产品详情
#define financial_products_info         @"/products/%@.json"
//查询基础利率
#define base_interest_rates             @"/master_data/base_interest_rates.json"
//收藏
#define profile_favorites               @"/profile/favorites.json"
//取消收藏
#define cancel_favorites                @"/profile/favorites/%@/%@/delete.json"//@"/profile/favorites/%@/%@"
//获取私享理财列表
#define products_recommendation         @"/market/invest_products/recommendation.json"
//定制私享理财推荐条件
#define recommend_preferences           @"/profile/recommend_preferences.json"

//======================================基础数据接口=====
//获取所有城市
#define areas_cities                    @"/areas/cities.json"
//获取当前用户所在城市
#define city_of_ip                      @"/areas/city_of_ip.json"
//查询机构
#define  institutions_parties           @"/parties.json"
//用户注册
#define user_register                   @"/users.json"
//发送短信验证
#define send_sms_verify                 @"/sms_verify_code.json"
//=======================================用户基本信息
//查询用户基本信息
#define user_info                       @"/my.json"
//查询用户收藏的产品
#define favorites                       @"/profile/favorites.json"
//查询手机损坏原因
#define damage_reason                   @"/codes.json"
//修改密码
#define update_password                 @"/profile/passwords.json"


