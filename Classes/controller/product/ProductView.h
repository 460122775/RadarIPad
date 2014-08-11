//
//  ProductView.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/23/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "QuartzCore/QuartzCore.h"

#import "ProductModel.h"
#import "ProductFactory.h"
#import "ProductDrawDataProtocol.h"
#import "CurrentProductListView.h"
#import "HistoryProductListView.h"
#import "HistoryView.h"

#import "LXActivity.h"
#import "SVPulsingAnnotationView.h"
#import "ASValueTrackingSlider.h"

@interface ProductView : UIView<CLLocationManagerDelegate, ASValueTrackingSliderDataSource, HistoryProductListProtocol>{
    UIPinchGestureRecognizer *zoomGestureRecognizer;
    UIPanGestureRecognizer *dragGestureRecognizer;
    CLLocationManager *locationManager;
    SVPulsingAnnotationView *pulsingView;
    CurrentProductListView *currentProductListView;
    HistoryProductListView *historyProductListView;
    HistoryView *historyView;
}

@property (strong, nonatomic) UIView *productView;
@property (strong, nonatomic) UIImageView *productImgView;
@property (strong, nonatomic) UIImageView *mapCircleView;
@property (strong, nonatomic) UIImageView *colorImgView;
@property (strong, nonatomic) UIView *processControlView;
@property (strong, nonatomic) ASValueTrackingSlider *slider;
@property (strong, nonatomic) UIView *rightBarView;
@property (strong, nonatomic) UIView *radarInfoBarView;
@property (strong, nonatomic) UIView *productInfoView;
@property (strong, nonatomic) UIView *productControlView;


@property (strong, nonatomic) ProductModel<ProductDrawDataProtocol>* currentProductModel;
@property (strong, nonatomic) NSData* currentProductData;

- (void)showPosition;
- (void)screenShot;
- (void)showCurrentProduct;
- (void)historyBtnClick;
- (void)drawProduct;

@end
