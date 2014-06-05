//
//  CountdownButton.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-23.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownButton : UIButton
{
    NSTimer * myTimer;
}

@property (nonatomic, assign)int seconds;

-(void)start;
-(void)stop;

@end
