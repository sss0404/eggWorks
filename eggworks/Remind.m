//
//  Remind.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/26.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "Remind.h"

@implementation Remind

@synthesize mainTitle = _mainTitle;
@synthesize devider = _devider;
@synthesize tableView = _tableView;
@synthesize tableViewDataSource = _tableViewDataSource;
@synthesize tableViewDelegate = _tableViewDelegate;

- (void)dealloc
{
    [_mainTitle release]; _mainTitle = nil;
    [_devider release]; _devider = nil;
    [_tableView release]; _tableView = nil;
    [_tableViewDataSource release]; _tableViewDataSource = nil;
    [_tableViewDelegate release]; _tableViewDelegate = nil;
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)setTableViewDataSource:(id<UITableViewDataSource>)tableViewDataSource
{
    if (_tableViewDataSource != tableViewDataSource) {
        [_tableViewDataSource release];
        _tableViewDataSource = [tableViewDataSource retain];
        _tableView.dataSource = _tableViewDataSource;
    }
}

-(void)setTableViewDelegate:(id<UITableViewDelegate>)tableViewDelegate
{
    if (_tableViewDelegate != tableViewDelegate) {
        [_tableViewDelegate release];
        _tableViewDelegate = [tableViewDelegate retain];
        _tableView.delegate = _tableViewDelegate;
    }
}


-(void)createView
{
    self.mainTitle =[[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 30)] autorelease];
//    _mainTitle.text = @"预售产品提醒";
//    _mainTitle.backgroundColor = [UIColor redColor];
    _mainTitle.textColor = title_text_color;
    [self addSubview:_mainTitle];
    
    self.devider = [[[UIView alloc] initWithFrame:CGRectMake(10, 40, 300, 2)] autorelease];
    _devider.backgroundColor = title_text_color;
    [self addSubview:_devider];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 42, 320, self.frame.size.height - 42)] autorelease];
//    _tableView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_tableView];
}

@end
