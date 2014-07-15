//
//  ShuMi_Plug_Data.h
//  SHUMI_IOS_SDK
//
//  Created by 应晓胜 on 14-1-7.
//  Copyright (c) 2014年 应晓胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShuMi_Plug_Data : NSObject

/*
 获取某只可交易基金信息
 返回数据demo:
 {
 "FundCode": "020001", -->基金代码
 "FundName": "国泰金鹰增长", -->基金名称
 "ShareType": "A", --> 份额类型 A:前端申购 B:后端申购
 "FundState": "0", --> 基金状态
 "FundType": "0", --> 基金类型 0:普通 1:短债 2:货币 5:QDII 8:专户产品 9:超短期理财
 "LastUpdate": "2013-05-02T11:49:02.003", --> 最后更新时间
 "DeclareState": true, -->是否支持申购
 "WithdrawState": true, -->是否支持赎回
 "ValuagrState": true, -->是否支持定投
 "SubscribeState": false, -->是否支持认购
 "TrendState": true, -->是否支持趋势定投
 "RiskLevel": 2, -->基金风险等级 0:低 1:中 2:高
 "PurchaseLimitMax": 99999999999999.00, -->最大购买金额
 "PurchaseLimitMin": 1000.00, -->最低购买金额
 "RedeemLimitMax": 0.00, -->
 "RedeemLimitMin": 0.00, -->
 "SubscribeLimitMax": 0.00, -->
 "SubscribeLimitMin": 0.00, -->
 "QuickcashLimitMax": 0.00, -->
 "QuickcashLimitMin": 0.00, -->
 "RationLimitMax": 99999999999999.00, -->
 "RationLimitMin": 100.00 -->
 }
 */
+ (NSURLConnection *)loadTradableFundInfoWithFundCode:(NSString *)fundCode block:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

/*
 获取可交易基金列表
 返回数据demo:
 [{
 "FundCode": "020001", -->基金代码
 "FundName": "国泰金鹰增长", -->基金名称
 "ShareType": "A", --> 份额类型 A:前端申购 B:后端申购
 "FundState": "0", --> 基金状态
 "FundType": "0", --> 基金类型 0:普通 1:短债 2:货币 5:QDII 8:专户产品 9:超短期理财
 "LastUpdate": "2013-05-02T11:49:02.003", --> 最后更新时间
 "DeclareState": true, -->是否支持申购
 "WithdrawState": true, -->是否支持赎回
 "ValuagrState": true, -->是否支持定投
 "SubscribeState": false, -->是否支持认购
 "TrendState": true, -->是否支持趋势定投
 "RiskLevel": 2, -->基金风险等级 0:低 1:中 2:高
 "PurchaseLimitMax": 99999999999999.00, -->最大购买金额
 "PurchaseLimitMin": 1000.00, -->最低购买金额
 "RedeemLimitMax": 0.00, -->
 "RedeemLimitMin": 0.00, -->
 "SubscribeLimitMax": 0.00, -->
 "SubscribeLimitMin": 0.00, -->
 "QuickcashLimitMax": 0.00, -->
 "QuickcashLimitMin": 0.00, -->
 "RationLimitMax": 99999999999999.00, -->
 "RationLimitMin": 100.00 -->
 },
 ...
 ]
 */
+ (NSURLConnection *)loadTradableFunds:(void (^)(BOOL success, NSError * error, NSArray * parsedData))block;

/*
 获取用户已经绑定的银行卡
 返回数据demo:
 [
 {
 "No": "912739172312333333", -->银行卡号
 "TradeAccount": "0299", -->基金交易账号
 "SubTradeAccount": "0299;", -->
 "IsVaild": true, -->卡是否已经通过验证
 "Balance": 0.0, -->每日额度限制，如果为0则说明没有限制
 "Status": "0", -->卡的状态
 "StatusToCN": "正常", -->卡状态对应的说明
 "IsFreeze": false, -->是否被冻结
 "BankSerial": "005", -->银行编号
 "BankName": "建设银行", -->银行名称
 "CapitalMode": "6", -->绑卡渠道
 "BindWay": "0", -->绑卡方式
 "SupportAutoPay": true, -->
 "DiscountRate": 0.40, -->购买时折扣
 "LimitDescribe": "单笔50万元，日累计50万元", -->限制描述
 "ContentDescribe": "必须开通网上银行(U盾或动态口令)" -->
 },
 ...
 ]
 */
