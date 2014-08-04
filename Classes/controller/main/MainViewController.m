//
//  MainViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize productView, historyView, messageView, voiceView, settingView, currentProductModel, btn_scrollView;

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
//    // Set corner round...
//    for(UIButton *currentBtn in [self.btn_scrollView subviews])
//    {
//        if (currentBtn != nil)
//        {
//            currentBtn.layer.cornerRadius = 4;
//            currentBtn.layer.masksToBounds = YES;
//        }
//    }
    [self productBtnClick:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)productAddressReceived:(id) object
{
    // Test Code.....
    NSString *path = [DataPath stringByAppendingString:@"/20140701/20140701_000218.02.003.000_2.40.zdb"];
    NSData *data = [ProductFactory uncompressZippedData:[NSData dataWithContentsOfFile:path]];
    self.currentProductModel = [ProductFactory getProductModel:ProductType_R];
    [ColorModel drawColor:ProductType_R andColorImgView:self.productView.colorImgView];
    [self.currentProductModel getProductInfo: self.productView.productInfoView andData:data];
    [self.currentProductModel setCenterPointX:self.productView.productImgView.frame.size.width / 2 andY:self.productView.productImgView.frame.size.width / 2];
    [self.currentProductModel getImageData:self.productView.productImgView andData:data];
    [self.currentProductModel drawDistanceCircle:self.productView.mapCircleView];
    return;
    // Test end....
    
    [ProductFactory cacheFileByUrl:@"/20130808/20130808_121238.02.003.000_2.40.zdb" block:^(NSData *data)
     {
        self.currentProductModel = [ProductFactory getProductModel:ProductType_R];
        [ColorModel drawColor:ProductType_R andColorImgView:self.productView.colorImgView];
        [self.currentProductModel getProductInfo: self.productView.productInfoView andData:data];
        [self.currentProductModel getImageData:self.productView.productImgView andData:data];
    }];
}

#pragma -mark Product Control


#pragma -mark Btn Click Control
- (IBAction)productBtnClick:(id)sender
{
    if(self.productView == nil)
    {
        self.productView = [[ProductView alloc] initWithFrame:CGRectMake(90, 30, 924, 728)];
        self.productView.productViewInitFinishControl = ^(){
            [self productAddressReceived:nil];
        };
    }
    [self removeSubviews];
    [self.view addSubview:self.productView];
}

- (IBAction)historyBtnClick:(id)sender
{
    if(self.historyView == nil)
    {
        self.historyView = [[HistoryView alloc] initWithFrame:CGRectMake(90, 30, 924, 728)];
    }
    [self removeSubviews];
    [self.view addSubview:self.historyView];
}

- (IBAction)voiceBtnClick:(id)sender
{
    if(self.voiceView == nil)
    {
        self.voiceView = [[VoiceView alloc] initWithFrame:CGRectMake(90, 30, 924, 728)];
    }
    [self removeSubviews];
    [self.view addSubview:self.voiceView];
}

- (IBAction)messageBtnClick:(id)sender
{
    if(self.messageView == nil)
    {
        self.messageView = [[MessageView alloc] initWithFrame:CGRectMake(90, 30, 924, 728)];
    }
    [self removeSubviews];
    [self.view addSubview:self.messageView];
}

- (IBAction)settingBtnClick:(id)sender
{
    if(self.settingView == nil)
    {
        self.settingView = [[SettingView alloc] initWithFrame:CGRectMake(90, 30, 924, 728)];
    }
    [self removeSubviews];
    [self.view addSubview:self.settingView];
}

- (void)removeSubviews
{
    for(UIView *view in [self.view subviews])
    {
        if(view == self.historyView) self.historyView = nil;
        else if (view == self.voiceView) self.voiceView = nil;
        else if (view == self.settingView) self.settingView = nil;
        else if (view == self.messageView) self.messageView = nil;
        else if (view == self.btn_scrollView) continue;
        [view removeFromSuperview];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
