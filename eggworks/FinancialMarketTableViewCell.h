//
//  FinancialMarketTableViewCell.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinancialMarketTableViewCell : UITableViewCell

@property(nonatomic,retain) UILabel * ExpectedReturnTitle;//预期收益率标题
@property(nonatomic,retain) UILabel * ExpectedReturn;//预期收益率
@property(nonatomic,retain) UILabel * financialProductsName;//理财产品
@property(nonatomic,retain) UILabel * financialProductsDescribtion;//理财产品描述

-(void)createView;
@end
