//
//  MainViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize btn_scrollView,btn_setting,btn_warning;
@synthesize productView, currentProductModel;

static MainViewController *instance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        instance = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productAddressReceived:) name:ProductAddressArrived object:nil];
    }
    return self;
}

+ (MainViewController*) instance
{
    return instance;
}

- (void)loadView
{
    [super loadView];
    // Set round corner...
    for(UIButton *currentBtn in [self.btn_scrollView subviews])
    {
        if (currentBtn != nil)
        {
            currentBtn.layer.cornerRadius = 4;
            currentBtn.layer.masksToBounds = YES;
        }
    }
    
    self.productView = [[ProductView alloc] initWithFrame:CGRectMake(90, 30, 924, 728)];
    [self.view addSubview:self.productView];
    self.productView.productViewInitFinishControl = ^(){
        [self productAddressReceived:nil];
    };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Test ...
    [self productAddressReceived:nil];
}

- (void)productAddressReceived:(id) object
{
    self.currentProductModel = [ProductFactory getProductModel:ProductType_R];
    [self.currentProductModel getImageData:self.productView.productImgView];
    [ColorModel drawColor:ProductType_R andColorImgView:self.productView.colorImgView];
    [self.currentProductModel getProductInfo: self.productView.productInfoView];
}

#pragma -mark Product Control


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
