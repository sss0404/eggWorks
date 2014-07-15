//
//  PreSaleDao.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/1.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "PreSaleDao.h"
#import "TimeUtils.h"

@implementation PreSaleDao

//打开数据库
-(BOOL)openDatabase
{
    //获取数据库的路径
    NSArray * myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * myDocPath = [myPaths objectAtIndex:0];
    NSString * fileName = [myDocPath stringByAppendingPathComponent:@"eggworks.sqlite"];
    NSLog(@"fileName:%@",fileName);
    //打开数据库
    if (sqlite3_open([fileName UTF8String], &sqlite) != SQLITE_OK) {
        //打开失败
        sqlite3_close(sqlite);
        return NO;
    }
    return YES;
    
}

//创建表
-(void)createTable
{
    if ([self openDatabase]) {
        NSString * sql = @"create table IF NOT EXISTS pre_sale_table(id_ integer primary key, id_f_server varchar, name varchar,saleStartTime integer,saleEndTime integer,type integer)";
        char * err;
        if (sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSLog(@"创建表失败");
        }
        sqlite3_close(sqlite);
        NSLog(@"创建表成功");
    }
}

//添加产品
-(void)addPreSaleProduct:(NSDictionary*)product withType:(int) type
{
    if ([self openDatabase]) {
        NSString * sql = @"insert into pre_sale_table(id_f_server,name,saleStartTime,saleEndTime,type) values(?,?,?,?,?);";
        sqlite3_stmt * statement;
        int result = sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &statement, NULL);
        if (result == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [[product objectForKey:@"id"] UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [[product objectForKey:@"name"] UTF8String], -1, NULL);
            long long startTime = [TimeUtils string2LongLongWithStr:[product objectForKey:@"from"] withFormat:@"yyyy-MM-dd"];
            sqlite3_bind_int64(statement, 3, startTime);
            long long endTime = [TimeUtils string2LongLongWithStr:[product objectForKey:@"to"] withFormat:@"yyyy-MM-dd"];
            sqlite3_bind_int64(statement, 4, endTime);
            
            sqlite3_bind_int(statement, 5, type);
            int result = sqlite3_step(statement);
            if (result != SQLITE_DONE) {
                 NSLog(@"添加数据失败");
            }
            sqlite3_finalize(statement);
            sqlite3_close(sqlite);
        }
    }
}

-(NSArray*)queryPreSaleProductWithType:(int)type
{
    NSMutableArray * array = [[[NSMutableArray alloc] init] autorelease];
    if ([self openDatabase]) {
        NSString * sql = @"select * from pre_sale_table where type=?;";
        sqlite3_stmt * statement;
        if (sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            sqlite3_bind_int(statement, 1, type);
            NSMutableDictionary * dic;
            while (sqlite3_step(statement) == SQLITE_ROW) {
                dic = [[[NSMutableDictionary alloc] init] autorelease];
                [dic setObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)] forKey:@"id_"];
                char * id_f_server = (char*)sqlite3_column_text(statement, 1);
                [dic setObject:id_f_server == NULL ? @"" : [NSString stringWithUTF8String:id_f_server] forKey:@"id_f_server"];
                char * name = (char*)sqlite3_column_text(statement, 2);
                [dic setObject:name == NULL ? @"" : [NSString stringWithUTF8String:name] forKey:@"name"];
                if (type == preSaleType) {//如果是预售产品
                    double start = [self countDayFromTodayWithTime:sqlite3_column_int64(statement, 3)];
                    double end = [self countDayFromTodayWithTime:sqlite3_column_int64(statement, 4)];
                    
                    [dic setObject:[NSNumber numberWithFloat:start] forKey:@"saleStartDay"];
                    [dic setObject:[NSNumber numberWithFloat:end] forKey:@"saleEndDay"];
                } else {//到期提醒
                    long long te = sqlite3_column_int64(statement, 4);
                    double test = [self countDayFromTodayWithTime:te];
                    [dic setObject:[NSNumber numberWithFloat:test] forKey:@"expiredDay"];
                }
//                [dic setObject:[NSNumber numberWithLongLong:sqlite3_column_int(statement, 4)] forKey:@"saleEndTime"];
                [array addObject:dic];
            }
        }
    }
    return array;
}

-(float)countDayFromTodayWithTime:(long long) time
{
    NSString * timeStr = [TimeUtils longlong2StringWithLongLong:time withFormate:YYYYMMDDhhmmss];
    
    float day = 0;
    double oneDay = 3600 * 24;
    long long currTime = [TimeUtils getCurrentTime];
    NSString * currTimeStr = [TimeUtils longlong2StringWithLongLong:currTime withFormate:YYYYMMDDhhmmss];
    long long dayTime = time - currTime ;
    day =  dayTime/oneDay;
    return day;
}

@end
