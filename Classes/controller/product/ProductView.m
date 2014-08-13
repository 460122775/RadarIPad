//
//  ProductView.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/23/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "ProductView.h"

#define ZoomStep 0.4
#define dragStep 100
#define ProductContainer_Width 640
#define ProductContainer_height 640
#define ProductThemeColor ForeGroundBlueColor

@implementation ProductView

@synthesize productImgView, mapCircleView, colorImgView, rightBarView, radarInfoBarView, productInfoView, currentProductModel, currentProductData, productControlView, processControlView, slider, knifeLineView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:BackGroundBlueColor];
        // Test Code.....
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Left Area.
    self.productView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height)];
    [self.productView setBackgroundColor:ProductThemeColor];
    [self.productView setClipsToBounds:YES];
    [self addSubview:self.productView];
    
    self.productImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height)];
    [self.productImgView setBackgroundColor:[UIColor clearColor]];
    [self.productView addSubview:self.productImgView];
    
    self.mapCircleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height)];
    [self.mapCircleView setBackgroundColor:[UIColor clearColor]];
    [self.productView addSubview:self.mapCircleView];
    
    zoomGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(imgZoomControl:)];
    [self.productView addGestureRecognizer:zoomGestureRecognizer];
    
//    dragGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imgDragControl:)];
//    dragGestureRecognizer.minimumNumberOfTouches = 1;
//    dragGestureRecognizer.maximumNumberOfTouches = 1;
//    [self.productView addGestureRecognizer:dragGestureRecognizer];
    
    switchGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imgSwitchcControl:)];
    switchGestureRecognizer.minimumNumberOfTouches = 1;
    switchGestureRecognizer.maximumNumberOfTouches = 1;
    [self.productView addGestureRecognizer:switchGestureRecognizer];
    
    
    self.processControlView = [[UIView alloc] initWithFrame:CGRectMake(0, ProductContainer_height, ProductContainer_Width, 30)];
    [self.processControlView setBackgroundColor:ProductThemeColor];
    [self addSubview:self.processControlView];
    
    //Bottom
    self.slider = [[ASValueTrackingSlider alloc] initWithFrame:CGRectMake(18, 0, ProductContainer_Width - 40, 30)];
    self.slider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:26];
    self.slider.popUpViewAnimatedColors = @[BackGroundBlueColor];
    self.slider.maximumValue = 100;
    self.slider.minimumValue = 0;
    self.slider.popUpViewCornerRadius = 6;
    self.slider.dataSource = self;
    self.slider.delegate = self;
//    self.slider.value = self.slider.maximumValue / 2;
//    [self.slider setMaxFractionDigitsDisplayed:0];
//    self.slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
//    self.slider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:22];
//    self.slider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    [self.processControlView addSubview: self.slider];
    
    self.colorImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ProductContainer_height + 30, ProductContainer_Width, 58)];
    [self.colorImgView setBackgroundColor:ProductThemeColor];
    [self addSubview:self.colorImgView];
    
    // Right Area.
    self.rightBarView = [[UIView alloc] initWithFrame:CGRectMake(ProductContainer_Width + 1, 0, 288, 728)];
    [self.rightBarView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.rightBarView];

    // Radar Info.
    self.radarInfoBarView = [[UIView alloc] initWithFrame:
                             CGRectMake(0, 0, self.rightBarView.frame.size.width, 35)];
    [self.radarInfoBarView setBackgroundColor:ProductThemeColor];
    [self.rightBarView addSubview:self.radarInfoBarView];
    
    UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 20)];
    [positionLabel setTextColor:ProductTextColor];
    [positionLabel setText:@"方位:235.28"];
    [positionLabel setFont:[UIFont systemFontOfSize:17]];
    [self.radarInfoBarView addSubview:positionLabel];
    
    UILabel *eleLabel = [[UILabel alloc] initWithFrame:CGRectMake(113, 8, 80, 20)];
    [eleLabel setTextColor:ProductTextColor];
    [eleLabel setText:@"俯仰:19.8"];
    [eleLabel setFont:[UIFont systemFontOfSize:17]];
    [self.radarInfoBarView addSubview:eleLabel];
    
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(198, 8, 100, 20)];
    [speedLabel setTextColor:ProductTextColor];
    [speedLabel setText:@"速率:32.92"];
    [speedLabel setFont:[UIFont systemFontOfSize:17]];
    [self.radarInfoBarView addSubview:speedLabel];

    // Product Info.
    self.productInfoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35 + 1, self.rightBarView.frame.size.width, 280)];
    [self.productInfoView setBackgroundColor:ProductThemeColor];
    [self.rightBarView addSubview:self.productInfoView];
    
    // Product Control.
    self.productControlView = [[UIView alloc] initWithFrame:CGRectMake(0, 35 + 280 + 2, self.rightBarView.frame.size.width, 411)];
    [self.productControlView setBackgroundColor:ProductThemeColor];
    [self.rightBarView addSubview:self.productControlView];
    
    [self showCurrentProduct];
}

