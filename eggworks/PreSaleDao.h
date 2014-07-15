//
//  PreSaleDao.h
//  eggworks
//
//  Created by 陈 海刚 on 14/7/1.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

typedef enum {
    remindType = 2,
    preSaleType = 1
} ProductRemindType;

@interface PreSaleDao : NSObject
{
    sqlite3 * sqlite;
    
    
}
//创建表
-(void)createTable;
//添加产品
-(void)addPreSaleProduct:(NSDictionary*)product withType:(int) type;
//查询产品
-(NSArray*)queryPreSaleProductWithType:(int)type;
@end
