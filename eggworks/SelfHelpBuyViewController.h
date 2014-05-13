//
//  SelfHelpBuyViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PhoneEasyProduct.h"

@interface SelfHelpBuyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isSelected;                                    //是否同意服务条款
    PhoneEasyProduct * currSelected;                             //当前选择的手机无忧套餐
}

@property (nonatomic, retain) UITextField * name;
@property (nonatomic, retain) UITextField * phoneNumber;
@property (nonatomic, retain) UITextField * IMEI;
@property (nonatomic, retain) UITextField * brand;
@property (nonatomic, retain) UITextField * model;
@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) UIView * getIMEIView;
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSArray * packages;


@end