+ (NSURLConnection *)loadUserBindedCards:(void (^)(BOOL success, NSError * error, NSArray * parsedData))block;

/*
 获取用户持仓数据
 返回数据demo:
 [{
 "TradeAccount": "0031", -->交易账号
 "FundCode": "020002", -->基金代码
 "FundName": "国泰金龙债券A类", -->基金名称
 "ShareType": "A", -->份额类型 A:前端申购 B:后端申购
 "CurrentRemainShare": 145357.83, -->持有份额
 "UsableRemainShare": 145357.83, -->可用份额
 "FreezeRemainShare": 0.0, -->冻结份额
 "MelonMethod": 1, -->分红方式
 "TfreezeRemainShare": 0.0, -->
 "ExpireShares": 145357.83, -->
 "UnpaidIncome": 0.0, -->未付收益
 "PernetValue": 0.98, -->净值涨幅
 "MarketValue": 142450.67339999997, -->市值
 "NavDate": "2013-05-02", -->净值日期
 "BankAccount": "8986", -->银行账号后4位
 "BankName": "建设银行", -->银行名称
 "BankSerial": "005" -->银行编号
 "FundType": "0", -->基金类型
 "FundTypeToCN": "股票型", -->基金类型对应名称
 "RapidRedeem": false -->是否支持T+0赎回
 },
 ...
 ]
 */
+ (NSURLConnection *)loadUserFundShares:(void (^)(BOOL success, NSError * error, NSArray * parsedData))block;

/*
 获取用户真实持仓总收益概况
 返回数据demo:
 {
 SystemDay - > 系统时间
 CurrDay  - > 净值日[数米自定义日期概念，下午4点后指今天，下午4点前指昨天]
 TotalHoldGatherNum - > 总统计项
 HadNetValueHoldGatherNum - > 已更新统计项
 HoldCost   - > 持仓本金
 CityValue  - > 市值
 TodayIncome  - > 今日收益(昨日收益)
 HoldIncome  - > 收益
 HoldIncomeRate  - > 收益率
 }
 */
+ (NSURLConnection *)loadUserRealPartitionIncome:(void (^)(BOOL requestSuccess,NSError * error, NSDictionary * parsedData))block;

/*
 获取用户真实账本持仓详细信息
 返回数据demo
 [
 {
 FundName -> 基金名称
 FundCode -> 基金代码
 CityValue -> 市值
 HoldCost -> 持仓本金
 HadRedeemValue -> 已赎回金额
 TodayIncome -> 今日盈亏(昨日盈亏)
 TotalIncome -> 持仓盈亏
 HoldQuotient -> 持有份额
 HoldIncomeRate -> 持仓收益率
 CurrDate -> 净值日[数米自定义日期概念，下午4点后指今天，下午4点前指昨天]
 NetValueDate -> 净值日期
 SystemDate -> 系统时间
 NetValue -> 基金净值 诺为货币则代表万份收益
 FundType -> 基金类型 0 开放式 1 货币
 NetValueParcent -> 净值增长率 诺为货币则代表七日年化
 HadRedeemQuotient -> 已经赎回金额
 IfHadCurrNetValue -> 是否已经出净值
 }
 ...
 ]
 */
+ (NSURLConnection *)loadUserRealPartitionDetailFundsIncome:(void (^)(BOOL requestSuccess,NSError * error, NSArray * parsedData))block;

/*
 获取用户交易记录
 返回数据demo:
 {
 "Total": 0,
 "Items": [
 {
 "FundCode": "020001", -->基金代码
 "FundName": "国泰金鹰增长", -->基金名称
 "BankSerial": "005", --> 银行编号
 "BankName": "中国银行" -->银行名称
 "BankAccount": "912739172312333333", -->银行卡号
 "TradeAccount": "0299", -->交易账号
 "ShareType": "A", -->份额类型
 "ApplyDateTime": "2013-05-14T17:10:50", -->申请时时间
 "BusinessType": "001", -->业务类型
 "Amount": 0.0, -->涉及金额
 "Shares": 0.0, -->涉及份额
 "Status": 9, ->申请状态
 "PayResult":200, ->支付状态  200:表示扣款成功 101:表示扣款失败 0:未发送扣款指令 1:已发送，未校验
 "ApplySerial": "20130515000141", -->申请编号
 "CanCancel": true -->是否可撤销
 },
 ...
 ]
 }
 */
