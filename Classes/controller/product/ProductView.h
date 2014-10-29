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
#import "ProductVo.h"
#import "ProductFactory.h"
#import "ProductDrawDataProtocol.h"
#import "CurrentProductListView.h"
#import "HistoryProductListView.h"
#import "HistoryView.h"
#import "DBModel.h"

#import "LXActivity.h"
#import "SVPulsingAnnotationView.h"
#import "ASValueTrackingSlider.h"

@interface ProductView : UIView<CLLocationManagerDelegate, ASValueTrackingSliderDataSource,
    ASValueTrackingSliderDelegate, HistoryProductListProtocol, CurrentProductListDelegate>{
    
        UIPinchGestureRecognizer *zoomGestureRecognizer;
        UIPanGestureRecognizer *dragGestureRecognizer;
        UIPanGestureRecognizer *switchGestureRecognizer;
        UIPanGestureRecognizer *knifeGestureRecognizer;
        CLLocationManager *locationManager;
        SVPulsingAnnotationView *pulsingView;
        CurrentProductListView *currentProductListView;
        HistoryProductListView *historyProductListView;
        HistoryView *historyView;
        NSTimer *playTimer;
        UIButton *knifeBtn;
}

@property (strong, nonatomic) IBOutlet UIView *productViewBg;
@property (strong, nonatomic) IBOutlet UIView *productView;
@property (strong, nonatomic) IBOutlet UIView *imgContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *productImgView;
@property (strong, nonatomic) IBOutlet UIImageView *mapCircleView;
@property (strong, nonatomic) IBOutlet UIImageView *colorImgView;

@property (strong, nonatomic) UIImageView *knifeLineView;
@property (strong, nonatomic) IBOutlet UIView *processControlView;
@property (strong, nonatomic) ASValueTrackingSlider *slider;

@property (strong, nonatomic) IBOutlet UIView *rightBarViewBg;
@property (strong, nonatomic) IBOutlet UIView *rightBarView;
@property (strong, nonatomic) IBOutlet UIView *radarInfoBarView;
@property (strong, nonatomic) IBOutlet UIView *productInfoView;
@property (strong, nonatomic) IBOutlet UIView *productControlView;


@property (strong, nonatomic) ProductModel<ProductDrawDataProtocol>* currentProductModel;
@property (strong, nonatomic) NSData* currentProductData;

- (void)showPosition;
- (void)screenShot;
- (void)showCurrentProduct;
- (void)historyBtnClick;
- (void)drawProduct;
- (void)knifeBtnClick:(id) sender;
- (void)playBtnClick;

+ (void) setShadowTaste:(UIView *)backView andForeView:(UIView *)foreView;

@end
