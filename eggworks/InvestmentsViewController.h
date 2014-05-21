//
//  InvestmentsViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-21.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//投资品种选择页面

#import "BaseViewController.h"
#import "CheckBox.h"

@interface InvestmentsViewController : BaseViewController

@property (nonatomic, retain) CheckBox * bankProduct;
@property (nonatomic, retain) CheckBox * fundProduct;
@property (nonatomic, retain) CheckBox * insuranceProduct;
@property (nonatomic, retain) UILabel * title_;

//获取用户选择的投资品种
+(NSMutableDictionary*)getCurrSelectedInvestments;
@end
