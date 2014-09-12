///
//  Utils.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "Utils.h"
#import "sys/utsname.h"
#import "ZCActionOnCalendar.h"
#import "TimeUtils.h"

@implementation Utils

+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"] || [deviceString isEqualToString:@"iPhone3,2"]|| [deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"] || [deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,1"]|| [deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone5,3"]|| [deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

+(void)setCurrPaymentPage:(NSString*)pageName
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:pageName forKey:@"currPaymentPage"];
    [userDefault synchronize];
}

+(NSString*)getCurrPaymentPageName
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * currPaymentPage = [userDefault objectForKey:@"currPaymentPage"];
    return currPaymentPage;
}

//获取当前的地区id
+(NSString*)getCurrRegionId
{
    //地区id  目前不知道地区id，默认查询全部
    return @"all";
}

//保存用户当前选择的城市
+(void)saveCurrCity:(NSDictionary*)city
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:city forKey:CURR_SELECTED_CITY_KEY];
    [userDefault synchronize];
}

//获取当前选择的城市
+(NSDictionary*)getCurrSelectedCity
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary * currSelectedCity = [userDefault objectForKey:CURR_SELECTED_CITY_KEY];
    return currSelectedCity;
}

+(NSString *)formatFloat:(float)value withNumber:(int)numberOfPlace
{
    NSString *formatStr = @"%0.";
    NSString * formatStr1 = [formatStr stringByAppendingFormat:@"%df", numberOfPlace];
    NSString * formatStr2 = [NSString stringWithFormat:formatStr1, value];
//    printf("formatStr %s\n", [formatStr UTF8String]);
    
    return formatStr2;//[formatStr retain];
}


+(NSString*)array2String:(NSArray*)array with:(NSString*)str
{
    NSString * result = @"";
    for (int i=0; i<array.count; i++) {
        id data = [array objectAtIndex:i];
        if ([data isKindOfClass:[NSString class]]) {
            result = [NSString stringWithFormat:@"%@%@",data ,str];
        } else {
            result = [NSString stringWithFormat:@"%@%@%@", result,[data objectForKey:@"name"],str];
        }
        
    }
    
    return result;
}

+(NSString*)array2String:(NSArray*)array withKey:(NSString*)key andStr:(NSString*)str
{
    NSString * result = @"";
    for (int i=0; i<array.count; i++) {
        id data = [array objectAtIndex:i];
        result = [NSString stringWithFormat:@"%@%@%@", result,[data objectForKey:key],str];
    }
    
    return result;
}

//获取用户的姓名
+(NSString*)getRealName
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * real_name = [userDefault objectForKey:@"real_name"];
    NSLog(@"uid___:%@",real_name);
    return real_name;
}

//保存用户的姓名
+(void)saveRealName:(NSString*)real_name
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * result = [Utils strConversionWitd:real_name];
//    if (result.length == 0) {
//        [userDefault setObject:real_name forKey:@"real_name"];
//    }
    [userDefault setObject:result forKey:@"real_name"];
    [userDefault synchronize];
}

//获取用户登录名
+(NSString*)getAccount
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * uid = [userDefault objectForKey:USER_ID];
    NSLog(@"uid___:%@",uid);
    return uid;
}

//保持用户账号
+(void)saveAccount:(NSString *) account
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:account forKey:USER_ID];
    [userDefault synchronize];
}

//获取用户密码
+(NSString*)getPassword
{
//PASSWORD
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * password = [userDefault objectForKey:PASSWORD];
    NSLog(@"password___:%@",password);
    return password;
}

//保存用户密码
+(void)savePassword:(NSString *) password
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:password forKey:PASSWORD];
    [userDefault synchronize];
}

//保存用户id
+(void)saveIdForUser:(NSString*)uid
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:uid forKey:@"uid"];
    [userDefault synchronize];
}

//获取用户id
+(NSString*)getUid
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * uid = [userDefault objectForKey:@"uid"];
    return uid;
}

//字符串转换，  如果是空字符串则返回  空字符串  而不返回null
+(NSString*)strConversionWitd:(NSString *)str
{
    if (str == [NSNull null]) {
        str = @"";
    } else {
        if ([str isKindOfClass:[NSString class]]) {
            if (str.length == 0) {
                str = @"";
            }
        } else {
            if (str == nil) {
                str = @"";
            } else {
                str = [NSString stringWithFormat:@"%@",str];
            }
        }
    }
    
    return str;
}

//验证手机号
+(BOOL)verifyPhoneNumber:(NSString*)phoneNumber
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(170))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

+(void)setCalendarWithStartDate:(NSString*)starTime MainTitle:(NSString*)mainTitle location:(NSString*)location
{
    //暂时用作 日历添加测试
    NSDate * startData = [TimeUtils string2DateWithStr:starTime withFormat:YYYYMMDDhhmmss];
    NSString * endStr = [TimeUtils longlong2StringWithLongLong:[startData timeIntervalSince1970] + 3600 withFormate:YYYYMMDDhhmmss];
    NSDate * endDate = [TimeUtils string2DateWithStr:endStr withFormat:YYYYMMDDhhmmss];
    //设置事件之前多长时候开始提醒
    float alarmFloat=-5;
//    NSString*eventTitle=mainTitle;
//    NSString*locationStr=location;
    //isReminder 是否写入提醒事项
    [ZCActionOnCalendar saveEventStartDate:startData endDate:endDate alarm:alarmFloat eventTitle:mainTitle location:location isReminder:YES];
}
@end