- (void)productAddressReceived
{
    // Test Code.....
    if (self.currentProductModel == nil)
    {
        self.currentProductModel = [ProductFactory getProductModel:ProductType_R];
        self.currentProductModel.productInfo = [[ProductInfo alloc] initWithPosFileStr:@"/20140701_001556.06.003.000_6.19.zdb"];
    }
    self.currentProductData = [ProductFactory uncompressZippedData:[NSData dataWithContentsOfFile:
                                [DataPath stringByAppendingString:self.currentProductModel.productInfo.dataAddress]]];
    [ColorModel drawColor:self.currentProductModel.productInfo.productType andColorImgView:self.colorImgView];
    [self.currentProductModel getProductInfo: self.productInfoView andData:self.currentProductData];
    self.currentProductModel.centX = self.productImgView.frame.size.width / 2;
    self.currentProductModel.centY = self.productImgView.frame.size.height / 2;
    [self drawProduct];
    return;
    // Test end....
    
    [ProductFactory cacheFileByUrl:self.currentProductModel.productInfo.dataAddress block:^(NSData *data)
     {
         self.currentProductModel = [ProductFactory getProductModel:self.currentProductModel.productInfo.productType];
         [ColorModel drawColor:self.currentProductModel.productInfo.productType andColorImgView:self.colorImgView];
         [self.currentProductModel getProductInfo: self.productInfoView andData:data];
         [self.currentProductModel getImageData:self.productImgView andData:data];
     }];
}

- (void)drawProduct
{
    [self.currentProductModel getImageData:self.productImgView andData:self.currentProductData];
    [self.currentProductModel drawDistanceCircle:self.mapCircleView];
    if (locationManager != nil)
    {
        [self updatePositionPoint];
    }
}

- (void)selectProduct:(id)productObject
{
    self.currentProductModel = [ProductFactory getProductModel:((ProductInfo*)productObject).productType];
    self.currentProductModel.productInfo = (ProductInfo*) productObject;
    self.currentProductData = [ProductFactory uncompressZippedData:
                               [NSData dataWithContentsOfFile:[DataPath stringByAppendingString:self.currentProductModel.productInfo.dataAddress]]];
    [ColorModel drawColor:self.currentProductModel.productInfo.productType andColorImgView:self.colorImgView];
    [self.currentProductModel getProductInfo: self.productInfoView andData:self.currentProductData];
    self.currentProductModel.centX = self.productImgView.frame.size.width / 2;
    self.currentProductModel.centY = self.productImgView.frame.size.height / 2;
    [self drawProduct];
    [historyView removeFromSuperview];
}

#pragma -mark ASValueTrackingSliderDataSource
static int lastIntValue = -1;
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    int intValue = roundf(value);
    if (self.slider.tag == 100 && lastIntValue != intValue) [self playTimerFired:nil];
    lastIntValue = value;
    return [NSString stringWithFormat:@"第%@帧", [self.slider.numberFormatter stringFromNumber:@(intValue)]];
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider
{
    self.slider.tag = 100;
}

- (void)sliderDidHidePopUpView:(ASValueTrackingSlider *)slider
{
    self.slider.tag = 0;
}

-(void) playTimerFired:(id) sender
{
    if (playTimer!= nil && self.slider.value > historyProductListView.productDataArray.count)
    {
        [playTimer invalidate];
        playTimer = nil;
        return;
    }
    //Test Code...
    NSString *productStr = (NSString*)[historyProductListView.productDataArray objectAtIndex:self.slider.value - 1];
    ProductInfo *vo = [[ProductInfo alloc] initWithPosFileStr:[NSString stringWithFormat:@"/%@.zdb",[productStr substringWithRange:NSMakeRange(0, productStr.length - 5)]]];
    [self selectProduct:vo];
    productStr = nil;
    vo = nil;
    if (self.slider.tag != 100)
    {
        self.slider.value++;
    }
    //Test End...
}

