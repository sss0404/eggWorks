//
//  BottomNavigotionViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BottomNavigotionViewController : BaseViewController

@property (nonatomic, retain) UIView * bottomView;

-(void)bottomClick:(id)sender;
@end