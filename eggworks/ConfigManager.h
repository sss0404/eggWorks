//
//  ConfigManager.h
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#ifndef eggworks_ConfigManager_h
#define eggworks_ConfigManager_h



#endif


#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define CARelease(obj) { [obj release]; obj = nil; }
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]
#define ToString(o)                             [NSString stringWithFormat:@"%@", (o)]
#define IntToString(i)                          [NSString stringWithFormat:@"%d", (i)]
#define DoubleToString(i)                       [NSString stringWithFormat:@"%lf", (i)]
#define PostNotification(expr)                  ([[NSNotificationCenter defaultCenter] postNotificationName:(expr) object:nil])
#define NotificationCenter                      [NSNotificationCenter defaultCenter]
#define UserDefaultForValue(expr)               [[NSUserDefaults standardUserDefaults] objectForKey:expr]
#define kScreenSize                             [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth                            [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight                           [[UIScreen mainScreen] bounds].size.height          //包含状态bar的高度(e.g. 480)

#define kApplicationSize                        [[UIScreen mainScreen] applicationFrame].size       //(e.g. 320,460)
#define kApplicationWidth                       [[UIScreen mainScreen] applicationFrame].size.width //(e.g. 320)
#define kApplicationHeight                      [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)


#define IOS7                                    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


#define IMAGE(imagePath)                        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(imagePath) ofType:@"png"]]
#define ThemeImage(imageName) [[ThemeManager sharedInstance] imageWithImageName:(imageName)]
#define RootNav                                     [(AppDelegate*)[[UIApplication sharedApplication] delegate] rootNav]
#define Window                                  [[[UIApplication sharedApplication] delegate] window]

#define IndexBottomFuncArray                    @"IndexNote",@"IndexCollection",@"IndexAccount"
#define menu_items                              @"返回首页",@"理财集市",@"手机无忧",@"私享理财"
#define BOTTOM_HEIGHT                           55
#define IOS7_HEIGHT                             60

#define orange_btn_bg_name                      @"orange_btn_bg"
#define orange_color                            [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1]
#define divider_color                           [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1]
#define title_text_color                              RGBA(83,92,102,1)

#define SERVER_ADDR                             @"www.eggworks.cn"
#define SERVER_ADDR_HTTP                        @"http://www.eggworks.cn"

//本地存储用户数据 的key
#define ORDER_ID                                @"order_id"//手机无忧订单id
#define USER_ID                                 @"user_id"  //用户id
#define PHONE_NUMBER                            @"phoneNumber"//用户手机号
#define PASSWORD                                @"password"   //用户密码
#define HOT_CITY                                @"热门"//热门城市
#define GPS                                     @"GPS"
#define CURR_SELECTED_CITY_KEY                  @"currSelectedCity"//用户当前选择的城市
#define CURR_SELECTED_INSTITUTIONAL_KEY         @"currSelectedInstitutionalKey"//当前用户选择的机构key

#define YYYYMMDD       @"yyyy-MM-dd"
#define YYYYMMDDhhmmss       @"yyyy-MM-dd hh:mm:ss"

