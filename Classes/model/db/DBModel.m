//
//  DBModel.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "DBModel.h"

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

@implementation DBModel

+ (void)initDB
{
//    NSString *dbPath = @"/tmp/bugreportsample.db";
//    NSString *dbPath = NSTemporaryDirectory();
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:DBPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (bo)
    {
        // delete the old db if it exists
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:DBPath error:nil];
        
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:DBPath];
        [queue inDatabase:^(FMDatabase *db) {
            BOOL worked = [db executeUpdate:@"create table t_color (colorType integer, colorData text)"];
            FMDBQuickCheck(worked);
            
            //**************Test Data***************
            worked = [db executeUpdate:@"insert into t_color values (3, '17,dbz,-32,0,0,3,26,-20,127,194,229,30,-5,0,174,165,10,0,198,195,255,10,5,123,113,239,10,10,24,36,214,10,15,165,255,173,10,20,0,235,0,10,25,16,146,24,10,30,255,247,99,10,35,206,203,0,10,40,140,142,0,10,45,255,174,173,10,50,255,101,90,10,55,239,0,49,10,60,214,142,255,10,65,173,36,255,59,94.5')"];
//            FMDBQuickCheck(worked);
            //**************Test Data***************
            
        }];
        [queue close];
    }
}

@end
