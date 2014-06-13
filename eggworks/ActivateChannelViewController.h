//
//  ActivateChannelViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CountdownButton.h"
#import "AsynRuner.h"

@interface ActivateChannelViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, retain) UITextField * nameTextField;
@property (nonatomic, retain) UITextField * phoneNumber;
@property (nonatomic, retain) UITextField * phoneIMEI;
@property (nonatomic, retain) UITextField * phoneModel;
@property (nonatomic, retain) UITextField * verificationCode;
@property (nonatomic, retain) AsynRuner * asynRunner;//异步发送
@property (nonatomic, retain) CountdownButton * sendSMS;
@end
