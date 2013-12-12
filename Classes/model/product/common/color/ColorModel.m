//
//  ColorModel.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/9/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "ColorModel.h"
#import "FMResultSet.h"
#import "FMDatabase.h"

@implementation ColorModel

static FMDatabase *db;
static FMResultSet *rs;
static const int colorArrayLength = 256;
static NSMutableDictionary* colorDataDic;

- (void)initModel
{
    colorDataDic = [NSMutableDictionary init];
}

#pragma -mark Model Control
+ (id)getColorData:(int)colorType
{
    NSMutableDictionary *colorDic = [colorDataDic objectForKey:[NSString stringWithFormat:@"%i",colorType]];
    if (!colorDic)
    {
        colorDic = [ColorModel selectControl:colorType];
        if (!colorDic) return nil;
        [colorDataDic setObject:colorDic forKey:[NSString stringWithFormat:@"%i",colorType]];
    }
    return colorDic;
}

#pragma -mark DB Control
+ (BOOL)loadDB
{
    db = [FMDatabase databaseWithPath:dbpath];
    if (![db open])
    {
        DLog(@"Could not open db.");
        return NO;
    }
    [db beginTransaction];
    [db executeUpdate:@"create table if not exists t_color (colortype integer PRIMARY KEY NOT NULL,colorname text,firstblockno integer,blockcnt integer,valuearea text,colorarea text,version text)"];
    [db commit];
    return YES;
}

+(id)selectControl:(int) colorType
{
    if ([self loadDB])
    {
        NSString *sql = [NSString stringWithFormat:@"select * from t_color where colorType=%i",colorType];
        rs = [db executeQuery:sql];
        NSMutableDictionary* colorDic = nil;
        if([rs next])
        {
            colorDic = [NSMutableDictionary init];
            [colorDic setValue:[NSString stringWithFormat:@"%i",[rs intForColumn:@"colortype"]] forKey:@"colorType"];
            [colorDic setValue:[rs stringForColumn:@"colorname"] forKey:@"colorName"];
            [colorDic setValue:[NSString stringWithFormat:@"%i",[rs intForColumn:@"firstblockno"]] forKey:@"firstBlockNo"];
            [colorDic setValue:[NSString stringWithFormat:@"%i",[rs intForColumn:@"blockcnt"]] forKey:@"blockCnt"];
            [colorDic setValue:[[rs stringForColumn:@"valuearea"] componentsSeparatedByString:@","]forKey:@"valueArea"];
            [colorDic setValue:[[rs stringForColumn:@"colorarea"] componentsSeparatedByString:@","]forKey:@"colorArea"];
            [colorDic setValue:[rs stringForColumn:@"version"] forKey:@"version"];
        }
        [rs close];
        [db close];
        return colorDic;
    }
    return nil;
}

+(void) insertControl:(NSMutableDictionary*) colorDic
{
    [self deleteControl:(int)[colorDic objectForKey:@"colorType"]];
    if ([self loadDB])
    {
        NSString *sql= [NSString stringWithFormat:@"INSERT INTO t_color(colortype,colorname,firstblockno,blockcnt,valuearea,colorarea,version) values ('%i','%@','%i','%i','%@','%@','%@')",
                        (int)[colorDic objectForKey:@"colorType"],
                        (NSString*)[colorDic objectForKey:@"colorName"],
                        (int)[colorDic objectForKey:@"firstBlockNo"],
                        (int)[colorDic objectForKey:@"blockCnt"],
                        (NSString*)[colorDic objectForKey:@"valueArea"],
                        (NSString*)[colorDic objectForKey:@"colorArea"],
                        (NSString*)[colorDic objectForKey:@"version"]
        ];
//        DLog(@">>>>>>>>>>>>>====%@",sql);
        [db executeUpdate:sql];
        [db close];
    }
}

+(void) deleteControl:(int) colorType
{
    if ([self loadDB])
    {
        NSString *sql= [NSString stringWithFormat:@"delete from t_color where colorType=%i", colorType];
//        DLog(@">>>>>>>>>>>>>====%@",sql);
        [db executeUpdate:sql];
        [db close];
    }
}


@end
