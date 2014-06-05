//
//  BaseViewController.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassingParameters <NSObject>

//页面返回上一页时候触发
-(void)completeParameters:(id)obj withTag:(NSString*)tag;

@end

@interface BaseViewController : UIViewController<UITextFieldDelegate,PassingParameters>

@property (nonatomic, assign) id<PassingParameters> passingParameters;
@property (nonatomic, assign) NSString * resultCode;

@end
