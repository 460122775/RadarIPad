//
//  MainViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize btn_cartoon, btn_current, btn_knife, btn_position, btn_screenshot, btn_setting, btn_shot, btn_warning;
@synthesize ColorImgView, productImgView, rightBarView, currentProductModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    NSLog(@"111");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // TEST....
    self.currentProductModel = [ProductFactory getProductModel:ProductType_R];
    [self.currentProductModel getImageData:self.productImgView];
    [ColorModel drawColor:ProductType_R andColorImgView:self.ColorImgView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
