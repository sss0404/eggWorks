//
//  Payment.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-8.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment : NSObject

//创建支付
-(void)createPaymentWithPayGateway:(NSString*)pay_gateway objectType:(NSString*)object_type objectId:(NSString*)object_id subject:(NSString*)subject totalFee:(float)total_fee detail:(NSString*)detail;


@end
