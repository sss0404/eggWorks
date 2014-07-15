//
//  ShuMi_Plug_Function.h
//  SHUMI_IOS_SDK
//
//  Created by 应晓胜 on 14-1-7.
//  Copyright (c) 2014年 应晓胜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuMi_Plug_Function : NSObject

/*
 认/申购基金接口
 参数:
 fundCode -> 认/申购基金代码
 fundName -> 认/申购基金名称
 buyAction -> 认购or申购  P: 申购 S: 认购
 */
+ (void)subscribeAndPurchaseFund:(NSString *)fundCode fundName:(NSString *)fundName buyAction:(NSString *)buyAction parentViewController:(UIViewController *)parentViewController;

/*
 普通赎回基金接口
 参数:
 fundCode -> 赎回基金代码
 fundName -> 赎回基金名称
 tradeAcco -> 交易账号
 */
+ (void)normalRedeemFund:(NSString *)fundCode fundName:(NSString *)fundName tradeAcco:(NSString *)tradeAcco parentViewController:(UIViewController *)parentViewController;

/*
 快速赎回基金接口
 参数:
 fundCode -> 赎回基金代码
 fundName -> 赎回基金名称
 tradeAcco -> 交易账号
 */
+ (void)quickRedeemFund:(NSString *)fundCode fundName:(NSString *)fundName tradeAcco:(NSString *)tradeAcco parentViewController:(UIViewController *)parentViewController;

/*
 转换基金接口(暂未实现)
 参数:
 fundcode -> 转换基金代码
 fundname -> 转换基金名称
 navCon -> UINavigationController容器
 */
+ (void)transformFund:(NSString *)fundcode fundname:(NSString *)fundname parentViewController:(UIViewController *)parentViewController;

/*
 修改分红接口(暂未实现)
 参数:
 fundCode -> 修改分红基金代码
 fundName -> 修改分红基金名称
 fundShareType -> 份额类型
 fundMelonMethod -> 分红方式
 tradeAcco -> 交易帐号
 bankCard -> 银行卡号
 bankName -> 银行名称
 */
+ (void)modifyFundDividendWay:(NSString *)fundCode fundName:(NSString *)fundName fundShareType:(NSString *)fundShareType fundMelonMethod:(NSString *)fundMelonMethod tradeAcco:(NSString *)tradeAcco bankCard:(NSString *)bankCard bankName:(NSString *)bankName parentViewController:(UIViewController *)parentViewController;

/*
 撤单(new)
 参数:
 applySerial -> 申请编号
 */
+ (void)cancelOrder:(NSString *)applySerial parentViewController:(UIViewController *)parentViewController;

/*
 撤单
 参数:
 orderNo -> 申请编号
 tradeAcco - > 基金账号
 fundName -> 基金名称
 fundCode -> 基金代码
 applySum -> 涉及金额或份额
 bankName -> 银行名称
 bankAcco -> 银行卡号
 businessName -> 业务名称
 */
+ (void)cancelOrder:(NSString *)orderNo tradeAcco:(NSString *)tradeAcco fundName:(NSString *)fundName fundCode:(NSString *)fundCode applySum:(NSString *)applySum bankName:(NSString *)bankName bankAcco:(NSString *)bankAcco businessName:(NSString *)businessName parentViewController:(UIViewController *)parentViewController;

/*
 银行卡管理
 参数:
 */
+ (void)bankCardsManager:(UIViewController *)parentViewController;

/*
 添加银行卡
 参数:
 */
+ (void)addNewBankCard:(UIViewController *)parentViewController;

/*
 解除银行卡
 参数:
 tradeAcco -> 交易账号
 bankName -> 银行名称
 bankCard -> 银行卡号
 */
+ (void)unbindBankCardWithTradeAcco:(NSString *)tradeAcco bankName:(NSString *)bankName bankCard:(NSString *)bankCard parentViewController:(UIViewController *)parentViewController;


/*
 汇付快捷验卡
 参数:
 bankName -> 银行名称
 bankCard -> 银行卡号
 limitDescribe ->限制描述
 */
+ (void)verifyBankCardUseHFQuickVerifyWithBankCard:(NSString *)bankCard bankName:(NSString *)bankName limitDescribe:(NSString *)limitDescribe parentViewController:(UIViewController *)parentViewController;

/*
 易宝小额打款验卡
 参数:
 bankName -> 银行名称
 bankCard -> 银行卡号
 limitDescribe ->限制描述
 */
+ (void)verifyBankCardUseYBPayMoneyVerifyWithBankCard:(NSString *)bankCard bankName:(NSString *)bankName limitDescribe:(NSString *)limitDescribe parentViewController:(UIViewController *)parentViewController;


/*
 用户认证授权
 */
+ (void)userAuthorize:(UIViewController *)parentViewController;


/*
 修改交易密码
 参数:
 */
+ (void)modifyTradePassword:(UIViewController *)parentViewController;

/*
 重置交易密码
 参数:
 */
+ (void)resetTradePassword:(UIViewController *)parentViewController;

/*
 修改手机号
 */
+ (void)tradeChangeSDKPhoneNumber:(UIViewController *)parentViewController;

/*
 用户身份验证
 */
+ (void)userIdentityVrification:(UIViewController *)parentViewController;


@end
