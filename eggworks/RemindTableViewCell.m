//
//  RemindTableViewCell.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/3.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RemindTableViewCell.h"

@implementation RemindTableViewCell

@synthesize title = _title;
@synthesize content = _content;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.title = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 25)] autorelease];
//        _title.backgroundColor = [UIColor yellowColor];
        [self addSubview:_title];
        
        self.content = [[[UILabel alloc] initWithFrame:CGRectMake(20, 35, 280, 20)] autorelease];
//        _content.backgroundColor = [UIColor redColor];
        _content.font = [UIFont systemFontOfSize:13];
        [self addSubview:_content];
        
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
