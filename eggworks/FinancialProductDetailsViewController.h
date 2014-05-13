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

@interface FinancialProductDetailsViewController : BaseViewController

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


@end
