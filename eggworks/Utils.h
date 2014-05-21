//
//  Utils.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString*)deviceString;

//设置当前付款页面的名称
+(void)setCurrPaymentPage:(NSString*)pageName;

//获取当前付款页面的名称
+(NSString*)getCurrPaymentPageName;

//获取当前的地区id
+(NSString*)getCurrRegionId;

//保存用户当前选择的城市
+(void)saveCurrCity:(NSDictionary*)city;

//获取当前选择的城市
+(NSDictionary*)getCurrSelectedCity;



//保留xx位小数
+(NSString *)newFloat:(float)value withNumber:(int)numberOfPlace;

//将字符串转化成字符串
+(NSString*)array2String:(NSArray*)array with:(NSString*)str;
@end
