//
//  ProductView.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/23/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "ProductFactory.h"
#import "ProductDrawDataProtocol.h"
#import "QuartzCore/QuartzCore.h"
#import "LXActivity.h"
#import <CoreLocation/CoreLocation.h>
#import "SVPulsingAnnotationView.h"

@interface ProductView : UIView<CLLocationManagerDelegate>{
    UIPinchGestureRecognizer *zoomGestureRecognizer;
    UIPanGestureRecognizer *dragGestureRecognizer;
    CLLocationManager *locationManager;
    SVPulsingAnnotationView *pulsingView;
}

@property (strong, nonatomic) UIView *productView;
@property (strong, nonatomic) UIImageView *productImgView;
@property (strong, nonatomic) UIImageView *mapCircleView;
@property (strong, nonatomic) UIImageView *colorImgView;
@property (strong, nonatomic) UIView *processControlView;
@property (strong, nonatomic) UIView *rightBarView;
@property (strong, nonatomic) UIView *radarInfoBarView;
@property (strong, nonatomic) UIView *productInfoView;
@property (strong, nonatomic) UIView *productControlView;

@property (strong, nonatomic) ProductModel<ProductDrawDataProtocol>* currentProductModel;
@property (strong, nonatomic) NSData* currentProductData;

- (void)showPosition;
- (void)screenShot;
- (void)showCurrentProduct;

@end
