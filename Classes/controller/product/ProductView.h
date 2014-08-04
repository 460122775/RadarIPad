//
//  ProductView.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/23/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ProductViewInitFinishControl)(void);

@interface ProductView : UIView<UIGestureRecognizerDelegate>{
    UIPinchGestureRecognizer *pinchRecognizer;
    CGFloat lastScale;
}

@property (strong, nonatomic) UIImageView *productImgView;
@property (strong, nonatomic) UIImageView *mapCircleView;
@property (strong, nonatomic) UIImageView *colorImgView;

@property (strong, nonatomic) UIView *rightBarView;
@property (strong, nonatomic) UIView *radarInfoBarView;
@property (strong, nonatomic) UIView *productInfoView;
@property (strong, nonatomic) UIView *productControlView;

@property (strong, nonatomic) UIButton *btn_shot;
@property (strong, nonatomic) UIButton *btn_knife;
@property (strong, nonatomic) UIButton *btn_current;
@property (strong, nonatomic) UIButton *btn_cartoon;
@property (strong, nonatomic) UIButton *btn_screenshot;
@property (strong, nonatomic) UIButton *btn_position;
@property (strong, nonatomic) ProductViewInitFinishControl productViewInitFinishControl;

@end
