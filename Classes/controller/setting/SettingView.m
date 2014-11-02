//
//  SettingView.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/25/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView

@synthesize mainView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [ProductView setShadowTaste:self.mainViewBg andForeView:self.mainView];
}

@end
