//
//  ProductFactory.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDefine.h"
#import "RVWDrawData.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "zlib.h"

typedef struct _CPCMD
{
    int     startflag;             //0xB2
    long    ID;                     //
    int     type;                   //(必须)TYPE_PRODUCT_GEN_RESULT		3
    int     subtype;                //(必须)PRO_GEN_SUCESS			1
    int     status;                 //
    char    ProductFileName;		//下载的路径地址
    int     endflag;                //结束标记
}tagCPCMD,CPCMD;

typedef void (^fileFinishBlock)(NSData *data);

@interface ProductFactory : NSObject{
    ASINetworkQueue *queue;
}

@property (nonatomic, retain) ASINetworkQueue *queue;
@property(nonatomic, retain) NSMutableArray *firstProductArr;
@property(nonatomic, retain) NSMutableArray *secondProductArr;
@property(nonatomic, retain) NSMutableDictionary *appliedProductDic;
@property(nonatomic, retain) NSData *currentData;

+ (ProductFactory*)instance;

- (void)receiveProductAddressControl:(id) productAddressData;

+ (id)getProductModel:(int)productType;

+ (id)getProductModelByAddress:(NSString*)addressStr;

+ (void)cacheFileByUrl:(NSString *)fileUrl block:(fileFinishBlock)afinishBlock;

+(NSData *)uncompressZippedData:(NSData *)compressedData;

@end
