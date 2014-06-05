//
//  EnjoyPrivateFinanceViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-26.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 私享理财

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface EnjoyPrivateFinanceViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isLoadState;
}
@property (nonatomic, retain) UITableView * tableView;
//@property (nonatomic, retain) NSMutableArray * array;
@property (nonatomic, retain) NSMutableArray * financialProductss;
@property (nonatomic, retain) NSDictionary * currData;//从服务器获取的原始数据
@property (nonatomic, retain) AsynRuner * asynRunner;//异步发送
@end
