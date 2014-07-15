//
//  RemindViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 提醒页面

#import "BaseViewController.h"
#import "Remind.h"
#import "AsynRuner.h"

@interface RemindViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) Remind * preSaleProductsRemind;
@property (nonatomic, retain) Remind * maturityProductsRemind;
@property (nonatomic, retain) NSArray * preSaleProductArray;//预售产品
@property (nonatomic, retain) NSArray * maturityProductArray;//到期产品
@property (nonatomic, retain) AsynRuner * asynRunner;

@end
