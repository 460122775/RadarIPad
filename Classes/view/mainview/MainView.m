//
//  MainView.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-22.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "MainView.h"

@implementation MainView
@synthesize productsScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.productsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.productsScrollView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.productsScrollView];
}

@end
