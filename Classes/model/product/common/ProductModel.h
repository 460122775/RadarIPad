//
//  ProductModel.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

typedef void (^fileFinishBlock)(NSString *url);

@interface ProductModel : NSObject{
    ASINetworkQueue *queue;
}

@property (nonatomic, retain) ASINetworkQueue *queue;
@property(nonatomic, retain) NSMutableDictionary *productDic;

+(NSData*) test;
+(ProductModel*)getInstance;

@end
