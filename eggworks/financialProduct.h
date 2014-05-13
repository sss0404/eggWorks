//
//  financialProduct.h
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//
//理财产品

#import <Foundation/Foundation.h>

@interface financialProduct : NSObject

@property (nonatomic, retain) NSString * id_;//产品id
@property (nonatomic, retain) NSString * name;//产品名称
@property (nonatomic, retain) NSString * partyName;//发行机构简称
@property (nonatomic, retain) NSString * interest;//预期收益
@property (nonatomic, retain) NSString * period;//期限
@property (nonatomic, retain) NSString * threshold;//投资门槛
@property (nonatomic, retain) NSString * type;//类型
@end
