//
//  ShuMi_Plug_Protocol.h
//  SHUMI_IOS_SDK
//
//  Created by 应晓胜 on 14-1-7.
//  Copyright (c) 2014年 应晓胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShuMi_Plug_Protocol <NSObject>

@required

/*
 商户标识
 */
- (NSString *)consumerKey;
- (NSString *)consumerSecret;

/*
 用户标识
 */
- (NSString *)tokenKey;
- (NSString *)tokenSecret;

/*
 请求服务器环境配置
 */
// 生产 ->http://jrsj1.data.fund123.cn/Trade
// 测试 ->http://192.168.2.190/Trade
- (NSString *)financialDataService;
// 生产 ->https://trade.fund123.cn/openapi
// 测试 ->http://sandbox.trade.fund123.cn/openapi
- (NSString *)tradeOpenApiService;
// 生产 ->http://openapi.fund123.cn
// 测试 ->http://sandbox.openapi.fund123.cn
- (NSString *)myFundOpenApiService;

/*
 检测更新地址
 其中xxx改成对应的名称
 */
// 生产 ->http://tools.fund123.cn/shumi_sdk/iphone_chinapay/xxx/version.json
// 测试 ->待定
- (NSString *)checkUpdateURLAddress;

@optional

// 界面UI设置----------------------------------------------------------------

/*
 状态栏背景色
 */
- (UIColor *)pluginStatusBarColor;

// 数据回调------------------------------------------------------------------

/*
 向插件提供数据 -[暂时未开放使用]
 返回的NSDictionary包含数据:
    realName = 应晓胜; --> 真实姓名
    idNumber = 33082519871014621X; -->用户身份证
    email = y7076580@sina.com; -->邮箱地址
    phoneNum = 13844845685; -->手机号码
    bankSerial = 002; -->银行编号
    bankName = 工商银行; -->银行名称
    bankCardNo = 6227003525540023534; -->银行卡
 */
- (NSDictionary *)providedUserInfo;

/*
 用户开户成功
 info包含数据:
    tokenKey = 0000a08ffd974254ab9449c8c8c0e190; -->用户token
    tokenSecret = 9939f00d7f214c2f8e218f41a839764c; -->用户token对应key
    userName = yingxs; -->数米用户名
    realName = 应晓胜; -->用户真实名称
    idNumber = 33082519871014621X;  -->用户身份证
    bankName = 工商银行; -->银行名称
    bankCardNo = 6227003525540023534; -->银行卡号
    bankSerial = 002;  -->银行序列号
    phoneNum = 13555845875; -->手机号码
    email = y7076580@sina.com; -->邮箱
 */
- (void)userOpenAccountSuccess:(NSDictionary *)info;

/*
 用户授权成功
 info包含数据:
    realName = 应晓胜; -->用户真实名称
    idNumber = 33082519871014621X;  -->用户身份证
    tokenKey = 0000a08ffd974254ab9449c8c8c0e190; -->用户token
    tokenSecret = 9939f00d7f214c2f8e218f41a839764c; -->用户token对应key
 */
- (void)userAuthorizeSuccess:(NSDictionary *)info;

/*
 用户新增银行卡成功
 info包含数据:
    bankName = 工商银行; -->银行名称
    bankCardNo = 6227003525540023534; -->银行卡号
    bankSerial = 002;  -->银行序列号
 */
- (void)userAddBankCardSuccess:(NSDictionary *)info;

/*
 用户申认购订单号
 info包含数据:
 applySerial ＝ 1288478324852; -->申请编号
 */
- (void)userPaymentFundSuccess:(NSDictionary *)info;

/*
 申购申请提交成功
 info包含数据:
    applySerial ＝ 1288478324852; -->申请编号
    fundCode = 020001; -->基金代码
    fundName = "国泰金鹰增长"; -->基金名称
    applySum = 100; -->申购金额
    bankCardInfo = 工商银行***1416; -->支付卡信息
    dateTime = 2013-05-10T17:56:57.396875+08:00; -->扣款时间
    bankName = 工商银行; -->银行名称
    bankAcco = 140826195608226018; -->银行卡号
 */
- (void)userPurchaseFundSuccess:(NSDictionary *)info;

/*
 认购申请提交成功
 info包含数据:
    applySerial ＝ 1288478324852; -->申请编号
    fundCode = 020001; -->基金代码
    fundName = "国泰金鹰增长"; -->基金名称
    applySum = 100; -->认购金额
    bankCardInfo = 工商银行***1416; -->支付卡信息
    dateTime = 2013-05-10T17:56:57.396875+08:00; -->扣款时间
    bankName = 工商银行; -->银行名称
    bankAcco = 140826195608226018; -->银行卡号
 */
- (void)userSubscribeFundSuccess:(NSDictionary *)info;

/*
 普通赎回申请提交成功
 info包含数据:
    applySerial ＝ 1288478324852; -->申请编号
    fundCode = 020001; -->基金代码
    fundName = "国泰金鹰增长"; -->基金名称
    applySum = 100; --> 赎回份额
    bankCardInfo = 工商银行***1416; -->关联银行卡信息
    dateTime = 2013-05-10T17:56:57.396875+08:00; -->赎回时间
 */
- (void)userNormalRedeemFundSuccess:(NSDictionary *)info;

/*
 快速赎回申请提交成功
 info包含数据:
    applySerial ＝ 1288478324852; -->申请编号
    fundCode = 020001; -->基金代码
    fundName = "国泰金鹰增长"; -->基金名称
    applySum = 100; --> 赎回份额
    bankCardInfo = 工商银行***1416; -->关联银行卡信息
    dateTime = 2013-05-10T17:56:57.396875+08:00; -->赎回时间
 */
- (void)userQuickRedeemFundSuccess:(NSDictionary *)info;

/*
 撤单申请提交成功[ps:目前此回调只有在撤销认申购或撤销赎回申请时会回调]
 info包含数据:
    applySerial ＝ 1288478324852; -->申请编号
    fundCode ＝ 020001; -->基金代码
    fundName ＝ "国泰金鹰增长"; -->基金名称
    amount ＝ 1000; --> 涉及金额
    shares ＝ 2000; --> 涉及份额
    bankCardInfo = 工商银行***1416; -->关联银行卡信息
 */
- (void)userCancelOrderSuccess:(NSDictionary *)info;

/*
 修改手机号码提交成功
 info包含数据:
 mobileNumber = 13555845875; -->新的手机号码
 */
- (void)userChangeMobileSuccess:(NSDictionary *)info;

@end
