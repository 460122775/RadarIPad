//
//  MainViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize productView, messageView, voiceView, settingView, btn_scrollView;

static MainViewController *instance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        instance = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productAddressReceived:) name:ProductAddressArrived object:nil];
        DLog(@"%@", [DocumentsPath stringByAppendingPathComponent:@"/db/db0_0.db"]);
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
    [self.view setBackgroundColor:BackGroundBlueColor];
    [self.btn_scrollView setBackgroundColor:ForeGroundBlueColor];
    [self.btn_scrollView.layer setCornerRadius:5.0];
    [self.btn_scrollView.layer setMasksToBounds: YES];
    //阴影的颜色
    [self.btn_scrollViewBg.layer setShadowColor: [UIColor blackColor].CGColor];
    [self.btn_scrollViewBg.layer setShadowOffset: CGSizeMake(0, 0)];
    //阴影透明度
    [self.btn_scrollViewBg.layer setShadowOpacity: 1.0];
    //阴影圆角度数
    [self.btn_scrollViewBg.layer setShadowRadius: 5.0];
    [self setProductView: [[ProductView alloc] initWithFrame:CGRectMake(85, 30, 924, 728)]];
    [self.view addSubview:self.productView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma -mark Btn Click Control
- (IBAction)historyBtnClick:(id)sender
{
    if (self.productView != nil)
    {
        [self.productView historyBtnClick];
    }
}

- (IBAction)currentBtnClick:(id)sender
{
    if (self.productView != nil)
    {
        [self.productView showCurrentProduct];
    }
}

- (IBAction)playBtnClick:(id)sender
{
    if (self.productView != nil)
    {
        [self.productView playBtnClick];
    }
}

- (IBAction)camaraBtnClick:(id)sender
{
    if (self.productView != nil)
    {
        [self.productView screenShot];
    }
}

- (IBAction)knifeBtnClick:(id)sender
{
    if (self.productView != nil)
    {
        [self.productView knifeBtnClick:sender];
    }
}

- (IBAction)positionBtnClick:(id)sender
{
    if (self.productView != nil)
    {
        [self.productView showPosition];
    }
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

- (IBAction)voiceBtnClick:(id)sender
{
    if(self.voiceView == nil)
    {
        self.voiceView = [[VoiceView alloc] initWithFrame:CGRectMake(90, 30, 924, 728)];
    }
    [self removeSubviews];
    [self.view addSubview:self.voiceView];
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
        if(view == self.voiceView) self.voiceView = nil;
        else if (view == self.settingView) self.settingView = nil;
        else if (view == self.messageView) self.messageView = nil;
        else if (view == self.btn_scrollView) continue;
        [view removeFromSuperview];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
