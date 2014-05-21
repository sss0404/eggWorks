//
//  MyselfTableViewCell.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-13.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyselfTableViewCell : UITableViewCell

@property(nonatomic, retain)UILabel * myLabel;
@property(nonatomic, retain)UILabel * secondLabel;

-(void)createView;
@end
