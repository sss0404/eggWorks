//
//  ScreeningMainPageViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-15.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"
#import "ScreeningItem.h"
#import "AsynRuner.h"

@interface ScreeningMainPageViewController : BaseViewController<ScreeningItemDelegate>

@property (nonatomic, retain) UITextField * searchInputTextField;
@property (nonatomic, retain) ScreeningItem * city; //城市
@property (nonatomic, retain) ScreeningItem * institutionName;//机构名称
@property (nonatomic, retain) ScreeningItem * investments;//投资品种
@property (nonatomic, retain) ScreeningItem * investmentAmount;//投资金额
@property (nonatomic, retain) ScreeningItem * investmentHorizon;//投资期限

@property(nonatomic, retain) AsynRuner * asynRunner;

@end
