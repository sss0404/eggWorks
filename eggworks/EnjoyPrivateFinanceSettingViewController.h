//
//  EnjoyPrivateFinanceSettingViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-26.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 私享理财 定制页面

#import "BaseViewController.h"
#import "ScreeningItem.h"
#import "AsynRuner.h"

@interface EnjoyPrivateFinanceSettingViewController : BaseViewController<ScreeningItemDelegate>

@property (nonatomic, retain) ScreeningItem * city;
@property (nonatomic, retain) ScreeningItem * institutionName;
@property (nonatomic, retain) ScreeningItem * investmentAmount;
@property (nonatomic, retain) ScreeningItem * investments;
@property (nonatomic, retain) AsynRuner * asynRunner;

@property (nonatomic, retain) NSDictionary * citySelected;//选择的城市
@property (nonatomic, retain) NSArray * accountSelected;//资金账户
@property (nonatomic, retain) NSDictionary * investmentAmountSelected;//选择的投资金额
@property (nonatomic, retain) NSDictionary * investmentsSelected;//选择的投资品种
//@property (nonatomic, retain) ScreeningItem * 
@end
