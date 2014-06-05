//
//  CountdownButton.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-23.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "CountdownButton.h"

@implementation CountdownButton

@synthesize seconds = _seconds;

- (void)dealloc
{
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


-(void)stop
{
    @try {
        if (_seconds != 0) {
            [myTimer invalidate];
            _seconds = 0;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(void)start
{
    NSLog(@"开始");
    if (_seconds == 0) {
        _seconds = 60;
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    }
}

-(void)timerFired
{
    NSLog(@"seconds=%i",_seconds);
    NSString * text = [NSString stringWithFormat:@"%i秒后重新发送",_seconds];
    [self setTitle:text forState:UIControlStateNormal];
    if (_seconds == 0) {
        [myTimer invalidate];
        [self setTitle:@"发送手机校验码" forState:UIControlStateNormal];
        return;
    }
    _seconds--;
}

@end
