//
//  ShuMiDetailViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14/7/4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAccountViewController.h"

@interface ShuMiDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, assign) SuMi suMi;
@property (nonatomic, retain) NSArray * array;
@property (nonatomic, retain) NSDictionary* bussesTypeDic;
@end
