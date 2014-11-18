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
#define ProductContainer_Width 620
#define ProductContainer_height 620
#define ProductThemeColor ForeGroundBlueColor

@implementation ProductView

@synthesize productImgView, productViewBg, mapCircleView, colorImgView, rightBarView, rightBarViewBg, radarInfoBarView, productInfoView, currentProductModel, currentProductData, productControlView, processControlView, slider, imgContainerView, historyDataArray, productTitleLabel, backMultipleBtn, backBtn, forwardBtn, forwardMultipleBtn, continueBtn,mapView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Test Code.....
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Left Area.
    [self.imgContainerView setClipsToBounds:YES];
    
    // Set Shadow.
    [ProductView setShadowTaste:self.productViewBg andForeView:self.productView];
    [ProductView setShadowTaste:self.rightBarViewBg andForeView:self.rightBarView];
    
    // Set background color.
    [self.productTitleLabel setBackgroundColor:ProductThemeColor];
    [self.processControlView setBackgroundColor:ProductThemeColor];
    [self.colorImgView setBackgroundColor:ProductThemeColor];
    [self.radarInfoBarView setBackgroundColor:ProductThemeColor];
    [self.productInfoView setBackgroundColor:ProductThemeColor];
    [self.productControlView setBackgroundColor:ProductThemeColor];
    
    self.mapView.tileSource = [[RMMapboxSource alloc] initWithMapID:@"daiyachen.k71impl7"];
    self.mapView.delegate = self;
    self.mapView.zoom = 9.5;
    [self.mapView showsUserLocation];
    [self.mapView setBackgroundColor:[UIColor clearColor]];

    // Set Guesture.
    zoomGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(imgZoomControl:)];
    [self.imgContainerView addGestureRecognizer:zoomGestureRecognizer];
    
    dragGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imgDragControl:)];
    dragGestureRecognizer.minimumNumberOfTouches = 1;
    dragGestureRecognizer.maximumNumberOfTouches = 1;
    [self.imgContainerView addGestureRecognizer:dragGestureRecognizer];
    
    switchGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imgSwitchcControl:)];
    switchGestureRecognizer.minimumNumberOfTouches = 2;
    switchGestureRecognizer.maximumNumberOfTouches = 2;
    [self.imgContainerView addGestureRecognizer:switchGestureRecognizer];
    
    //Bottom
    self.slider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:26];
    self.slider.popUpViewAnimatedColors = @[BackGroundBlueColor];
    self.slider.minimumValue = 1;
    self.slider.popUpViewCornerRadius = 6;
    self.slider.dataSource = self;
    self.slider.delegate = self;
    self.slider.enabled = NO;
    
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
    
    // Show Current Product
    currentProductListView = [[CurrentProductListView alloc] initWithFrame:CGRectMake(0, 0, self.productControlView.frame.size.width, self.productControlView.frame.size.height)];
    currentProductListView.delegate = self;
    [self.productControlView addSubview:currentProductListView];
    self.currentProductModel = nil;
    [self productAddressReceived:nil];
    self.slider.enabled = NO;
}

+ (void) setShadowTaste:(UIView *)backView andForeView:(UIView *)foreView
{
    [foreView.layer setCornerRadius:8.0];
    [foreView.layer setMasksToBounds: YES];
    //阴影的颜色
    [backView.layer setShadowColor:[UIColor blackColor].CGColor];
    [backView.layer setShadowOffset:CGSizeMake(1, 1)];
    //阴影透明度
    [backView.layer setShadowOpacity:1.0];
    //阴影圆角度数
    [backView.layer setShadowRadius:8.0];
}

- (void)productAddressReceived:(NSString*) addressStr
{
    // ************** Test Code Start **************
    ProductInfo *productInfo = nil;
    if (addressStr != nil)
    {
        productInfo = [[ProductInfo alloc] initWithPosFileStr:addressStr];
    }else{
        productInfo = [[ProductInfo alloc] initWithPosFileStr:@"/20140701_001556.06.003.000_6.19.zdb"];
    }
    [self selectProduct:productInfo];
    productInfo = nil;
    // ************** Test Code End **************
    
//    [ProductFactory cacheFileByUrl:self.currentProductModel.productInfo.dataAddress block:^(NSData *data)
//     {
//         self.currentProductModel = [ProductFactory getProductModel:self.currentProductModel.productInfo.productType];
//         [ColorModel drawColor:self.currentProductModel.productInfo.productType andColorImgView:self.colorImgView];
//         [self.currentProductModel getProductInfo: self.productInfoView TitleLabel:self.productTitleLabel Data:data];
//         [self.currentProductModel getImageData:self.productImgView andData:data];
//     }];
}

