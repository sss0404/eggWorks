//
//  ActivateChannelViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ActivateChannelViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, retain) UITextField * nameTextField;
@property (nonatomic, retain) UITextField * phoneNumber;
@property (nonatomic, retain) UITextField * phoneIMEI;
@property (nonatomic, retain) UITextField * phoneModel;
@end
