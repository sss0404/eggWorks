//
//  ScreeningItem.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-15.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ScreeningItem.h"

@implementation ScreeningItem

@synthesize btn = _btn;
@synthesize label = _label;
@synthesize delegate = _delegate;
@synthesize right = _right;

- (void)dealloc
{
    [_btn release]; _btn = nil;
    [_label release]; _label = nil;
    [_right release]; _right = nil;
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

-(void)setImageRight:(BOOL)isRight;
{
    if (!isRight) {
        _right.frame = CGRectMake(200, 25, 6, 10);
//        _btn.frame = CGRectMake(100, 10, 200, 38#CGFloat height#>)
    }
}

-(void)createView
{
//    self.backgroundColor = [UIColor yellowColor];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 60, 20)];
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor redColor];
    [self addSubview:_label];
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 200, 38)];
//    _btn.backgroundColor = [UIColor greenColor];
    [_btn setTitleColor:title_text_color forState:UIControlStateNormal];
    _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    
//    screening_diver@2x
    UIImageView * sigin = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 51, 320, 9)] autorelease];
    sigin.image = [UIImage imageNamed:@"screening_diver"];
    [self addSubview:sigin];
    
    _right = [[UIImageView alloc] initWithFrame:CGRectMake(300, 25, 6, 10)];
    _right.image = [UIImage imageNamed:@"right"];
    [self addSubview:_right];
    
    
}



-(void)btnClick:(id)sender
{
    [_delegate onButtonClicked:sender withTag:self.tag];
}

@end