- (void)drawProduct
{
    [self.currentProductModel getImageData:self.productImgView andData:self.currentProductData];
    [self.currentProductModel drawDistanceCircle:self.mapCircleView];
    if (locationManager != nil)
    {
        // Current Position Point.
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
    [self.currentProductModel getProductInfo: self.productInfoView TitleLabel:self.productTitleLabel Data:self.currentProductData];
    self.currentProductModel.centX = self.productImgView.frame.size.width / 2;
    self.currentProductModel.centY = self.productImgView.frame.size.height / 2;
    [self drawProduct];
    [self.mapView setCenterCoordinate:[self.currentProductModel getRadarCenterPosition] animated:YES];
}

#pragma -mark historyControl btn click
- (IBAction)backMultipleBtnClick:(id)sender
{
    if (step < 0)
    {
        step *= 2;
    }else{
        step /= 2;
        if (step == 0) step = -1;
    }
}

- (IBAction)backBtnClick:(id)sender
{
    if (self.slider.value > 1)
    {
        self.slider.value--;
        [self drawProductBySliderValue];
    }
}

- (IBAction)forwardBtnClick:(id)sender
{
    if (self.slider.value < self.historyDataArray.count)
    {
        self.slider.value++;
        [self drawProductBySliderValue];
    }
}

- (IBAction)forwardMultipleBtnClick:(id)sender
{
    if (step > 0)
    {
        step *= 2;
        if (step >= 16) step = 16;
    }else{
        step /= 2;
        if (step == 0) step = 1;
    }
}

- (IBAction)continueBtnClick:(id)sender
{
    // Stopping.
    if (self.continueBtn.tag == 0)
    {
        if(currentValue == self.historyDataArray.count)
        {
            currentValue = 1;
            self.slider.value = -1;
            step = 1;
        }
        self.continueBtn.tag = 1;
        [self.continueBtn setTitle:@"‖" forState:UIControlStateNormal];
        self.backMultipleBtn.enabled = YES;
        self.forwardMultipleBtn.enabled = YES;
        playTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(playTimerFired:) userInfo:nil repeats:YES];
        [playTimer fire];
    // Playing.
    }else{
        self.continueBtn.tag = 0;
        [self.continueBtn setTitle:@"▷" forState:UIControlStateNormal];
        self.backMultipleBtn.enabled = NO;
        self.forwardMultipleBtn.enabled = NO;
        if(playTimer != nil) [playTimer invalidate];
        playTimer = nil;
    }
}

//- (IBAction)stopBtnClick:(id)sender
//{
//    self.continueBtn.tag = 1;
//    [self continueBtnClick:nil];
//    step = 1;
//}

#pragma -mark ASValueTrackingSliderDataSource
static int lastIntValue = -1;
static int currentValue = 1;
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    currentValue = roundf(value);
    lastIntValue = value;
    return [NSString stringWithFormat:@"第%@帧", [self.slider.numberFormatter stringFromNumber:@(currentValue)]];
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider
{
    self.slider.tag = 100;
    self.continueBtn.tag = 1;
    [self continueBtnClick:nil];
}

- (void)sliderDidHidePopUpView:(ASValueTrackingSlider *)slider
{
    self.slider.tag = 0;
    [self playTimerFired:nil];
}

static int step = 1;
-(void) playTimerFired:(id) sender
{
    if (self.slider.tag != 100
        && ((step > 0 && currentValue >= self.historyDataArray.count) || (step < 0 && currentValue <= 1)))
    {
        [self continueBtnClick:nil];
    }
    //Test Code...
    [self drawProductBySliderValue];
    if (self.slider.tag != 100)
    {
        self.slider.value = currentValue;
        if (self.slider.value + step <= 1)
        {
//            self.slider.value = 1;
            currentValue = 1;
        }else if(self.slider.value + step > self.historyDataArray.count){
//            self.slider.value = self.historyDataArray.count;
            currentValue = self.historyDataArray.count;
        }else{
//            self.slider.value += step;
            currentValue += step;
        }
    }
    //Test End...
}

