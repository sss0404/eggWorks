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
#define anonymous_active                @"/mobile_service/orders/anonymous_active.json"
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
#define financial_products_info         @"/products/{%@}.json"
