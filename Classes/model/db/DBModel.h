//
//  DBModel.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/22/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface DBModel : NSObject

+ (void)initDB;

+ (NSString*) getProductData:(int) type andCurrentData:(NSString*) currentData;

@end
