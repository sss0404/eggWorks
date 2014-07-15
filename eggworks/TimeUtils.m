//
//  TimeUtils.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/2.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "TimeUtils.h"


@implementation TimeUtils

+(long long)string2LongLongWithStr:(NSString*)timeStr withFormat:(NSString*)format
{
    NSLog(@"需要转换的时间：%@",timeStr);
    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:format];
    NSDate * date = [dateFormatter dateFromString:timeStr];
    long long time = [date timeIntervalSince1970];
    NSLog(@"time:%lli",time);
    return time;
}

+(NSDate*)string2DateWithStr:(NSString*)timeStr withFormat:(NSString*)format
{
    NSLog(@"需要转换的时间：%@",timeStr);
    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:format];
    NSDate * date = [dateFormatter dateFromString:timeStr];
    return date;
}

+(NSString*)longlong2StringWithLongLong:(long long) time withFormate:(NSString*)forate
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:forate];
    NSDate * da = [[[NSDate alloc] initWithTimeIntervalSince1970:time] autorelease];
    NSString* localetime = [dateFormatter stringFromDate:da];
    return localetime;
}

+(long long)getCurrentTime
{
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    long long curr = [date timeIntervalSince1970];
    return curr;
}

@end