+ (NSURLConnection *)loadUserTradeRecordsWithStartTime:(NSString *)startTime endTime:(NSString *)endTime pageIndex:(int)pageIndex pageSize:(int)pageSize finishedBlock:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

/*
 根据申请状态获取用户交易记录
 返回数据demo:
 {
 "Total": 0,
 "Items": [
 {
 "FundCode": "020001", -->基金代码
 "FundName": "国泰金鹰增长", -->基金名称
 "BankSerial": "005", --> 银行编号
 "BankName": "中国银行" -->银行名称
 "BankAccount": "912739172312333333", -->银行卡号
 "TradeAccount": "0299", -->交易账号
 "ShareType": "A", -->份额类型
 "ApplyDateTime": "2013-05-14T17:10:50", -->申请时时间
 "BusinessType": "001", -->业务类型
 "Amount": 0.0, -->涉及金额
 "Shares": 0.0, -->涉及份额
 "Status": 9, ->申请状态
 "PayResult":200, ->支付状态  200:表示扣款成功 101:表示扣款失败 0:未发送扣款指令 1:已发送，未校验
 "ApplySerial": "20130515000141", -->申请编号
 "CanCancel": true -->是否可撤销
 },
 ...
 ]
 }
 */
+ (NSURLConnection *)loadUserTradeRecordsWithStatus:(NSString *)status startTime:(NSString *)startTime endTime:(NSString *)endTime pageIndex:(int)pageIndex pageSize:(int)pageSize finishedBlock:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;


/*
 获取货币基金的的所有持仓
 返回数据demo:
 [{
 "TradeAccount": "0031", -->交易账号
 "FundCode": "020002", -->基金代码
 "FundName": "国泰金龙债券A类", -->基金名称
 "ShareType": "A", -->份额类型 A:前端申购 B:后端申购
 "CurrentRemainShare": 145357.83, -->持有份额
 "UsableRemainShare": 145357.83, -->可用份额
 "FreezeRemainShare": 0.0, -->冻结份额
 "MelonMethod": 1, -->分红方式
 "TfreezeRemainShare": 0.0, -->
 "ExpireShares": 145357.83, -->
 "UnpaidIncome": 0.0, -->未付收益
 "PernetValue": 0.98, -->净值涨幅
 "MarketValue": 142450.67339999997, -->市值
 "NavDate": "2013-05-02", -->净值日期
 "BankAccount": "8986", -->银行账号后4位
 "BankName": "建设银行", -->银行名称
 "BankSerial": "005" -->银行编号
 "FundType": "0", -->基金类型
 "FundTypeToCN": "股票型", -->基金类型对应名称
 "RapidRedeem": false -->是否支持T+0赎回
 },
 ...
 ]
 */
+ (NSURLConnection *)loadUserAllMonetaryFundShares:(void (^)(BOOL success, NSError * error, NSArray * parsedData))block;

/*
 获取货币基金所有交易记录
 返回数据demo:
 {
 "Total": 0,
 "Items": [
 {
 "FundCode": "020001", -->基金代码
 "FundName": "国泰货币", -->基金名称
 "BankSerial": "005", --> 银行编号
 "BankName": "中国银行" -->银行名称
 "BankAccount": "912739172312333333", -->银行卡号
 "TradeAccount": "0299", -->交易账号
 "ShareType": "A", -->份额类型
 "ApplyDateTime": "2013-05-14T17:10:50", -->申请时时间
 "BusinessType": "001", -->业务类型
 "Amount": 0.0, -->涉及金额
 "Shares": 0.0, -->涉及份额
 "Status": 9, ->申请状态
 "PayResult":200, ->支付状态  200:表示扣款成功 101:表示扣款失败 0:未发送扣款指令 1:已发送，未校验
 "ApplySerial": "20130515000141", -->申请编号
 "CanCancel": true -->是否可撤销
 },
 ...
 ]
 }
 */
+ (NSURLConnection *)loadUserMonetaryFundAllTradeRecordWithStartTime:(NSString *)startTime endTime:(NSString *)endTime pageIndex:(int)pageIndex pageSize:(int)pageSize finishedBlock:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

