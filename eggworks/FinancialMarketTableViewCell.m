//
//  FinancialMarketTableViewCell.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "FinancialMarketTableViewCell.h"

@implementation FinancialMarketTableViewCell

@synthesize ExpectedReturnTitle = _ExpectedReturnTitle;
@synthesize ExpectedReturn = _ExpectedReturn;
@synthesize financialProductsName = _financialProductsName;
@synthesize financialProductsDescribtion = _financialProductsDescribtion;

- (void)dealloc
{
    [_ExpectedReturnTitle release]; _ExpectedReturnTitle = nil;
    [_ExpectedReturn release]; _ExpectedReturn = nil;
    [_financialProductsName release]; _financialProductsName = nil;
    [_financialProductsDescribtion release]; _financialProductsDescribtion = nil;
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
    //89
    //预期收益标题
    _ExpectedReturnTitle = [[UILabel alloc] initWithFrame:CGRectMake(12.5, 20, 64, 12.8)];
    _ExpectedReturnTitle.textColor = [UIColor redColor];
    _ExpectedReturnTitle.font = [UIFont systemFontOfSize:14];
    [self addSubview:_ExpectedReturnTitle];
    
    //预期收益名称
    _ExpectedReturn = [[UILabel alloc] initWithFrame:CGRectMake(12.5, 25.3+15, 64, 20)];
    _ExpectedReturn.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
    _ExpectedReturn.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];//[UIFont systemFontOfSize:18];
    [self addSubview:_ExpectedReturn];
    
    //理财产品名称
    _financialProductsName = [[UILabel alloc] initWithFrame:CGRectMake(89, 15, 320-64-25-25, 20)];
    _financialProductsName.textColor = title_text_color;
    _financialProductsName.font = [UIFont systemFontOfSize:14];
    [self addSubview:_financialProductsName];
    
    UIView * devier = [[[UIView alloc] initWithFrame:CGRectMake(89, 42, 320-89, 2)] autorelease];
    devier.backgroundColor = [UIColor colorWithRed:.79 green:.79 blue:.79 alpha:1];
    [self addSubview:devier];
    
    _financialProductsDescribtion = [[UILabel alloc] initWithFrame:CGRectMake(89, 50, 320-64-25-25, 20)];
    _financialProductsDescribtion.textColor = title_text_color;
    _financialProductsDescribtion.font = [UIFont systemFontOfSize:14];
    [self addSubview:_financialProductsDescribtion];
    
    //    devier_li_cai@2x
    UIImageView * bottomImg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 65+15, 320, 9)] autorelease];
    bottomImg.image = [UIImage imageNamed:@"devier_li_cai"];
    [self addSubview:bottomImg];
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
