//
//  ClaimsInfoInputViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//
//理赔信息填写页面

#import "BaseViewController.h"
#import "AsynRuner.h"

@interface ClaimsInfoInputViewController : BaseViewController<UIActionSheetDelegate>


@property (nonatomic, retain) UIButton *    cityBtn;//所在城市
@property (nonatomic, retain) UITextField * nameTF;//用户姓名
@property (nonatomic, retain) UITextField * phoneNumberTF;//购买时登记的号码
@property (nonatomic, retain) UITextField * connectPhoneNumberTF;//用于客服和快递联系
@property (nonatomic, retain) UIButton *    damageReasonBtn;//损坏原因
@property (nonatomic, retain) UIButton *    sendWayBtn;//送修方式
@property (nonatomic, retain) UIView * aVeiw ;
@property (nonatomic, retain) UIButton * nextBtn;
@property (nonatomic, retain) UIButton * servicePhone;
@property (nonatomic, retain) NSMutableDictionary * info;
@property (nonatomic, retain) AsynRuner * asyRunner;
@property (nonatomic, retain) NSArray * damageReasonArray;
@end