#pragma -mark Btn Click Control
static bool knifeStart = NO;
- (void)knifeBtnClick:(id) sender
{
    UIButton *knifeBtn = (UIButton*)sender;
    if (knifeStart == NO)
    {
        knifeStart = YES;
        if (knifeGestureRecognizer == nil)
        {
            knifeGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(knifeDragControl:)];
            knifeGestureRecognizer.minimumNumberOfTouches = 1;
            knifeGestureRecognizer.maximumNumberOfTouches = 1;
            [self.productView addGestureRecognizer:knifeGestureRecognizer];
        }
        if (self.knifeLineView == nil)
        {
            self.knifeLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height)];
            [self.knifeLineView setBackgroundColor:[UIColor clearColor]];
            [self.productView addSubview:self.knifeLineView];
        }
        [knifeBtn.layer setBorderColor:[[UIColor purpleColor] CGColor]];
        [knifeBtn.layer setBorderWidth:8];
    }else{
        knifeStart = NO;
        knifeGestureRecognizer = nil;
        [self.knifeLineView removeFromSuperview];
        self.knifeLineView = nil;
        [knifeBtn.layer setBorderWidth:0];
    }
}

- (void)showCurrentProduct
{
    if (historyView != nil)
    {
        [historyView removeFromSuperview];
        historyView = nil;
    }
    if (historyProductListView != nil)
    {
        [historyProductListView removeFromSuperview];
        historyProductListView = nil;
    }
    currentProductListView = [[CurrentProductListView alloc] initWithFrame:CGRectMake(0, 0, self.productControlView.frame.size.width, self.productControlView.frame.size.height)];
    currentProductListView.delegate = self;
    [self.productControlView addSubview:currentProductListView];
    self.currentProductModel = nil;
    [self productAddressReceived];
}

- (void)historyBtnClick
{
    if(historyView == nil)
    {
        historyView = [[[NSBundle mainBundle] loadNibNamed:@"HistoryView" owner:nil options:nil] objectAtIndex:0];
        historyView.frame = CGRectMake(0, 0, 640, 728);
    }
    [self addSubview:historyView];
    
    if (currentProductListView != nil)
    {
        [currentProductListView removeFromSuperview];
        currentProductListView = nil;
    }
    historyProductListView = [[HistoryProductListView alloc] initWithFrame:CGRectMake(0, 0, self.productControlView.frame.size.width, self.productControlView.frame.size.height)];
    [self.productControlView addSubview:historyProductListView];
    historyProductListView.delegate = self;
}

- (void)playBtnClick
{
    if (historyProductListView != nil)
    {
        playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playTimerFired:) userInfo:nil repeats:YES];
        self.slider.maximumValue = historyProductListView.productDataArray.count + 1;
        self.slider.minimumValue = 1;
        self.slider.value = 1;
        [playTimer fire];
    }
}

- (void)screenShot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
    
    NSArray *shareButtonTitleArray = [[NSArray alloc] init];
    NSArray *shareButtonImageNameArray = [[NSArray alloc] init];
    shareButtonTitleArray = @[@"短信",@"邮件",@"新浪微博",@"微信",@"微信朋友圈",@"Twitter"];
    shareButtonImageNameArray = @[@"sns_icon_19",@"sns_icon_18",@"sns_icon_1",@"sns_icon_22",@"sns_icon_23",@"sns_icon_11"];
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"截图已保存至相册\n   需要分享到社交平台吗？" delegate:nil cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self];
}

- (void)showPosition
{
    if (nil == locationManager)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        pulsingView = [[SVPulsingAnnotationView alloc] initWithFrame:CGRectMake(-100,-100,30,30)];
        pulsingView.annotationColor = RGBA(0, 0, 255, 1);
        pulsingView.canShowCallout = YES;
        [self.productView addSubview:pulsingView];
        // Set a movement threshold for new events
        locationManager.distanceFilter = 500;
        [locationManager startUpdatingLocation];
    }else{
        [locationManager stopUpdatingLocation];
        locationManager = nil;
        [pulsingView removeFromSuperview];
        pulsingView = nil;
    }
}

#pragma -mark CLLocationManagerDelegate Method
static CGPoint point;
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 5.0)
    {
        point = CGPointMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
        [self updatePositionPoint];
    }
}

-(void) updatePositionPoint
{
    point = [self.currentProductModel getPointByPosition:point andFrame:self.productImgView.frame];
    pulsingView.frame = CGRectMake(point.x, point.y, 20, 20);
}

