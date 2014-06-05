//
//  BankChoiceViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-29.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//  银行选择

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface BankChoiceViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) AsynRuner * asynRunner;
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, assign) BOOL isLoading;
@property(nonatomic,retain)NSMutableDictionary * institutionsArrayWithKey;//当前的银行
@property(nonatomic,retain)NSMutableArray * institutionsKeys;
@property (nonatomic, retain) NSArray * dataFromServer;
@property (nonatomic, retain) NSMutableSet * bankSelected;//用户选择的银行

@end
