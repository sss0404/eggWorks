//
//  Remind.h
//  eggworks
//
//  Created by 陈 海刚 on 14/6/26.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Remind : UIView

@property (nonatomic, retain) UILabel * mainTitle;//主标题
@property (nonatomic, retain) UIView * devider;//分割线
@property (nonatomic, retain) UITableView * tableView;//列表
@property (nonatomic, retain) id<UITableViewDataSource> tableViewDataSource;
@property (nonatomic, retain) id<UITableViewDelegate> tableViewDelegate;
@end
