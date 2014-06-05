//
//  MyAccountViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 我的账户

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface MyAccountViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) UILabel * name;
@property (nonatomic, retain) NSMutableDictionary * dic; //tableview中的数据
@property (nonatomic, retain) AsynRuner * asynRunner;//异步发送

@property (nonatomic, retain) NSDictionary * userInfo;
@end
