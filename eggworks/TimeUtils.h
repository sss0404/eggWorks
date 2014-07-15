//
//  TimeUtils.h
//  eggworks
//
//  Created by 陈 海刚 on 14/7/2.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtils : NSObject

+(long long)string2LongLongWithStr:(NSString*)timeStr withFormat:(NSString*)format;

+(NSString*)longlong2StringWithLongLong:(long long) time withFormate:(NSString*)forate;

+(NSDate*)string2DateWithStr:(NSString*)timeStr withFormat:(NSString*)format;

//获取系统当前时间戳
+(long long)getCurrentTime;
@end
