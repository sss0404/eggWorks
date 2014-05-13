//
//  Product.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneEasyProduct : NSObject

@property (nonatomic,retain) NSString * id_;            //产品id
@property (nonatomic, retain) NSString * name;          //产品名称
@property (nonatomic, retain) NSString * period;        //产品期限
@property (nonatomic, retain) NSString * termSummary;   //保障责任概要
@property (nonatomic, retain) NSString * price;         //产品价格
@property (nonatomic, retain) NSString * terms;         //详细保修条款
@end
