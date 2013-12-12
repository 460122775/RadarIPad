//
//  ProductModel.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

@synthesize queue, productDic;

static FMDatabase *db;
static FMResultSet *rs;
static ProductModel* instance;

+(NSData*) test
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                      objectAtIndex:0];
    
    NSString *fileName = @"/data/20130808/20130808_104630.02.003.000_2.40.zdb";
    NSData* data = (NSData*)[NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/%@", path, fileName]];
    return data;
}

#pragma -mark
+ (void)cacheFileByUrl:(NSString *)fileUrl block:(fileFinishBlock)afinishBlock
{
    [ProductModel getInstance];
    NSString *fileName = [[NSUserDefaults standardUserDefaults] stringForKey:fileUrl];
    if(!fileName){
        __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:fileUrl]];
        [request setDelegate:self];
        [request setTimeOutSeconds:10.];
        [request setNumberOfTimesToRetryOnTimeout:1.];
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setCompletionBlock:^{
            afinishBlock([ProductModel cacheFile:request andFileUrl:fileUrl]);
//            DLog("\nREQUEST SUCCESS >>>>%@",fileUrl);
        }];
        [request setFailedBlock:^{
            DLog(@"\nREQUEST FAILED >>>>%@:::%@",fileUrl,[[request error] localizedDescription]);
        }];
        [instance.queue addOperation:request];
        [instance.queue go];
    }else{
        afinishBlock(fileName);
//        DLog("\nSUCCESS GET FILE>>>>>>>%@",fileName);
    } 
}

+(NSString *)cacheFile:(ASIHTTPRequest *)request andFileUrl:(NSString*) fileUrl
{
    //save file to the disk
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                      objectAtIndex:0];
    //Get the os time using as the name of image
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMDDHHmmssSSSS"];
    long time =[[dateformatter stringFromDate:[NSDate date]] longLongValue];
    
    NSString *fileName = [fileUrl lastPathComponent];
    //    DLog(@"%@",fileName);
    [[request responseData] writeToFile:[NSString stringWithFormat:@"%@/%ld%@",path,-time,fileName] atomically:NO];
    //    DLog(@"\n＝＝fileName: %@",[NSString stringWithFormat:@"%@",fileName]);
    //save image to the NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@/%ld%@",path,-time,fileName] forKey:fileUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    DLog(@"\n>>>FilePath:%@==Key:%@",[NSString sstringWithFormat:@"%@/%@",path,fileName],fileUrl)
    return [NSString stringWithFormat:@"%@/%ld%@",path,-time,fileName];
}

+(BOOL) loadDB{
    db = [FMDatabase databaseWithPath:dbpath];
    if (![db open])
    {
        DLog(@"Could not open db.");
        return NO;
    }
    [db beginTransaction];
    [db executeUpdate:@"create table if not exists t_product (name text PRIMARY KEY NOT NULL,posFile text, type integer, time text, layer integer, mcode text)"];
//    [db executeUpdate:@"create table if not exists t_system (key text,value text)"];
    [db commit];
    return YES;
}

+(ProductModel*)getInstance
{
    if(!instance)
    {
        instance = [[ProductModel alloc] init];
        instance.queue = [[ASINetworkQueue alloc]init];
    }
    
    // test code ....
    for (int i = 0; i < 6; i++)
    {
        [instance.productDic setValue:[ProductModel test] forKey:[NSString stringWithFormat:@"%i", i]];
    }
    return instance;
}

@end
