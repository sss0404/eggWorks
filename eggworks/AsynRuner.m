//
//  AsynRuner.m
//  IRA
//
//  Created by 陈 海刚 on 13-12-9.
//  Copyright (c) 2013年 visionet. All rights reserved.
//

#import "AsynRuner.h"

@implementation AsynRuner

@synthesize runBackgroundHandler;
@synthesize updateUIHandler;

-(void)runOnBackground:(id (^)())handler onUpdateUI:(void(^)(id obj))UpdateUIHandler
{
    self.runBackgroundHandler = handler;
    self.updateUIHandler = UpdateUIHandler;
    [self performSelectorInBackground:@selector(background) withObject:nil];
}

-(void) background
{
    id obj = ((id (^)())runBackgroundHandler)();
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:obj waitUntilDone:YES];
}

-(void) updateUI:(id)obj
{
    ((void (^)())updateUIHandler)(obj);
    
}



@end
