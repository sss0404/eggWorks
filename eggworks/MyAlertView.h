//
//  MyAlertView.h
//  IRA
//
//  Created by 陈 海刚 on 13-12-9.
//  Copyright (c) 2013年 visionet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAlertView : NSObject<UIAlertViewDelegate>
{
    id btnClickHandler;
}

@property (nonatomic, copy)id btnClickHandler;

-(void) showMessage:(NSString*)msg withTitle:(NSString*)title withCancelBtnTitle:(NSString*)cancelBtnTitle withBtnClick:(void(^)(NSInteger buttonIndex))handler otherButtonTitles:(NSString*)otherButtonTitles;
@end