- (void)drawProductBySliderValue
{
//    DLog(@">>>>>%f",self.slider.value);
    if (currentValue <= self.historyDataArray.count && currentValue >= 1)
    {
        NSString *productStr = (NSString*)[self.historyDataArray objectAtIndex:currentValue - 1];
        ProductInfo *vo = [[ProductInfo alloc] initWithPosFileStr:[NSString stringWithFormat:@"/%@.zdb",[productStr substringWithRange:NSMakeRange(0, productStr.length - 5)]]];
        [self selectProduct:vo];
        productStr = nil;
        vo = nil;
    }
}

#pragma -mark Btn Click Control
- (void)playBtnClick:(NSMutableArray*)_historyDataArray
{
    self.historyDataArray = _historyDataArray;
    [historyProductListView.tableView reloadData];
    self.slider.maximumValue = self.historyDataArray.count;
    self.slider.value = 1;
    step = 1;
    self.continueBtn.tag = 0;
    [self continueBtnClick:nil];
    self.slider.enabled = YES;
    self.backMultipleBtn.enabled = YES;
    self.backBtn.enabled = YES;
    self.forwardMultipleBtn.enabled = YES;
    self.forwardBtn.enabled = YES;
    self.continueBtn.enabled = YES;
//    self.stopBtn.enabled = YES;
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
        // Create location Point.
        pulsingView = [[SVPulsingAnnotationView alloc] initWithFrame:CGRectMake(-100,-100,30,30)];
        pulsingView.annotationColor = RGBA(0, 0, 255, 1);
        pulsingView.canShowCallout = YES;
        [self.imgContainerView addSubview:pulsingView];
        //Create Direction Point.
        directionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 26, 26)];
        [directionImgView setImage:[UIImage imageNamed:@"gps_btn.png"]];
        directionImgView.userInteractionEnabled=YES;
        positionBtnGestureRecognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
        [directionImgView addGestureRecognizer:positionBtnGestureRecognizer];
        [self.imgContainerView addSubview:directionImgView];
//        self.imgContainerView.transform = CGAffineTransformMakeRotation(M_PI);
    
        // Create location manager.
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = 500;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [locationManager requestAlwaysAuthorization];
        }
        // Set a movement threshold for new events
        [locationManager startUpdatingLocation];
        [self updatePositionPoint];
    }else{
        [locationManager stopUpdatingLocation];
        locationManager = nil;
        [pulsingView removeFromSuperview];
        pulsingView = nil;
        [directionImgView removeFromSuperview];
        directionImgView = nil;
    }
}

- (void)onClickImage
{
//    point = [self.currentProductModel getPointByPosition:currentLocation andFrame:self.productImgView.frame];
    [self.mapView setCenterCoordinate:currentLocation.coordinate animated:YES];
    self.currentProductModel.centX = self.currentProductModel.centX - pulsingView.frame.origin.x + ProductContainer_Width / 2;
    self.currentProductModel.centY = self.currentProductModel.centY - pulsingView.frame.origin.y + ProductContainer_height / 2;
    
    [self drawProduct];
}

- (void)knifeBtnClick:(id) sender
{
    if(knifeBtn == nil) knifeBtn = (UIButton*)sender;
    if (knifeBtn.tag == 1)
    {
        if (knifeGestureRecognizer == nil)
        {
            knifeGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(knifeDragControl:)];
            knifeGestureRecognizer.minimumNumberOfTouches = 1;
            knifeGestureRecognizer.maximumNumberOfTouches = 1;
            [self.imgContainerView addGestureRecognizer:knifeGestureRecognizer];
        }
        if (knifeLineView == nil)
        {
            knifeLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height)];
            [knifeLineView setBackgroundColor:[UIColor clearColor]];
            [self.imgContainerView addSubview:knifeLineView];
        }
    }else{
        [self.imgContainerView removeGestureRecognizer:knifeGestureRecognizer];
        knifeGestureRecognizer = nil;
        [knifeLineView removeFromSuperview];
        knifeLineView = nil;
    }
}

- (void)knifeAlertControl
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"请确认" contentText:@"要沿此位置进行切割吗？" leftButtonTitle:@"切割" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        DLog(@"left button clicked");
    };
    alert.rightBlock = ^() {
        DLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        DLog(@"Do something interesting after dismiss block");
    };
}

#pragma -mark CLLocationManagerDelegate Method
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
{
    currentLocation = (CLLocation*)[locations objectAtIndex:0];
    DLog(@">>>>>>%f, %f", currentLocation.coordinate.latitude,
         currentLocation.coordinate.longitude);
    [self updatePositionPoint];
}


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
        DLog(@">>>!!!:%f, %f", point.x, point.y);
        [self updatePositionPoint];
    }
}

