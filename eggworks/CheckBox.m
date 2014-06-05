//
//  CheckBox.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-20.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox

@synthesize selected = _selected;
@synthesize title = _title;
@synthesize btn = _btn;
@synthesize indexPath = _indexPath;
//@synthesize action = _action;
//@synthesize target = _target;

- (void)dealloc
{
    [_title release]; _title = nil;
    [_btn release]; _btn = nil;
//    [_target release]; _target = nil;
    [_indexPath release]; _indexPath = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selected = NO;
        [self createView ];
    }
    return self;
}

-(void)setCheck:(BOOL) checked
{
    self.selected = checked;
    _btn.image = [UIImage imageNamed:_selected ? @"screening_checkbox_s" : @"screening_checkbox"];
}

-(void)createView
{
    self.btn = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)] autorelease];
    _btn.image = [UIImage imageNamed:@"screening_checkbox"];
    [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    
    self.title = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width-15, 15)] autorelease];
    [self addSubview:_title];
}

-(void)btnClick:(id)sender
{
    _selected = !_selected;
    _btn.image = [UIImage imageNamed:_selected ? @"screening_checkbox_s" : @"screening_checkbox"];
}

@end
