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
@synthesize HUD = _HUD;

- (void)dealloc
{
    [_HUD release]; _HUD = nil;
    [runBackgroundHandler release]; runBackgroundHandler = nil;
    [updateUIHandler release]; updateUIHandler = nil;
    [super dealloc];
}

-(void)runOnBackground:(id (^)())handler onUpdateUI:(void(^)(id obj))UpdateUIHandler inView:(UIView*)view
{
    self.HUD = [[[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
    [view addSubview:_HUD];
    
    self.runBackgroundHandler = handler;
    self.updateUIHandler = UpdateUIHandler;
//    [self performSelectorInBackground:@selector(background) withObject:nil];
    [_HUD showWhileExecuting:@selector(background) onTarget:self withObject:nil animated:YES];
    
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
