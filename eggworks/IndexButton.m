//
//  BaseButton.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "IndexButton.h"

@implementation IndexButton

@synthesize funcName = _funcName;
@synthesize funcImg = _funcImg;
@synthesize describtion = _describtion;

- (void)dealloc
{
    [_funcName release]; _funcName = nil;
    [_funcImg release]; _funcImg = nil;
    [_describtion release]; _describtion = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}

-(void)createView
{
    CGSize size = self.frame.size;
    
    self.funcImg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)] autorelease];
    _funcImg.contentMode = UIViewContentModeCenter;
    [self addSubview:_funcImg];
    
    self.funcName = [[UILabel alloc] initWithFrame:CGRectMake(7,0, size.width-7, 25)];
    _funcName.textColor = [UIColor whiteColor];
    _funcName.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
    [self addSubview:_funcName];
    
    self.describtion = [[[UILabel alloc] initWithFrame:CGRectMake(5, size.height-25, size.width-5, 30)] autorelease];
    _describtion.textColor = [UIColor whiteColor];
    _describtion.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:11];
    [self addSubview:_describtion];
}

@end
