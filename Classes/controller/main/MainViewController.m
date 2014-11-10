//
//  MainViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MainViewController.h"

#define RightViewWidth 924
#define RightViewHeight 728
#define ViewGap 15
#define HPadding 10
#define VPadding 30
#define RightViewXPoint HPadding + ViewGap + 65

@implementation MainViewController

@synthesize productView, historyView, messageView, voiceView, settingView, btn_scrollView;

static MainViewController *instance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        instance = self;
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productAddressReceived:) name:ProductAddressArrived object:nil];
//        DLog(@"%@", [DocumentsPath stringByAppendingPathComponent:@"/db/db0_0.db"]);
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
    [ProductView setShadowTaste:self.btn_scrollViewBg andForeView:self.btn_scrollView];
    //Create Product View.
    [self setProductView:[[[NSBundle mainBundle] loadNibNamed:@"ProductView" owner:nil options:nil] objectAtIndex:0]];
    [self.productView setFrame:CGRectMake(RightViewXPoint, VPadding, RightViewWidth, RightViewHeight)];
    [self.productView setDelegate:self];
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
    if ([(UIButton*)sender tag] != 1)
    {
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        if(self.historyView == nil)
        {
            self.historyView = [[[NSBundle mainBundle] loadNibNamed:@"HistoryView" owner:nil options:nil] objectAtIndex:0];
            self.historyView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, 728);
            self.historyView.delegate = self;
        }
        [self.view addSubview:self.historyView];
        [self.productView removeFromSuperview];
    }else{
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        //Change the View.
        [self.view addSubview:self.productView];
        [self.productView hideHistoryProductTable];
        [self.historyView removeFromSuperview];
    }
}

- (IBAction)playBtnClick:(id)sender
{
    if (self.productView != nil && self.historyView != nil)
    {
        [self.productView showHistoryProductTable:[self.historyView.historyProductListView getArrayByProductType:[self.historyView getSelectedProductType]] andIndex:0];
        [self.productView playBtnClick:[self.historyView.historyProductListView getArrayByProductType:[self.historyView getSelectedProductType]]];
    }
    if (self.historyView != nil) [self.historyView removeFromSuperview];
    [self.view addSubview:self.productView];
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
    [ProductView setBtnSelectTaste:(UIButton*)sender];
    if (self.productView != nil)
    {
        [self.productView showPosition];
    }
}

- (IBAction)messageBtnClick:(id)sender
{
    if ([(UIButton*)sender tag] != 1)
    {
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        if(self.messageView == nil)
        {
            self.messageView = [[[NSBundle mainBundle] loadNibNamed:@"MessageView" owner:nil options:nil] objectAtIndex:0];
            self.messageView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, RightViewHeight);
        }
        [self removeSubviewsExceptView:self.messageView];
    }else{
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        [self.messageView removeFromSuperview];
    }
}

- (IBAction)voiceBtnClick:(id)sender
{
    if ([(UIButton*)sender tag] != 1)
    {
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        if(self.voiceView == nil)
        {
            self.voiceView = [[[NSBundle mainBundle] loadNibNamed:@"VoiceView" owner:nil options:nil] objectAtIndex:0];
            self.voiceView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, RightViewHeight);
        }

        [self removeSubviewsExceptView:self.voiceView];
    }else{
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        [self.voiceView removeFromSuperview];
    }
    
}

- (IBAction)settingBtnClick:(id)sender
{
    if ([(UIButton*)sender tag] != 1)
    {
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        if(self.settingView == nil)
        {
            
            self.settingView = [[[NSBundle mainBundle] loadNibNamed:@"SettingView" owner:nil options:nil] objectAtIndex:0];
            self.settingView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, RightViewHeight);
        }
        [self removeSubviewsExceptView:self.settingView];
    }else{
        [ProductView setBtnSelectTaste:(UIButton*)sender];
        [self.settingView removeFromSuperview];
    }
}

- (void)removeSubviewsExceptView:(UIView*) addView
{
    for(UIView *view in [self.view subviews])
    {
        if(view != self.btn_scrollViewBg)
        {
            [view removeFromSuperview];
        }
//            self.voiceView = nil;
//        else if (view == self.settingView) self.settingView = nil;
//        else if (view == self.messageView) self.messageView = nil;
//        else if (view == self.btn_scrollViewBg) continue;
    }
    [self.view addSubview:addView];
    if (addView != self.productView)
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - HistoryViewProtocol
- (void)selectProduct:(int) index inDataArray:(NSMutableArray*) dataArray
{
    [self.historyView removeFromSuperview];
    [self.view addSubview:self.productView];
    [self.productView showHistoryProductTable:dataArray andIndex:index];
}

#pragma mark - ProductViewProtocol
- (void)historyQueryRetryControl
{
    [self.productView removeFromSuperview];
    [self.view addSubview:self.historyView];
}

@end
