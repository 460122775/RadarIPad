//
//  ProductModel.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDrawDataProtocol.h"
#import "ProductDefine.h"
#import "ProductInfo.h"

@interface ProductModel: NSObject<ProductDrawDataProtocol>{
    int productPaddingTop;
    int productPaddingLeft;
    int VGap;
    int labelWidth;
    
    int sizeofRadial;
    int maxDistance;
    int ikuchang;
    int nRangbin;
    float iRadius;
    float _det;
    float _detM;    // Real distance of each pix.
    float rad360;
    
    tagRealFile fileHeadStruct;
}

@property (nonatomic, assign) int zoomValue;
@property (nonatomic, assign) int centX;
@property (nonatomic, assign) int centY;
@property (nonatomic, retain) ProductInfo *productInfo;

- (void) drawDistanceCircle:(UIImageView *) productImgView;
- (void) constNeedCal:(UIImageView *) productImgView;
- (CGPoint) getPointByPosition:(CLLocation*) point andFrame:(CGRect)frame;
- (CLLocationCoordinate2D) getPositionByPoint:(CGPoint) point;
- (CLLocationCoordinate2D) getRadarCenterPosition;
- (float)getDetM;
@end
