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

-(void)getImageData:(UIImageView *) productImgView andData:(NSData *) data;

-(void)getProductInfo:(UIView *) productInfoView TitleLabel:(UILabel*)titleLabel Data:(NSData *) data;

@end
