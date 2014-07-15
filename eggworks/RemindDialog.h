//
//  RemindDialog.h
//  eggworks
//
//  Created by 陈 海刚 on 14/7/1.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreSaleDao.h"
#import "CheckBox.h"
#import "AsynRuner.h"

@protocol RemindSelectDialogDelegate <NSObject>

-(void)onButton:(int)buttonIndex withSelectedItem:(ProductRemindType)productRemindType withRemindDays:(int)days;

@end

@interface RemindDialog : UIView

@property (nonatomic, retain) id<RemindSelectDialogDelegate> delegate;
@property (nonatomic, retain) CheckBox * preSaleRemind;//预售产品提醒
@property (nonatomic, retain) CheckBox * maturityRemind;//产品到期提醒
@property (nonatomic, retain) UITextField * days;//
@property (nonatomic, retain) AsynRuner * asynRunner;

@end
