//
//  InvestmentHorizonViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-21.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 投资期限选择页面

#import "InvestmentAmountViewController.h"

@interface InvestmentHorizonViewController : InvestmentAmountViewController

@property (nonatomic, retain)CheckBox * activitys;//投资期限活期

//获取当前用户选择的投资期限
+(NSMutableDictionary*)getCurrSelectedInvestmentHorizon;
@end
