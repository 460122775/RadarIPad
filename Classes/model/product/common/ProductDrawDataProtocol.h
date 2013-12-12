//
//  ProductDrawDataProtocol.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/9/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProductDrawDataProtocol <NSObject>

@required

-(id)getImageData;

-(NSString*)getTipString;

-(id)getProductInfo;

@end