-(void) updatePositionPoint
{
    point = [self.currentProductModel getPointByPosition:currentLocation andFrame:self.productImgView.frame];
    pulsingView.frame = CGRectMake(point.x - 10, point.y - 10, 20, 20);
    
    [directionImgView removeFromSuperview];
    if ((pulsingView.frame.origin.x > 620
        || pulsingView.frame.origin.x < 0)
        || (pulsingView.frame.origin.y > ProductContainer_height
        || pulsingView.frame.origin.y < 0))
    {
        float x = 30;
        float y = 30;
        if (pulsingView.frame.origin.x <= ProductContainer_Width
            && pulsingView.frame.origin.x >= 0)
        {
            x = pulsingView.frame.origin.x;
        }else if(pulsingView.frame.origin.x > ProductContainer_Width){
            x = ProductContainer_Width - x;
            [directionImgView setImage:[UIImage imageWithCGImage:[UIImage imageNamed:@"gps_btn.png"].CGImage scale:1 orientation:UIImageOrientationRight]];
        }else{
            x = 5;
            [directionImgView setImage:[UIImage imageWithCGImage:[UIImage imageNamed:@"gps_btn.png"].CGImage scale:1 orientation:UIImageOrientationLeft]];
        }
        if (pulsingView.frame.origin.y <= ProductContainer_height
            && pulsingView.frame.origin.y >= 0)
        {
            y = pulsingView.frame.origin.y;
            if (y >= ProductContainer_height - 26)
            {
                y = ProductContainer_height - 26;
            }
        }else if(pulsingView.frame.origin.y > ProductContainer_height){
            y = ProductContainer_height - y;
            [directionImgView setImage:[UIImage imageWithCGImage:[UIImage imageNamed:@"gps_btn.png"].CGImage scale:1 orientation:UIImageOrientationDown]];
        }else{
            y = 5;
            [directionImgView setImage:[UIImage imageWithCGImage:[UIImage imageNamed:@"gps_btn.png"].CGImage scale:1 orientation:UIImageOrientationUp]];
        }
        [directionImgView setFrame:CGRectMake(x, y, 26, 26)];
        [self.imgContainerView addSubview:directionImgView];
    }
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
            self.currentProductModel.zoomValue = 1;
        }
        self.mapView.zoom = self.currentProductModel.zoomValue + 7;
        DLog(@"detm:%f", [self.currentProductModel getDetM]);
//        [self.mapView setMetersPerPixel:[self.currentProductModel getDetM]];
        DLog(@"scaledMetersPerPixel:%f", self.mapView.scaledMetersPerPixel)
        DLog(@"metersPerPixel:%f", self.mapView.metersPerPixel)
        DLog(@"scaleDenominator:%f", self.mapView.scaleDenominator)
        
        
//        [self.mapView setZoom:self.currentProductModel.zoomValue + 7 atCoordinate:self.mapView.centerCoordinate animated:NO];
//        DLog(@"%f, %f", self.mapView.centerCoordinate.longitude, self.mapView.centerCoordinate.latitude);
//        [self.mapView setCenterCoordinate:[self.currentProductModel getPositionByPoint:CGPointMake(ProductContainer_Width / 2, ProductContainer_height / 2)] animated:YES];
        [self drawProduct];
    }
}

static CGPoint fromLocation;
static CGPoint toLocation;
-(void)imgDragControl:(UIPanGestureRecognizer*)paramSender
{
    if (knifeBtn != nil && knifeBtn.tag == 1) return;
    CGPoint location = [paramSender locationInView:paramSender.view];
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        fromLocation.x = toLocation.x = location.x;
        fromLocation.y = toLocation.y = location.y;
        if (locationManager != nil)
        {
            pulsingView.frame = CGRectMake(-100, -100, 20, 20);
        }
    }else if (paramSender.state == UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        if (abs(fromLocation.x - location.x) >= 10 || abs(fromLocation.y - location.y) >= 10)
        {
            self.currentProductModel.centX -= (fromLocation.x - location.x);
            self.currentProductModel.centY -= (fromLocation.y - location.y);
        }
        self.productImgView.frame = CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height);
        self.mapCircleView.frame = CGRectMake(0, 0, ProductContainer_Width, ProductContainer_height);
        [self drawProduct];
    }else{
        [self.mapView moveBy:CGSizeMake(toLocation.x - location.x, toLocation.y - location.y)];
        self.productImgView.frame = CGRectMake(location.x - fromLocation.x,
                                               location.y - fromLocation.y,
                                               ProductContainer_Width, ProductContainer_height);
        self.mapCircleView.frame = CGRectMake(self.productImgView.frame.origin.x,
                                              self.productImgView.frame.origin.y,
                                              ProductContainer_Width, ProductContainer_height);
        toLocation.x = location.x;
        toLocation.y = location.y;
    }
}

