//
//  CollectionTableViewCell.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-26.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell

@synthesize title = _title;
@synthesize firstItem = _firstItem;
@synthesize secondItem = _secondItem;
@synthesize threeItem = _threeItem;

- (void)dealloc
{
    [_title release]; _title = nil;
    [_firstItem release]; _firstItem = nil;
    [_secondItem release]; _secondItem = nil;
    [_threeItem release]; _threeItem = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView
{
    //标题
    self.title = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 20)] autorelease];
    _title.textColor = orange_color;
    _title.font = [UIFont systemFontOfSize:14];
    _title.text = @"1";
    [self addSubview:_title];
    
    //起购金额
    self.firstItem = [[[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 20)] autorelease];
    _firstItem.textColor = title_text_color;
    _firstItem.font = [UIFont systemFontOfSize:14];
    _firstItem.text = @"2";
    [self addSubview:_firstItem];
    
    self.secondItem = [[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 20)] autorelease];
    _secondItem.textColor = title_text_color;
    _secondItem.font = [UIFont systemFontOfSize:14];
    _secondItem.text = @"3";
    [self addSubview:_secondItem];
    
    self.threeItem = [[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 20)] autorelease];
    _threeItem.textColor = title_text_color;
    _threeItem.font = [UIFont systemFontOfSize:14];
    _threeItem.text = @"4";
    [self addSubview:_threeItem];
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
