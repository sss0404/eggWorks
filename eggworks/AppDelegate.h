//
//  AppDelegate.h
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuMi_Plug.h"
#import "ShuMi_Plug_Protocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,ShuMi_Plug_Protocol>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UINavigationController * rootView;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
