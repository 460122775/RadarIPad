//
//  ProductFactory.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVWDrawData.h"

@interface ProductFactory : NSObject

+ (id)getProductModel:(int)productType;

@end
