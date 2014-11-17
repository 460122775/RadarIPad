//
//  ProductFactory.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "ProductFactory.h"

@implementation ProductFactory

@synthesize queue, firstProductArr, secondProductArr, currentData;

static FMDatabase *db;
static FMResultSet *rs;
static ProductFactory* _instance;

+ (id)getProductModel:(int)productType
{
    switch (productType)
    {
        case ProductType_R:
        case ProductType_V:
        case ProductType_W:
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

- (void)receiveProductAddressControl:(id) productAddressData
{
    // Add into dictionary after estinguish the productType.
    NSString *productAddressString = (NSString*)productAddressData;
    NSArray *addressArr = [productAddressString componentsSeparatedByString:@"/"];
    productAddressString = [addressArr objectAtIndex:addressArr.count - 1];
    addressArr = [productAddressString componentsSeparatedByString:@"."];
    // distinguish the product view, if has exist, then download data and draw product.
    
}

#pragma -mark
+ (void)cacheFileByUrl:(NSString *)fileUrl block:(fileFinishBlock)afinishBlock
{
    [ProductFactory instance];
    NSString *fileName = [[NSUserDefaults standardUserDefaults] stringForKey:fileUrl];
    if(!fileName)
    {
        ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:fileUrl]];
        [request setDelegate:self];
        [request setTimeOutSeconds:10.];
        [request setNumberOfTimesToRetryOnTimeout:1.];
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setCompletionBlock:^{
            NSString *filePath = [ProductFactory cacheFile:request andFileUrl:fileUrl];
            if (filePath != nil && filePath.length > 0)
            {
                afinishBlock((NSData*)[NSFileHandle fileHandleForReadingAtPath:filePath]);
            }
//            DLog("\nREQUEST SUCCESS >>>>%@",fileUrl);
        }];
        [request setFailedBlock:^{
            DLog(@"\nREQUEST FAILED >>>>%@:::%@",fileUrl,[[request error] localizedDescription]);
        }];
        [_instance.queue addOperation:request];
        [_instance.queue go];
    }
}

+(NSString *)cacheFile:(ASIHTTPRequest *)request andFileUrl:(NSString*) fileUrl
{
    //save file to the disk
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:DataPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (bo == false) return nil;
    NSString *filePath = [DataPath stringByAppendingPathComponent:fileUrl];
    //    DLog(@"%@",fileName);
    [[request responseData] writeToFile:filePath atomically:NO];
    //save image to the NSUserDefaults
//    [[NSUserDefaults standardUserDefaults] setObject:filePath forKey:fileUrl];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    DLog(@"\n>>>FilePath:%@==Key:%@",[NSString sstringWithFormat:@"%@/%@",path,fileName],fileUrl)
    return filePath;
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

+(NSData *)uncompressZippedData:(NSData *)compressedData
{
    if ([compressedData length] == 0) return compressedData;
    // The struct _YW_ZIP_HEADE [48 Byte] named 'tagYWZipHead'.
    compressedData = [compressedData subdataWithRange:NSMakeRange(48, compressedData.length - 48)];
    unsigned full_length = [compressedData length];
    
    unsigned half_length = [compressedData length] / 2;
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    z_stream strm;
    strm.next_in = (Bytef *)[compressedData bytes];
    strm.avail_in = [compressedData length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    if (inflateInit2(&strm, 15 + 32) != Z_OK) return nil;
    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy: half_length];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = [decompressed length] - strm.total_out;
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if (status != Z_OK) {
            break;
        }
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    // Set real length.
    if (done) {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    } else {
        return nil;
    }  
}

+(NSMutableArray*) getProductList:(NSMutableArray*)productListArr
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:DBPath];
    
    if (queue)
    {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs = [db executeQuery:
                               [NSString stringWithFormat:@"select * from t_productcfg where needConfig=1"]];
            ProductVo *vo = nil;
            while([rs next])
            {
                vo = [[ProductVo alloc] init];
                [vo setType:[rs intForColumn:@"type"]];
                [vo setName:[rs stringForColumn:@"name"]];
                [vo setEname:[rs stringForColumn:@"ename"]];
                [vo setConfig:[rs stringForColumn:@"config"]];
                [vo setUser_id:[rs intForColumn:@"user_id"]];
                [vo setIsBaseProduct:[rs intForColumn:@"isBaseProduct"]];
                [vo setNeedConfig:[rs intForColumn:@"needConfig"]];
                [productListArr addObject:vo];
            }
            [rs close];
        }];
        [queue close];
    }
    return productListArr;
}

@end
