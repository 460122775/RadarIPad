//
//  MainViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductFactory.h"
#import "ProductDrawDataProtocol.h"
#import "ProductView.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *btn_scrollView;

@property (strong, nonatomic) IBOutlet UIButton *btn_setting;
@property (strong, nonatomic) IBOutlet UIButton *btn_warning;

@property (strong, nonatomic) ProductView *productView;

@property (strong, nonatomic) id<ProductDrawDataProtocol> currentProductModel;

+ (MainViewController*) instance;

@end
