//
//  RegisterViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"
#import "CountdownButton.h"
#import "AsynRuner.h"
#import "CheckBox.h"

@interface RegisterViewController : BaseViewController

@property (nonatomic, retain) CountdownButton * sendSMS;
@property (nonatomic, retain) UITextField * account;
@property (nonatomic, retain) UITextField * verify;//短信验证码
@property (nonatomic, retain) UITextField * password;//密码
@property (nonatomic, retain) UITextField * conPassword;//确认密码
@property (nonatomic, retain) AsynRuner * asynRunner;//异步发送
@property (nonatomic, retain) CheckBox * agress;//同意按钮

@end
