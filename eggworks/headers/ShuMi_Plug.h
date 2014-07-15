//
//  ShuMi_Plug.h
//  ShuMi_Plug
//
//  Created by 应晓胜 on 13-4-12.
//  Copyright (c) 2013年 应晓胜. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShuMi_Plug_Protocol;

@interface ShuMi_Plug : NSObject

@property (nonatomic , retain) NSDictionary * extroInfo;
@property (nonatomic , assign , readonly) id<ShuMi_Plug_Protocol> delegate;
@property (nonatomic , retain , readonly) NSDictionary * onlineWebResourcesVersion;
@property (nonatomic , retain , readonly) UIViewController * appRootViewController;

/*
 创建ShuMi_Plug对象
 */
+ (ShuMi_Plug *)sharedShuMiPlug;

/*
 初始化并设置委托
 参数:
 delegate -> 实现ShuMi_Plug_Delegate对象
 */
- (void)initShuMiPlugWithDelegate:(id<ShuMi_Plug_Protocol>)delegate appRootViewController:(UIViewController *)appRootViewController;

/*
 检测ShuMi_Plug更新
 使用demo:
 - (void)applicationDidBecomeActive:(UIApplication *)application
 {
    [[ShuMi_Plug sharedShuMiPlug] checkShuMiPlug];
 }
 */
- (void)checkShuMiPlug;

@end
