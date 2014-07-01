//
//  FinancialProductDetailsViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//
//产品详情

#import "BaseViewController.h"
#import "financialProduct.h"
#import "AsynRuner.h"

@interface FinancialProductDetailsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, retain) financialProduct * financialProduct;
@property(nonatomic, retain) UITableView * productInfoTableView;
@property(nonatomic, retain) UIButton * productInfoBtn;//产品详情按钮
@property(nonatomic, retain) UIButton * calculateEarningsBtn;//计算收益按钮
@property(nonatomic, retain) UIButton * aboutProductsBtn;//相关产品按钮
@property(nonatomic, retain) UILabel * productName;//产品名称
@property(nonatomic, retain) UILabel * yield;//收益率
@property(nonatomic, retain) UILabel * timesLabel;//是活期收益的xx倍
@property(nonatomic, retain) UILabel * monthLastContent;//近一个月的收益率
@property(nonatomic, retain) UILabel * yearLastContent;//近一年的收益率
@property(nonatomic, retain) UIView * calculateEarningsView;//计算收益页面
@property(nonatomic, retain) UITableView * aboutProductsView;//相关产品页面
@property(nonatomic, retain) NSDictionary * productInfo;//产品详情
@property(nonatomic, retain) NSArray * aboutProducts;
@property(nonatomic, retain) UITextField * investmentAmount;
@property(nonatomic, retain) NSDictionary * baseInterestRates;//基础利率内容
@property(nonatomic, retain) UILabel * earningsLabel;
@property(nonatomic, retain) UILabel * purchaseAmount;//立即申购上面的 起购金额
@property(nonatomic, retain) UIButton * collectionBtn;//收藏按钮
@property(nonatomic, retain) UILabel * earningsResult;//预期收益计算结果

@property(nonatomic, retain) AsynRuner * asynRunner;


@end