/*
 根据状态获取货币基金所有交易记录
 返回数据demo:
 {
 "Total": 0,
 "Items": [
 {
 "FundCode": "020001", -->基金代码
 "FundName": "国泰货币", -->基金名称
 "BankSerial": "005", --> 银行编号
 "BankName": "中国银行" -->银行名称
 "BankAccount": "912739172312333333", -->银行卡号
 "TradeAccount": "0299", -->交易账号
 "ShareType": "A", -->份额类型
 "ApplyDateTime": "2013-05-14T17:10:50", -->申请时时间
 "BusinessType": "001", -->业务类型
 "Amount": 0.0, -->涉及金额
 "Shares": 0.0, -->涉及份额
 "Status": 9, ->申请状态
 "PayResult":200, ->支付状态  200:表示扣款成功 101:表示扣款失败 0:未发送扣款指令 1:已发送，未校验
 "ApplySerial": "20130515000141", -->申请编号
 "CanCancel": true -->是否可撤销
 },
 ...
 ]
 }
 */
+ (NSURLConnection *)loadUserMonetaryFundAllTradeRecordWithStatus:(NSString *)status startTime:(NSString *)startTime endTime:(NSString *)endTime pageIndex:(int)pageIndex pageSize:(int)pageSize finishedBlock:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

/*
 获取指定某只基金交易记录
 返回数据demo:
 {
 "Total": 0,
 "Items": [
 {
 "FundCode": "020001", -->基金代码
 "FundName": "国泰货币", -->基金名称
 "BankSerial": "005", --> 银行编号
 "BankName": "中国银行" -->银行名称
 "BankAccount": "912739172312333333", -->银行卡号
 "TradeAccount": "0299", -->交易账号
 "ShareType": "A", -->份额类型
 "ApplyDateTime": "2013-05-14T17:10:50", -->申请时时间
 "BusinessType": "001", -->业务类型
 "Amount": 0.0, -->涉及金额
 "Shares": 0.0, -->涉及份额
 "Status": 9, ->申请状态
 "PayResult":200, ->支付状态  200:表示扣款成功 101:表示扣款失败 0:未发送扣款指令 1:已发送，未校验
 "ApplySerial": "20130515000141", -->申请编号
 "CanCancel": true -->是否可撤销
 },
 ...
 ]
 }
 */
+ (NSURLConnection *)loaduserTradeRecordsWithFundCode:(NSString *)fundCode startTime:(NSString *)startTime endTime:(NSString *)endTime pageIndex:(int)pageIndex pageSize:(int)pageSize finishedBlock:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

/*
 根据状态获取指定某只基金交易记录
 返回数据demo:
 {
 "Total": 0,
 "Items": [
 {
 "FundCode": "020001", -->基金代码
 "FundName": "国泰货币", -->基金名称
 "BankSerial": "005", --> 银行编号
 "BankName": "中国银行" -->银行名称
 "BankAccount": "912739172312333333", -->银行卡号
 "TradeAccount": "0299", -->交易账号
 "ShareType": "A", -->份额类型
 "ApplyDateTime": "2013-05-14T17:10:50", -->申请时时间
 "BusinessType": "001", -->业务类型
 "Amount": 0.0, -->涉及金额
 "Shares": 0.0, -->涉及份额
 "Status": 9, ->申请状态
 "PayResult":200, ->支付状态  200:表示扣款成功 101:表示扣款失败 0:未发送扣款指令 1:已发送，未校验
 "ApplySerial": "20130515000141", -->申请编号
 "CanCancel": true -->是否可撤销
 },
 ...
 ]
 }
 */
+ (NSURLConnection *)loaduserTradeRecordsWithStatus:(NSString *)status fundCode:(NSString *)fundCode startTime:(NSString *)startTime endTime:(NSString *)endTime pageIndex:(int)pageIndex pageSize:(int)pageSize finishedBlock:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

/*
 获取用户t＋0赎回限制
 返回数据demo:
 {
 "TakeLimitAmount":30000 ->每日取现金额上限
 "TakeLimitTimes" : 3 ->每日取现次数上限
 "MinimumRetained" : 300.00 ->最低持有份额
 "SingleMaxLimitAmount" : 300.0 ->单笔最大限额
 "SingleMinLimitAmount" : 300.0 ->单笔最小限额
 "TakeOverAmount" : 200.0 ->剩余取现金额
 "TakeOverTimes" : 2 ->剩余取现次数
 }
 */
+ (NSURLConnection *)loadUserQuickRedeemLimits:(NSString *)fundCode finishedBlock:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

/*
 获取用户在途申请金额和份额
 返回数据demo:
 {
 "ApplySum":1000.00,
 "ApplyShare":3000.00
 }
 */
+ (NSURLConnection *)loadUserApplySumAndShareInTransit:(void (^)(BOOL success, NSError * error, NSDictionary * parsedData))block;

@end
