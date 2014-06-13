//
//  SettingViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14/6/5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)UITableView * tableView;
@property (nonatomic, retain)NSArray * funcArray;

@end
