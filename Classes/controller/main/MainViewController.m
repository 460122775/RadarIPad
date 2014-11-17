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

@synthesize productView, historyView, messageView, voiceView, settingView, btn_scrollView, historyBtn, messageBtn, voiceBtn, settingBtn;

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
        if(self.historyView == nil)
        {
            self.historyView = [[[NSBundle mainBundle] loadNibNamed:@"HistoryView" owner:nil options:nil] objectAtIndex:0];
            self.historyView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, 728);
            self.historyView.delegate = self;
        }
    }else{
        //Change the View.
        [self.productView hideHistoryProductTable];
    }
    [self showViewsControl:self.historyView andBtn:(UIButton*)sender];
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
        if ([(UIButton*)sender tag] != 1)
        {
            [self setBtnSelectTaste:(UIButton*)sender andSelected:YES];
        }else{
            [self setBtnSelectTaste:(UIButton*)sender andSelected:NO];
        }
        [self.productView knifeBtnClick:sender];
    }
}

- (IBAction)positionBtnClick:(id)sender
{
    if (self.productView != nil)
    {
        if ([(UIButton*)sender tag] != 1)
        {
            [self setBtnSelectTaste:(UIButton*)sender andSelected:YES];
        }else{
            [self setBtnSelectTaste:(UIButton*)sender andSelected:NO];
        }
        [self.productView showPosition];
    }
}

- (IBAction)messageBtnClick:(id)sender
{
    if ([(UIButton*)sender tag] != 1)
    {
        if(self.messageView == nil)
        {
            self.messageView = [[[NSBundle mainBundle] loadNibNamed:@"MessageView" owner:nil options:nil] objectAtIndex:0];
            self.messageView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, RightViewHeight);
        }
    }
    [self showViewsControl:self.messageView andBtn:(UIButton*)sender];
}

- (IBAction)voiceBtnClick:(id)sender
{
    if ([(UIButton*)sender tag] != 1)
    {
        if(self.voiceView == nil)
        {
            self.voiceView = [[[NSBundle mainBundle] loadNibNamed:@"VoiceView" owner:nil options:nil] objectAtIndex:0];
            self.voiceView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, RightViewHeight);
        }
    }
    [self showViewsControl:self.voiceView andBtn:(UIButton*)sender];
}

- (IBAction)settingBtnClick:(id)sender
{
    if ([(UIButton*)sender tag] != 1)
    {
        if(self.settingView == nil)
        {
            self.settingView = [[[NSBundle mainBundle] loadNibNamed:@"SettingView" owner:nil options:nil] objectAtIndex:0];
            self.settingView.frame = CGRectMake(RightViewXPoint, VPadding, RightViewWidth, RightViewHeight);
        }
    }
    [self showViewsControl:self.settingView andBtn:(UIButton*)sender];
}

- (void) setBtnSelectTaste:(UIButton *)btn andSelected:(BOOL)selectedValue
{
    if (selectedValue == YES)
    {
        btn.tag = 1;
        [btn.layer setBorderColor:[BackGroundBlueColor CGColor]];
        [btn.layer setBorderWidth:4];
        [btn.layer setCornerRadius:10.0];
    }else{
        btn.tag = 0;
        [btn.layer setBorderWidth:0];
    }
}

- (void)showViewsControl:(UIView*) addView andBtn:(UIButton*) btn
{
    for(UIView *view in [self.view subviews])
    {
        if(view != self.btn_scrollViewBg)
        {
            [view removeFromSuperview];
        }
    }
    int tagValue = btn.tag;
    [self setBtnSelectTaste:self.historyBtn andSelected:NO];
    [self setBtnSelectTaste:self.messageBtn andSelected:NO];
    [self setBtnSelectTaste:self.voiceBtn andSelected:NO];
    [self setBtnSelectTaste:self.settingBtn andSelected:NO];
    if (tagValue != 1)
    {
        [self.view addSubview:addView];
        [self setBtnSelectTaste:btn andSelected:YES];
    }else{
        [self.view addSubview:self.productView];
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
