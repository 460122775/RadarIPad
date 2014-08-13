//
//  ProductInfo.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/13/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "ProductInfo.h"

@implementation ProductInfo
@synthesize productName, dataAddress, productType, createTime, layer, scanmode, mcode, cName, eName;


-(id)initWithPosFileStr:(NSString*) posFile
{
    self = [super init];
    self.productType = [[posFile substringWithRange:NSMakeRange(20, 3)] intValue];
    self.dataAddress = posFile;
    return  self;
}

@end
