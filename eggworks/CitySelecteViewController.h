//
//  CitySelecteViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-15.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface CitySelecteViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary * currSelectedCity;//当前选择的城市
}
@property (nonatomic, retain) UITableView * cityTableVeiw;//城市选择
@property (nonatomic, retain) NSMutableArray * citiesKeys;//城市字母
//@property (nonatomic, retain) NSMutableArray * citys;
//@property (nonatomic, retain) NSDictionary * currSelectedCity;//当前选择的城市

@property(nonatomic,retain)NSMutableDictionary * citysArrayWithKey;
@property(nonatomic,retain)NSDictionary *  lastTimeSelectedCity;


@property(nonatomic, retain) AsynRuner * asynRunner;
@end
