//
//  financialProduct.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "financialProduct.h"

@implementation financialProduct

@synthesize id_ = _id_;
@synthesize name = _name;
@synthesize partyName = _partyName;
@synthesize interest = _interest;
@synthesize period = _period;
@synthesize threshold = _threshold;
@synthesize type = _type;
@synthesize arrival_days = _arrival_days;

- (void)dealloc
{
    [_id_ release]; _id_ = nil;
    [_name release]; _name = nil;
    [_partyName release]; _partyName = nil;
    [_interest release]; _interest = nil;
    [_period release]; _period = nil;
    [_threshold release]; _threshold = nil;
    [_type release]; _type = nil;
    [super dealloc];
}

@end
