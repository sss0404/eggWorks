//
//  LoginViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
// 用户登录页面

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface LoginViewController : BaseViewController

@property (nonatomic, retain) UITextField * account;//账户
@property (nonatomic, retain) UITextField * password;//密码
@property (nonatomic, retain) AsynRuner * asynRunner;//异步发送
@end
