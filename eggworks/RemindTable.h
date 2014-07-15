//
//  RemindTable.h
//  eggworks
//
//  Created by 陈 海刚 on 14/7/1.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface RemindTable : NSObject
{
    sqlite3 * sqlite;
}

@end
