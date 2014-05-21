//
//  MyselfTableViewCell.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-13.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "MyselfTableViewCell.h"

@implementation MyselfTableViewCell

@synthesize myLabel = _myLabel;
@synthesize secondLabel = _secondLabel;

- (void)dealloc
{
    [_myLabel release]; _myLabel = nil;
    [_secondLabel release]; _secondLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}

-(void)createView
{
    _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    _myLabel.backgroundColor = [UIColor whiteColor];
    _myLabel.textColor = title_text_color;
    _myLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_myLabel];
    
    UIView * temp = [[[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 0.3)] autorelease];
    temp.backgroundColor = title_text_color;
    [self addSubview:temp];
    
    _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 135, 30)];
    _secondLabel.backgroundColor = [UIColor clearColor];
    _secondLabel.textColor = title_text_color;
    _secondLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_secondLabel];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
