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
    zoomValue = 1;
    return self;
}

- (void) setCenterPointX:(int)x andY:(int) y
{
    centX = x;
    centY = y;
}

- (void) constNeedCal:(UIImageView*) productImgView
{
    iRadius = productImgView.frame.size.height / 2.0 * zoomValue;
    // If R, LCS.
    _det = fileHeadStruct.obserSec.usRefBinNumber[0] / iRadius;
    _detM = fileHeadStruct.obserSec.usRefBinNumber[0] * fileHeadStruct.obserSec.iRefBinLen[0] / iRadius;
    maxDistance = fileHeadStruct.obserSec.usRefBinNumber[0] * fileHeadStruct.obserSec.iRefBinLen[0];
    rad360 = fileHeadStruct.obserSec.iRadialNum[0] / 360.0;
    sizeofRadial = fileHeadStruct.obserSec.usRefBinNumber[0] + 64;
}

-(void)getImageData:(UIImageView *) productImgView andData:(NSData *) data
{
    [self constNeedCal:productImgView];
}

-(void)drawDistanceCircle:(UIImageView *)mapCircleImgView
{
    UIGraphicsBeginImageContext(mapCircleImgView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context, 170 / 256.0, 170 / 256.0, 170 / 256.0, 1.0);
    // Draw distance line.
    int aaa = maxDistance / _detM * sqrt(2) / 2;
    CGContextMoveToPoint(context, centX, centY - maxDistance / _detM);
    CGContextAddLineToPoint(context, centX, centY + maxDistance / _detM);
    CGContextMoveToPoint(context, centX + aaa, centY - aaa);
    CGContextAddLineToPoint(context, centX - aaa, centY + aaa);
    CGContextMoveToPoint(context, centX + maxDistance / _detM, centY);
    CGContextAddLineToPoint(context, centX - maxDistance / _detM, centY);
    CGContextMoveToPoint(context, centX + aaa, centY + aaa);
    CGContextAddLineToPoint(context, centX - aaa, centY - aaa);
    CGContextStrokePath(context);
    // Draw circle line.
    for (int i = 1; i <= maxDistance / 50000; i++)
    {
        CGContextAddArc(context, centX, centY, (i * 50000) / _detM, 0, 2 * M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);
    }
    mapCircleImgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)getProductInfo:(UIView *)productInfoView andData:(NSData *) data
{

}

@end
