//
//  BankSelectedTableViewCell.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-29.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BankSelectedTableViewCell.h"

@implementation BankSelectedTableViewCell

@synthesize checkBox = _checkBox;

- (void)dealloc
{
    [_checkBox release]; _checkBox = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.checkBox = [[[CheckBox alloc] initWithFrame:CGRectMake(10, 15, 320, 40)] autorelease];
        _checkBox.title.textColor = title_text_color;
        [self addSubview:_checkBox];
    }
    return self;
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
