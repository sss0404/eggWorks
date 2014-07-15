//
//  AppDelegate.m
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexPageViewController.h"

#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "Utils.h"
#import "RequestUtils.h"
#import "FirstViewController.h"
#import "PreSaleDao.h"
#import "TimeUtils.h"

@implementation AppDelegate
{
    NSString *_authorizedToken;
    NSString *_tokenSecret;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize rootView = _rootView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    PreSaleDao * psd = [[[PreSaleDao alloc] init] autorelease];
    [psd createTable];
    
    //初始化数米sdk
    [self initShumiSDK];

//    long long time = [TimeUtils string2LongLongWithStr:@"2014-7-2" withFormat:@"yyyy-MM-dd"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    BOOL isFirstUse = [self checkFirstUseThisApp];
//    isFirstUse = YES;//测试第一次使用  暂时设定是第一次使用
    if (isFirstUse) {
        FirstViewController * firstVC = [[[FirstViewController alloc] init] autorelease];
         self.rootView = [[[UINavigationController alloc] initWithRootViewController:firstVC] autorelease];
        self.window.rootViewController = _rootView;
        
    } else {
        IndexPageViewController * indexPageViewController = [[[IndexPageViewController alloc] init] autorelease];
        self.rootView = [[[UINavigationController alloc] initWithRootViewController:indexPageViewController] autorelease];
        self.window.rootViewController = _rootView;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}







//检测是否第一次使用app
-(BOOL)checkFirstUseThisApp
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * firstUse = [userDefault objectForKey:@"firstUseThisApp"];
    if (firstUse.length == 0) {
        RequestUtils * requestUtil = [[[RequestUtils alloc] init] autorelease];
        [requestUtil removeHttpCredentials];
        [userDefault setObject:@"nofirstuse" forKey:@"firstUseThisApp"];
        [userDefault synchronize];
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //检查数米sdk更新
    [[ShuMi_Plug sharedShuMiPlug] checkShuMiPlug];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"eggworks" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"eggworks.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parse:url application:application];
	return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    NSString * currPaymentPage = [Utils getCurrPaymentPageName];
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
            [[NSNotificationCenter defaultCenter] postNotificationName:currPaymentPage object:@"交易成功"];
            
        }
        else
        {
            //交易失败
            NSLog(@"交易失败1=%i",result.statusCode);
            [[NSNotificationCenter defaultCenter] postNotificationName:currPaymentPage object:result];
        }
    }
    else
    {
        //失败
        NSLog(@"交易失败2");
    }
    
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
}


//粟米sdk初始化
-(void)initShumiSDK
{
    [[ShuMi_Plug sharedShuMiPlug] initShuMiPlugWithDelegate:self appRootViewController:self.rootView];
}

#pragma mark - 数米sdk delegate

/*
 商户标识
 */
- (NSString *)consumerKey
{
    return @"iphone_smb";
}

- (NSString *)consumerSecret
{
    return @"iphone_smb";
}

/*
 用户标识
 */
- (NSString *)tokenKey
{
    BOOL binded = [[[NSUserDefaults standardUserDefaults] objectForKey:@"binded"] boolValue];
    if(binded){
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"authorizedToken"];
    }else{
        return nil;
    }
}
- (NSString *)tokenSecret
{
    BOOL binded = [[[NSUserDefaults standardUserDefaults] objectForKey:@"binded"] boolValue];
    if(binded){
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"tokenSecret"];
    }else{
        return nil;
    }
}

/*
 请求服务器环境配置
 */
// 生产 ->http://jrsj1.data.fund123.cn/Trade
// 测试 ->http://192.168.2.190/Trade
- (NSString *)financialDataService
{
    return @"http://jrsj1.data.fund123.cn/Trade";
}
// 生产 ->https://trade.fund123.cn/openapi
// 测试 ->http://sandbox.trade.fund123.cn/openapi
- (NSString *)tradeOpenApiService
{
    return @"http://sandbox.trade.fund123.cn/openapi";
}
// 生产 ->http://openapi.fund123.cn
// 测试 ->http://sandbox.openapi.fund123.cn
- (NSString *)myFundOpenApiService
{
    return @"http://sandbox.openapi.fund123.cn";
}

-(void)userAuthorizeSuccess:(NSDictionary *)info
{
    _authorizedToken = [[info objectForKey:@"tokenKey"] copy];
    //    _authorizedToken = [[info objectForKey:@"authorizedToken"] copy];
    _tokenSecret = [[info objectForKey:@"tokenSecret"] copy];
    [[NSUserDefaults standardUserDefaults] setValue:_authorizedToken forKey:@"authorizedToken"];
    [[NSUserDefaults standardUserDefaults] setValue:_tokenSecret forKey:@"tokenSecret"];
    BOOL binded = YES;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:binded] forKey:@"binded"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[info objectForKey:@"realName"] forKey:@"realName"];
    [[NSUserDefaults standardUserDefaults] setValue:[info objectForKey:@"idNumber"] forKey:@"idNumber"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onNotification" object:nil];
}



- (void)userRedeemFundSuccess:(NSDictionary *)info{
    //赎回信息返回
    NSLog(@"%@",info);
}

- (void)userPaymentFundSuccess:(NSDictionary *)info{
    //申认购订单号成功返回
    NSLog(@"%@",info);
}

- (void)userPurchaseFundSuccess:(NSDictionary *)info{
    //认/申购信息返回
    NSLog(@"%@",info);
}

- (void)userChangeMobileSuccess:(NSDictionary *)info{
    //修改手机号码通知返回
    NSLog(@"%@",info);
}



/*
 检测更新地址
 其中xxx改成对应的名称
 */
// 生产 ->http://tools.fund123.cn/shumi_sdk/iphone_chinapay/xxx/version.json
// 测试 ->待定
- (NSString *)checkUpdateURLAddress
{
    return @"http://tools.fund123.cn/shumi_sdk/iphone_chinapay/xxx/version.json";
}

@end
