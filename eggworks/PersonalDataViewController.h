//
//  PersonalDataViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-23.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonalDataViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSDictionary * userInfo;
@end
