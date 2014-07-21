//
//  MainViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btn_shot;
@property (strong, nonatomic) IBOutlet UIButton *btn_knife;
@property (strong, nonatomic) IBOutlet UIButton *btn_current;
@property (strong, nonatomic) IBOutlet UIButton *btn_cartoon;
@property (strong, nonatomic) IBOutlet UIButton *btn_screenshot;
@property (strong, nonatomic) IBOutlet UIButton *btn_position;
@property (strong, nonatomic) IBOutlet UIButton *btn_setting;
@property (strong, nonatomic) IBOutlet UIButton *btn_warning;

@property (strong, nonatomic) IBOutlet UIImageView *productImgView;

@property (strong, nonatomic) IBOutlet UIView *rightBarView;

@property (strong, nonatomic) IBOutlet UIView *productColorView;

@end