#pragma -mark UIGestureRecognizer Method
-(void)imgZoomControl:(UIPinchGestureRecognizer*)sender
{
    if([sender state] == UIGestureRecognizerStateEnded)
    {
        float currentScale = [(UIPinchGestureRecognizer*)sender scale];
        if (currentScale > 1.0)
        {
            self.currentProductModel.zoomValue += (ZoomStep * (int)currentScale);
        }else{
            self.currentProductModel.zoomValue -= (ZoomStep * (int)((1 - currentScale) * 6));
        }
        if(self.currentProductModel.zoomValue > 10)
        {
            self.currentProductModel.zoomValue = 10;
        }else if(self.currentProductModel.zoomValue < 0.6){
            self.currentProductModel.zoomValue = 0.6;
        }
        [self drawProduct];
    }
}

static CGPoint dragLocation;
-(void)imgDragControl:(UIPanGestureRecognizer*)paramSender
{
    if (knifeStart == YES) return;
    CGPoint location = [paramSender locationInView:paramSender.view.superview];
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        dragLocation.x = location.x;
        dragLocation.y = location.y;
    }else if (paramSender.state == UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        if (abs(dragLocation.x - location.x) >= 10 || abs(dragLocation.y - location.y) >= 10)
        {
            self.currentProductModel.centX -= (dragLocation.x - location.x);
            self.currentProductModel.centY -= (dragLocation.y - location.y);
        }
        self.productImgView.frame = CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height);
        self.mapCircleView.frame = CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height);
        [self drawProduct];
    }else{
        self.productImgView.frame = CGRectMake(location.x - dragLocation.x,
                                               location.y - dragLocation.y,
                                               ProductContainer_Width, ProductContainer_height);
        self.mapCircleView.frame = CGRectMake(self.productImgView.frame.origin.x,
                                              self.productImgView.frame.origin.y,
                                              ProductContainer_Width, ProductContainer_height);
    }
}

-(void)imgSwitchcControl:(UIPanGestureRecognizer*)paramSender
{
    if (knifeStart == YES) return;
    CGPoint location = [paramSender locationInView:paramSender.view.superview];
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        dragLocation.x = location.x;
        dragLocation.y = location.y;
    }else if (paramSender.state == UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        // Gesture Valid...
        if (abs(dragLocation.x - location.x) >= 10 || abs(dragLocation.y - location.y) >= 10)
        {
            // Horizontal.
            if (abs(dragLocation.x - location.x) > abs(dragLocation.y - location.y))
            {
                // Turn left.
                if (dragLocation.x - location.x > 0)
                {
                    self.currentProductModel.productInfo.dataAddress = [DBModel getProductData:3 andCurrentData:self.currentProductModel.productInfo.dataAddress];
                }else{ // Turn right.
                    self.currentProductModel.productInfo.dataAddress = [DBModel getProductData:4 andCurrentData:self.currentProductModel.productInfo.dataAddress];
                }
            }else{// Vertical.
                // Turn up.
                if (dragLocation.y - location.y > 0)
                {
                    self.currentProductModel.productInfo.dataAddress = [DBModel getProductData:1 andCurrentData:self.currentProductModel.productInfo.dataAddress];
                }else{// Turn down.
                    self.currentProductModel.productInfo.dataAddress = [DBModel getProductData:2 andCurrentData:self.currentProductModel.productInfo.dataAddress];
                }
            }
            [self productAddressReceived];
        }
    }
}

-(void)knifeDragControl:(UIPanGestureRecognizer*)paramSender
{
    if (knifeStart == NO) return;
    CGPoint location = [paramSender locationInView:paramSender.view.superview];
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        dragLocation.x = location.x;
        dragLocation.y = location.y;
    }else if (paramSender.state == UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        
        if (abs(dragLocation.x - location.x) >= 10 || abs(dragLocation.y - location.y) >= 10)
        {
            self.currentProductModel.centX -= (dragLocation.x - location.x);
            self.currentProductModel.centY -= (dragLocation.y - location.y);
        }
        UIGraphicsBeginImageContext(self.knifeLineView.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 3);
        CGContextBeginPath(context);
        
        CGContextMoveToPoint(context, dragLocation.x, dragLocation.y);
        CGContextAddLineToPoint(context, location.x, location.y);
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
        CGContextStrokePath(context);
        // Show image...
        self.knifeLineView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        knifeStart = NO;
    }
}

@end
