//
//  MyOrderViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14/6/6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 我的保单页面

#import "BaseViewController.h"

@interface MyOrderViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSArray * myOrderArray;
@end
