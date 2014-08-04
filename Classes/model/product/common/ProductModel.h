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
    int centX;
    int centY;
    int zoomValue;
    int maxDistance;
    float iRadius;
    float _det;
    float _detM;    // Real distance of each pix.
    float rad360;
    
    tagRealFile fileHeadStruct;
}

- (void) setCenterPointX:(int)x andY:(int) y;
- (void) drawDistanceCircle:(UIImageView *) productImgView;
- (void) constNeedCal:(UIImageView *) productImgView;

@end
