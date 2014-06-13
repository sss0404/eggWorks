//
//  ModifyPassViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14/6/5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface ModifyPassViewController : BaseViewController


@property (nonatomic, retain)UITextField * oldPassword;
@property (nonatomic, retain)UITextField * newPassword;
@property (nonatomic, retain)UITextField * configNewPassword;
@property (nonatomic, retain)AsynRuner * asyrunner;
@end
