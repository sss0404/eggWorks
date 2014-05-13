//
//  ConfirmInformationViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PhoneEasyProduct.h"

@interface ConfirmInformationViewController : BaseViewController
{
    
}

@property(nonatomic, retain) PhoneEasyProduct * product;
@property(nonatomic, retain) NSString * name;
@property(nonatomic, retain) NSString * phoneNumber;
@property(nonatomic, retain) NSString * IMEI;
@property(nonatomic, retain) NSString * boand;
@property(nonatomic, retain) NSString * model;

@end
