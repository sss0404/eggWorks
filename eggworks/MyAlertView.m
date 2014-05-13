//
//  MyAlertView.m
//  IRA
//
//  Created by 陈 海刚 on 13-12-9.
//  Copyright (c) 2013年 visionet. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

@synthesize btnClickHandler;

-(void) showMessage:(NSString*)msg withTitle:(NSString*)title withCancelBtnTitle:(NSString*)cancelBtnTitle withBtnClick:(void(^)(NSInteger buttonIndex))handler otherButtonTitles:(NSString*)otherButtonTitles
{
    self.btnClickHandler = handler;
    UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelBtnTitle otherButtonTitles:otherButtonTitles,nil] autorelease];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ((void(^)(NSInteger buttonIndex)) btnClickHandler)(buttonIndex);
}

@end
