//
//  RemindTable.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/1.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RemindTable.h"

@implementation RemindTable


//打开数据库
-(BOOL)openDatabase
{
    //获取数据库的路径
    NSArray * myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * myDocPath = [myPaths objectAtIndex:0];
    NSString * fileName = [myDocPath stringByAppendingPathComponent:@"eggworks.sqlite"];
    
    //打开数据库
    if (sqlite3_open([fileName UTF8String], &sqlite) != SQLITE_OK) {
        //打开失败
        sqlite3_close(sqlite);
        return NO;
    }
    return YES;
    
}

-(void)createTable
{
    if ([self openDatabase]) {
        NSString * sql = @"create table IF NOT EXISTS remind_table(id_ integer primary key, id_s varchar, name varchar,)";
    }
}

@end
