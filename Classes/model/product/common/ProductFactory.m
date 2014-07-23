//
//  ProductFactory.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "ProductFactory.h"

@implementation ProductFactory

@synthesize queue, firstProductArr, secondProductArr;

static FMDatabase *db;
static FMResultSet *rs;
static ProductFactory* _instance;

+ (id)getProductModel:(int)productType
{
    switch (productType)
    {
        case ProductType_R:
            return [[RVWDrawData alloc]init];
            break;
            
        default:
            break;
    }
    return nil;
}

+ (id)getProductModelByAddress:(NSString *)addressStr
{
    return nil;
}

+ (NSData*) test
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                      objectAtIndex:0];
    
    NSString *fileName = @"/data/20130808/20130808_104630.02.003.000_2.40.zdb";
    NSData* data = (NSData*)[NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/%@", path, fileName]];
    return data;
}

- (void)receiveProductAddressControl:(id) productAddressData
{
    // Add into dictionary after estinguish the productType.
    NSString *productAddressString = (NSString*)productAddressData;
    NSArray *addressArr = [productAddressString componentsSeparatedByString:@"/"];
    productAddressString = [addressArr objectAtIndex:addressArr.count - 1];
    addressArr = [productAddressString componentsSeparatedByString:@"."];
    // Estinguish the product view, if has exist, then download data and draw product.
    
}

#pragma -mark
+ (void)cacheFileByUrl:(NSString *)fileUrl block:(fileFinishBlock)afinishBlock
{
    [ProductFactory instance];
    NSString *fileName = [[NSUserDefaults standardUserDefaults] stringForKey:fileUrl];
    if(!fileName){
        ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:fileUrl]];
        [request setDelegate:self];
        [request setTimeOutSeconds:10.];
        [request setNumberOfTimesToRetryOnTimeout:1.];
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setCompletionBlock:^{
            afinishBlock([ProductFactory cacheFile:request andFileUrl:fileUrl]);
            //            DLog("\nREQUEST SUCCESS >>>>%@",fileUrl);
        }];
        [request setFailedBlock:^{
            DLog(@"\nREQUEST FAILED >>>>%@:::%@",fileUrl,[[request error] localizedDescription]);
        }];
        [_instance.queue addOperation:request];
        [_instance.queue go];
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
    db = [FMDatabase databaseWithPath:DBPath];
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

+(ProductFactory*)instance
{
    if(!_instance)
    {
        _instance = [[ProductFactory alloc] init];
        _instance.queue = [[ASINetworkQueue alloc]init];
        _instance.firstProductArr = [[NSMutableArray alloc] init];
        _instance.secondProductArr = [[NSMutableArray alloc] init];
        _instance.appliedProductDic =[[NSMutableDictionary alloc] init];
    }
    return _instance;
}


@end
