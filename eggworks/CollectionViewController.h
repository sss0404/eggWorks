//
//  CollectionViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 收藏

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface CollectionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSArray * products;//收藏的产品
@property (nonatomic, retain) AsynRuner * asynRunner;//异步发送
@end