-(void)imgSwitchcControl:(UIPanGestureRecognizer*)paramSender
{
    if (knifeBtn != nil && knifeBtn.tag == 1) return;
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [paramSender locationInView:paramSender.view];
        fromLocation.x = location.x;
        fromLocation.y = location.y;
    }else if (paramSender.state == UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        // Gesture Valid...
        CGPoint location = [paramSender locationInView:paramSender.view];
        if (abs(fromLocation.x - location.x) >= 10 || abs(fromLocation.y - location.y) >= 10)
        {
            // Horizontal.
            if (abs(fromLocation.x - location.x) > abs(fromLocation.y - location.y))
            {
                // Turn left.
                if (fromLocation.x - location.x > 0)
                {
                    [self productAddressReceived:[DBModel getProductData:3 andCurrentData:self.currentProductModel.productInfo.dataAddress]];
                }else{ // Turn right.
                    [self productAddressReceived:[DBModel getProductData:4 andCurrentData:self.currentProductModel.productInfo.dataAddress]];
                }
            }else{// Vertical.
                // Turn up.
                if (fromLocation.y - location.y > 0)
                {
                    [self productAddressReceived:[DBModel getProductData:1 andCurrentData:self.currentProductModel.productInfo.dataAddress]];
                }else{// Turn down.
                    [self productAddressReceived:[DBModel getProductData:2 andCurrentData:self.currentProductModel.productInfo.dataAddress]];
                }
            }
        }
    }
}

-(void)knifeDragControl:(UIPanGestureRecognizer*)paramSender
{
    if (knifeBtn != nil && knifeBtn.tag == 0) return;
    CGPoint location = [paramSender locationInView:paramSender.view];
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        fromLocation.x = location.x;
        fromLocation.y = location.y;
    }else if (paramSender.state == UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        
        if (abs(fromLocation.x - location.x) >= 10 || abs(fromLocation.y - location.y) >= 10)
        {
            self.currentProductModel.centX -= (fromLocation.x - location.x);
            self.currentProductModel.centY -= (fromLocation.y - location.y);
        }
        UIGraphicsBeginImageContext(knifeLineView.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 3);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, fromLocation.x, fromLocation.y);
        CGContextAddLineToPoint(context, location.x, location.y);
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
        CGContextStrokePath(context);
        // Show image...
        knifeLineView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self knifeAlertControl];
    }
}

#pragma mark - History Query Control
- (void)showHistoryProductTable:(NSMutableArray*)historyDataArray andIndex:(int) index
{
    if(historyProductListView == nil)
    {
        historyProductListView = [[HistoryProductListView alloc] initWithFrame:CGRectMake(0, 0, self.productControlView.frame.size.width, self.productControlView.frame.size.height)];
        historyProductListView.delegate = self;
        historyProductListView.showBackBtn = YES;
    }
    [self.productControlView addSubview:historyProductListView];
    historyProductListView.productDataArray = historyDataArray;
    [historyProductListView.tableView reloadData];
}

- (void)hideHistoryProductTable
{
    if (historyProductListView != nil)
    {
        [historyProductListView removeFromSuperview];
    }
    self.continueBtn.tag = 0;
    [self.continueBtn setTitle:@"▷" forState:UIControlStateNormal];
    self.continueBtn.enabled = NO;
    self.slider.value = 0;
    self.backMultipleBtn.enabled = NO;
    self.backBtn.enabled = NO;
    self.forwardBtn.enabled = NO;
    self.forwardMultipleBtn.enabled = NO;
    self.slider.enabled = NO;
    if(playTimer != nil) [playTimer invalidate];
    playTimer = nil;
    historyProductListView.productDataArray = nil;
}

- (void)selectProduct:(int) index inDataArray:(NSMutableArray*) dataArray
{
    NSString *productStr = (NSString*)[dataArray objectAtIndex:index];
    ProductInfo *vo = [[ProductInfo alloc] initWithPosFileStr:[NSString stringWithFormat:@"/%@.zdb",[productStr substringWithRange:NSMakeRange(0, productStr.length - 5)]]];
    [self selectProduct:vo];
}

- (void)retryControl
{
    [self.delegate historyQueryRetryControl];
}

@end
