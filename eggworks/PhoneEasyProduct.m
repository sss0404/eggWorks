//
//  Product.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "PhoneEasyProduct.h"

@implementation PhoneEasyProduct

@synthesize id_ = _id_;
@synthesize name = _name;
@synthesize period = _period;
@synthesize termSummary = _termSummary;
@synthesize price = _price;
@synthesize terms = _terms;


- (void)dealloc
{
    [_id_ release]; _id_ = nil;
    [_name release]; _name = nil;
    [_period release]; _period = nil;
    [_termSummary release]; _termSummary = nil;
    [_price release]; _price = nil;
    [_terms release]; _terms = nil;
    [super dealloc];
}

@end
