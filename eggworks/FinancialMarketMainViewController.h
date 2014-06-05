//
//  FinancialMarketMainViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BottomNavigotionViewController.h"
#import "AsynRuner.h"



@interface FinancialMarketMainViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isLoadState;
    
}

@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSMutableArray * array;
@property (nonatomic, retain) NSDictionary * currData;
@property (nonatomic, retain) AsynRuner * asynrunner;
@property (nonatomic, retain) NSDictionary * obj;//用户筛选的数据
@end
