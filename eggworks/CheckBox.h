//
//  CheckBox.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-20.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBox : UIButton

@property(nonatomic, assign) BOOL selected;//是否选择
@property(nonatomic, retain) UILabel * title;
@property(nonatomic, retain) UIImageView * btn;
@property (nonatomic, retain) NSIndexPath * indexPath;

//@property(nonatomic, retain) id target;
//@property(nonatomic, assign) SEL action;
//@property(nonatomic, assign) UIControlEvents controlEvents;

-(void)setCheck:(BOOL) checked;
@end
