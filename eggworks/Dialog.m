//
//  RemindSelectDialog.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/1.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "Dialog.h"

@implementation Dialog

@synthesize rView = _rView;

- (void)dealloc
{
    [_rView release]; _rView = nil;
    [super dealloc];
}

-(id)initWithView:(UIView*)view
{
    self.rView = view;
    return [self initWithFrame:[UIScreen mainScreen].applicationFrame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        CGSize size = [[UIScreen mainScreen] bounds].size;
        float width = size.width;
        float height = size.height;
        float x = (width - _rView.frame.size.width) / 2;
        float y = (height - _rView.frame.size.height) / 2;
        _rView.frame = CGRectMake(x, y-40, _rView.frame.size.width, _rView.frame.size.height);
        [self addSubview:_rView];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
    NSArray * views = [_rView subviews];
    for (UIView * view in views) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}


@end
