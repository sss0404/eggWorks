//
//  Payment.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-8.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "Payment.h"
#import "RequestUtils.h"
#import "AlixLibService.h"


@implementation Payment

- (void)dealloc
{
    [super dealloc];
}

//创建支付
-(void)createPaymentWithPayGateway:(NSString*)pay_gateway objectType:(NSString*)object_type objectId:(NSString*)object_id subject:(NSString*)subject totalFee:(float)total_fee detail:(NSString*)detail
{
    RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
    [requestUtils paymentTransactionsWithPayGateway:pay_gateway
                                        objectType:object_type
                                          objectId:object_id
                                           subject:subject
                                          totalFee:total_fee
                                            detail:detail
                                           callback:^(id paymentResult) {
                                                BOOL success = [[paymentResult objectForKey:@"success"] boolValue];
                                                //创建保单失败
                                                if (!success) {
                                                    NSString * message = [paymentResult objectForKey:@"message"];
                                                    Show_msg(@"提示", message);
                                                    return;
                                                }
                                                //创建保单成功
                                                NSString * id_ = [paymentResult objectForKey:@"id"];//生成的支付交易的 ID
                                                NSString * order_info = [paymentResult objectForKey:@"order_info"];//调用支付宝接口时需要的订单信息参数
                                                NSString * sign_type = [paymentResult objectForKey:@"sign_type"];//签名方式
                                                NSString * sign = [paymentResult objectForKey:@"sign"];//签名
                                                NSString * notify_url = [paymentResult objectForKey:@"notify_url"];//服务器异步通知路径
                                                //调用支付宝
                                                NSString *appScheme = @"eggworks";
                                                [AlixLibService payOrder:order_info AndScheme:appScheme seletor:@selector(paymentResultDo:) target:self];
                                            } withView:nil];
    
    
}




-(void)paymentResultDo:(NSString*)result
{
    NSLog(@"result");
}
@end
