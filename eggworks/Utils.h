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
@end
