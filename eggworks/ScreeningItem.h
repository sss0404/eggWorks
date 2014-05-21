//
//  ScreeningItem.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-15.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScreeningItemDelegate <NSObject>

-(void) onButtonClicked:(id)sender withTag:(int)tag;

@end

@interface ScreeningItem : UIView

@property (nonatomic, assign) id<ScreeningItemDelegate>  delegate;
@property (nonatomic, retain) UIButton * btn;
@property (nonatomic, retain) UILabel * label;
@property (nonatomic, retain) UIImageView * right;

-(void)setImageRight:(BOOL)isRight;

@end
