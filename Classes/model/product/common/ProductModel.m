//
//  ProductModel.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

-(id)init
{
    self = [super init];
    productPaddingLeft = 5;
    productPaddingTop = 5;
    VGap = 8;
    labelWidth = 250;
    return self;
}

-(void)getImageData:(UIImageView *) productImgView andData:(NSData *) data
{
    
}

-(void)getProductInfo:(UIView *)productInfoView andData:(NSData *) data
{

}

@end
