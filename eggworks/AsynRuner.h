//
//  AsynRuner.h
//  IRA
//
//  Created by 陈 海刚 on 13-12-9.
//  Copyright (c) 2013年 visionet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface AsynRuner : NSObject
{
     id runBackgroundHandler;
     id updateUIHandler;
}

@property (nonatomic, copy)id runBackgroundHandler;
@property (nonatomic, copy)id updateUIHandler;
@property (nonatomic, retain) MBProgressHUD * HUD;



-(void)runOnBackground:(id (^)())handler onUpdateUI:(void(^)(id obj))UpdateUIHandler inView:(UIView*)view;
@end
