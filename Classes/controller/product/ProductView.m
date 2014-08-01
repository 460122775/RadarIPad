//
//  ProductView.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/23/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "ProductView.h"

@implementation ProductView

@synthesize productImgView, colorImgView, rightBarView, radarInfoBarView, productInfoView,productControlView, productViewInitFinishControl;
@synthesize btn_cartoon,btn_current,btn_knife,btn_position,btn_screenshot,btn_shot;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:BackGroundBlueColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Left Area.
    self.productImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 660, 660)];
    [self.productImgView setBackgroundColor:BackGroundGrayColor];
    [self addSubview:self.productImgView];
    
    self.colorImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 660, 660, 68)];
    [self.colorImgView setBackgroundColor:BackGroundGrayColor];
    [self addSubview:self.colorImgView];
    // Right Area.
    self.rightBarView = [[UIImageView alloc] initWithFrame:CGRectMake(661, 0, 258, 728)];
    [self.rightBarView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.rightBarView];
    
    // Radar Info.
    self.radarInfoBarView = [[UIImageView alloc] initWithFrame:
                             CGRectMake(0, 0, self.rightBarView.frame.size.width, 35)];
    [self.radarInfoBarView setBackgroundColor:BackGroundGrayColor];
    [self.rightBarView addSubview:self.radarInfoBarView];
    
    UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 95, 20)];
    [positionLabel setTextColor:ProductTextColor];
    [positionLabel setText:@"方位:235.28"];
    [positionLabel setFont:[UIFont systemFontOfSize:16]];
    [self.radarInfoBarView addSubview:positionLabel];
    
    UILabel *eleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 + 95 + 2, 8, 75, 20)];
    [eleLabel setTextColor:ProductTextColor];
    [eleLabel setText:@"俯仰:19.8"];
    [eleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.radarInfoBarView addSubview:eleLabel];
    
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 + 175, 8, 95, 20)];
    [speedLabel setTextColor:ProductTextColor];
    [speedLabel setText:@"速率:32.92"];
    [speedLabel setFont:[UIFont systemFontOfSize:16]];
    [self.radarInfoBarView addSubview:speedLabel];

    // Product Info.
    self.productInfoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35 + 1, self.rightBarView.frame.size.width, 510)];
    [self.productInfoView setBackgroundColor:BackGroundGrayColor];
    [self.rightBarView addSubview:self.productInfoView];
    
    // Product Control.
    self.productControlView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35 + 510 + 2, self.rightBarView.frame.size.width, 181)];
    [self.productControlView setBackgroundColor:BackGroundGrayColor];
    [self.rightBarView addSubview:self.productControlView];
    
    self.btn_shot = [[UIButton alloc] initWithFrame:CGRectMake(5, 3, 80, 80)];
    [self.btn_shot setBackgroundColor:BackGroundGrayColor];
    [self.btn_shot setBackgroundImage:[UIImage imageNamed:@"boom.png"] forState:UIControlStateNormal];
    [self.btn_shot setBackgroundImage:[UIImage imageNamed:@"boom.png"] forState:UIControlStateHighlighted];
    [self.btn_shot addTarget:self action:@selector(shotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productControlView addSubview:self.btn_shot];
    
    self.btn_knife = [[UIButton alloc] initWithFrame:CGRectMake(5 + 80 + 5, 3, 80, 80)];
    [self.btn_knife setBackgroundColor:BackGroundGrayColor];
    [self.btn_knife setBackgroundImage:[UIImage imageNamed:@"knife.png"] forState:UIControlStateNormal];
    [self.btn_knife setBackgroundImage:[UIImage imageNamed:@"knife.png"] forState:UIControlStateHighlighted];
    [self.btn_knife addTarget:self action:@selector(knifeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productControlView addSubview:self.btn_knife];

    self.btn_current = [[UIButton alloc] initWithFrame:CGRectMake(5 + 80 + 5 + 80 + 5, 3, 80, 80)];
    [self.btn_current setBackgroundColor:BackGroundGrayColor];
    [self.btn_current setBackgroundImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [self.btn_current setBackgroundImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateHighlighted];
    [self.btn_current addTarget:self action:@selector(currentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productControlView addSubview:self.btn_current];
    
    self.btn_cartoon = [[UIButton alloc] initWithFrame:CGRectMake(5, 3 + 80 + 4, 80, 80)];
    [self.btn_cartoon setBackgroundColor:BackGroundGrayColor];
    [self.btn_cartoon setBackgroundImage:[UIImage imageNamed:@"player.png"] forState:UIControlStateNormal];
    [self.btn_cartoon setBackgroundImage:[UIImage imageNamed:@"player.png"] forState:UIControlStateHighlighted];
    [self.btn_cartoon addTarget:self action:@selector(cartoonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productControlView addSubview:self.btn_cartoon];

    self.btn_screenshot = [[UIButton alloc] initWithFrame:CGRectMake(5 + 80 + 5,  3 + 80 + 4, 80, 80)];
    [self.btn_screenshot setBackgroundColor:BackGroundGrayColor];
    [self.btn_screenshot setBackgroundImage:[UIImage imageNamed:@"camara.png"] forState:UIControlStateNormal];
    [self.btn_screenshot setBackgroundImage:[UIImage imageNamed:@"camara.png"] forState:UIControlStateHighlighted];
    [self.btn_screenshot addTarget:self action:@selector(screenShotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productControlView addSubview:self.btn_screenshot];
    
    self.btn_position = [[UIButton alloc] initWithFrame:CGRectMake(5 + 80 + 5 + 80 + 5,  3 + 80 + 4, 80, 80)];
    [self.btn_position setBackgroundColor:BackGroundGrayColor];
    [self.btn_position setBackgroundImage:[UIImage imageNamed:@"position2.png"] forState:UIControlStateNormal];
    [self.btn_position setBackgroundImage:[UIImage imageNamed:@"position2.png"] forState:UIControlStateHighlighted];
    [self.btn_position addTarget:self action:@selector(positionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productControlView addSubview:self.btn_position];
    
    self.productViewInitFinishControl();
}

- (void)shotBtnClick
{
    
}

- (void)knifeBtnClick
{
    
}

- (void)currentBtnClick
{
    
}

- (void)cartoonBtnClick
{
    
}

- (void)screenShotBtnClick
{
    
}

- (void)positionBtnClick
{
    
}
@end
