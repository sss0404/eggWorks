//
//  RemindDialog.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/1.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RemindDialog.h"

@implementation RemindDialog

@synthesize preSaleRemind = _preSaleRemind;
@synthesize maturityRemind = _maturityRemind;
@synthesize days = _days;
@synthesize asynRunner = _asynRunner;

- (void)dealloc
{
    [_preSaleRemind release]; _preSaleRemind = nil;
    [_maturityRemind release]; _maturityRemind = nil;
    [_days release]; _days = nil;
    [_asynRunner release]; _asynRunner = nil;
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
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    self.backgroundColor = [UIColor colorWithRed:.97 green:.97 blue:.97 alpha:1];
    float width = self.frame.size.width;
    self.preSaleRemind = [[[CheckBox alloc] initWithFrame:CGRectMake(20, 20, width - 40, 30)]autorelease];
    _preSaleRemind.title.text = @"购买提醒";
    [_preSaleRemind addTarget:self action:@selector(item1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_preSaleRemind];
    
    UIView * diver1 = [[[UIView alloc] initWithFrame:CGRectMake(40, 47, width - 40, 1)] autorelease];
    diver1.backgroundColor = [UIColor colorWithRed:.76 green:.76 blue:.76 alpha:1];
    [self addSubview:diver1];
    
    self.maturityRemind = [[[CheckBox alloc] initWithFrame:CGRectMake(20, 60, width - 40, 30)]autorelease];
    _maturityRemind.title.text = @"产品到期提醒";
    [_maturityRemind addTarget:self action:@selector(item2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_maturityRemind];
    
    UIView * diver2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 95, width, 1)] autorelease];
    diver2.backgroundColor = [UIColor colorWithRed:.01 green:.01 blue:.01 alpha:.7];
    [self addSubview:diver2];
    
    UIView * diver3 = [[[UIView alloc] initWithFrame:CGRectMake(0,135, width, 1)] autorelease];
    diver3.backgroundColor = [UIColor colorWithRed:.01 green:.01 blue:.01 alpha:.7];
    [self addSubview:diver3];
    
    UILabel * note = [[[UILabel alloc] initWithFrame:CGRectMake(0, 95, width, 40)] autorelease];
//    [note setTitle:@"提前        天提醒" forState:UIControlStateNormal];
    note.text = @"提前                   天提醒";
    note.textColor = title_text_color;
    note.textAlignment = UITextAlignmentCenter;
    [self addSubview:note];
    
    self.days = [[[UITextField alloc] initWithFrame:CGRectMake(width/2 - 50, 95, 80, 40)] autorelease];
    _days.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_days];
    
    UIButton * confirmBtn = [[[UIButton alloc] initWithFrame:CGRectMake(40, 150, width - 80, 40)] autorelease];
    confirmBtn.backgroundColor = [UIColor colorWithRed:.89 green:.31 blue:.26 alpha:1];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
}

//购买产品提醒按钮
-(void)item1Click:(id)sender
{
    [_preSaleRemind setCheck:YES];
    [_maturityRemind setCheck:NO];
}

//产品到期提醒按钮
-(void)item2Click:(id)sender
{
    [_preSaleRemind setCheck:NO];
    [_maturityRemind setCheck:YES];
}

-(void)confirmBtnClick:(id)sender
{
    BOOL preSaleRemind =  _preSaleRemind.selected;
    BOOL maturityRemind = _maturityRemind.selected;
    NSString * day = _days.text;
    if (!preSaleRemind && !maturityRemind) {
        Show_msg(@"提醒", @"请选择一个提醒类型。");
        return;
    }
    if (day.length == 0) {
        Show_msg(@"提醒", @"请输入提前提醒天数。");
        return;
    }
    [self superview].hidden = YES;
    
    int type = 0;
    if (preSaleRemind) {
        type = preSaleType;
    }
    if (maturityRemind) {
        type = remindType;
    }
    
    [_delegate onButton:1 withSelectedItem:type withRemindDays:day.intValue];
    NSLog(@"%@", preSaleRemind ? @"第一个被选中" : @"第一个没有被选中");
    NSLog(@"%@", maturityRemind ? @"第二个被选中" : @"第二个没有被选中");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray * views = [self subviews];
    for (UIView * view in views) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}

@end
