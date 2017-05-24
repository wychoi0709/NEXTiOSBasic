//
//  SQLiteManager.m
//  week11
//
//  Created by 최원영 on 2017. 5. 22..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "SQLiteManager.h"
#import <FMDatabase.h>
#import <FMDB.h>

@implementation SQLiteManager{
    FMDatabase *db;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"SQLiteManager init 함수로 진입");
        
        db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"top25" ofType:@"db"]];
        
        if (![db open]) {
            // [db release];   // uncomment this line in manual referencing code; in ARC, this is not necessary/permitted
            db = nil;
        }
        [self loadDataFromDB];
    }
    return self;
}

- (void)loadDataFromDB{
    NSLog(@"loadDataFromDB에 들어옴");

    FMResultSet *s = [db executeQuery:@"SELECT * FROM tbl_songs"];
    
    NSMutableArray *contentArray = [[NSMutableArray alloc] init];
    
    while ([s next]) {
        
        NSMutableDictionary *aContent = [[NSMutableDictionary alloc] init];
        
        NSString *id = [NSString stringWithFormat:@"%d", [s intForColumn:@"id"]];
        NSString *title = [s stringForColumn:@"title"];
        NSString *category =[s stringForColumn:@"category"];
        NSString *image =[s stringForColumn:@"image"];
        
        [aContent setObject:id forKey:@"id"];
        [aContent setObject:title forKey:@"title"];
        [aContent setObject:category forKey:@"category"];
        [aContent setObject:image forKey:@"image"];
        
        [contentArray addObject:aContent];
    }
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:contentArray forKey:@"userInfo"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"afterSelectTable" object:nil userInfo:userInfo];
}

@end
