//
//  ProductFactory.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "ProductFactory.h"

@implementation ProductFactory

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

@end
