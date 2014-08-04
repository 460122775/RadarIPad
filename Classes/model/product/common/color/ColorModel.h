//
//  ColorModel.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/9/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"

@interface ColorModel : NSObject

+ (NSMutableArray*) getCurrentColorDataArray;

+ (void)drawColor:(int)colorType andColorImgView:(UIImageView *) colorImgView;

@end
