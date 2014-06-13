//
//  MyOrderCellTableViewCell.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "MyOrderCellTableViewCell.h"

@implementation MyOrderCellTableViewCell

@synthesize phoneModel = _phoneModel;
@synthesize serviceData = _serviceData;

- (void)dealloc
{
    [_phoneModel release]; _phoneModel = nil;
    [_serviceData release]; _serviceData = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.phoneModel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 30)] autorelease];
        _phoneModel.textColor = title_text_color;
        [self addSubview:_phoneModel];
        
        self.serviceData = [[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 30)] autorelease];
        _serviceData.textColor = title_text_color;
        [self addSubview:_serviceData];
        
        UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, 30)] autorelease];
        view.backgroundColor = title_text_color;
        [self addSubview:view];
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
