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

@interface ProductModel: NSObject<ProductDrawDataProtocol>{
    int productPaddingTop;
    int productPaddingLeft;
    int VGap;
    int labelWidth;
    
    int sizeofRadial;
    int maxDistance;
    float iRadius;
    float _det;
    float _detM;    // Real distance of each pix.
    float rad360;
    
    tagRealFile fileHeadStruct;
}

@property (nonatomic, assign) float zoomValue;
@property (nonatomic, assign) int centX;
@property (nonatomic, assign) int centY;

- (void) drawDistanceCircle:(UIImageView *) productImgView;
- (void) constNeedCal:(UIImageView *) productImgView;
- (CGPoint) getPointByPosition:(CGPoint) point andFrame:(CGRect)frame;

@end
