//
//  HomeDeliveryWayViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//快递上面

#import "ClaimsInfoInputViewController.h"

@interface HomeDeliveryWayViewController : ClaimsInfoInputViewController

@property (nonatomic, retain) UIButton * pickupTimeBtn;
@property (nonatomic, retain) UITextField * pickupAddrTF;
@property (nonatomic, retain) NSMutableDictionary * info;
@end
