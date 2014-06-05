//
//  InstitutionalChoiceViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-20.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//机构选择

#import "BaseViewController.h"
#import "AsynRuner.h"
#import "CheckBox.h"

@interface InstitutionalChoiceViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
 
@property (nonatomic, retain) AsynRuner * asynRunner;
@property (nonatomic, retain) UITextField * searchInputTextField;
@property (nonatomic, retain) CheckBox * bank;//筛选  银行
@property (nonatomic, retain) CheckBox * fund;//基金
@property (nonatomic, retain) CheckBox * securities;//证券
@property (nonatomic, retain) CheckBox * insurance;//保险
@property (nonatomic, retain) UITableView * institutionsTableView;

@property (nonatomic, retain) UITableView * searchTableView;//搜索table
@property (nonatomic, retain) NSMutableArray * searchArray;//搜索结果
@property (nonatomic, retain) NSArray * dataFromServer;

@property(nonatomic,retain)NSMutableDictionary * institutionsArrayWithKey;
@property(nonatomic,retain)NSMutableArray * institutionsKeys;
@property (nonatomic, assign) BOOL isLoading;

+(NSArray*)getCurrSelectedInstitutional;

@end
