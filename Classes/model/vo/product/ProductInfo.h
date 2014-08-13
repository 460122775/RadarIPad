//
//  ProductInfo.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/13/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductInfo : NSObject

@property(nonatomic, retain)NSString *productName;
@property(nonatomic, retain)NSString *dataAddress;
@property(nonatomic, assign)int productType;
@property(nonatomic, retain)NSString *createTime;
@property(nonatomic, assign)int *layer;
@property(nonatomic, retain)NSString *scanmode;
@property(nonatomic, retain)NSString *mcode;
@property(nonatomic, retain)NSString *cName;
@property(nonatomic, retain)NSString *eName;

-(id)initWithPosFileStr:(NSString*) posFile;

@end
