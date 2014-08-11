//
//  ProductVo.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/13/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductVo : NSObject

@property(nonatomic, assign)int type;
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *ename;
@property(nonatomic, retain)NSString *config;
@property(nonatomic, assign)int *user_id;
@property(nonatomic, assign)int *isBaseProduct;
@property(nonatomic, assign)int *needConfig;

@end
