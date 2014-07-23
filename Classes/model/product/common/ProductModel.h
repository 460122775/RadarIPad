//
//  ProductModel.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDrawDataProtocol.h"

@interface ProductModel: NSObject<ProductDrawDataProtocol>{
    int productPaddingTop;
    int productPaddingLeft;
    int VGap;
    int labelWidth;
}

@end
