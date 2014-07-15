//
//  Request.h
//  eggworks
//
//  Created by 陈 海刚 on 14/7/10.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MBProgressHUD.h"
#import "AsynRuner.h"

typedef void(^callBack)(id data);

@interface Request : NSObject<NSURLConnectionDelegate>
{
    NSURLConnection * urlConn;
    callBack callback_;
}

@property (nonatomic, retain) NSMutableData * downloadData;
//@property (nonatomic, retain) MBProgressHUD * HUD;
@property (nonatomic, retain) AsynRuner * asynRunner;

//
-(void)requestWithPostApiAndParameter:(NSString*)apiAndParameter withUrl:(NSString*)urlStr withCallBack:(callBack)callback method:(NSString*)method withView:(UIView*)view;

@end
