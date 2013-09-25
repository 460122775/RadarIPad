//
//  MainView.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-22.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "MainView.h"

@implementation MainView
@synthesize productDic;

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
    productsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [productsScrollView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:productsScrollView];
    
    [self initProductSmallView];
}

- (void)initProductSmallView
{
    int no = 0;
    int width = (self.frame.size.width - Padding * 4) / 3;
    ProductSmallView *productSmallView = nil;
    for (id key in self.productDic)
    {
        productSmallView = [self.productDic objectForKey:key];
        productSmallView.frame = CGRectMake(Padding + (no % 3) * (width + Padding), Padding + (no / 3) * (width + Padding),
                                            width, width);
        [productsScrollView addSubview:productSmallView];
        DLog(@"%f, %f",productSmallView.frame.origin.x, productSmallView.frame.origin.y);
        no++;
    }
    if((no + 1) / 3 * (width + Padding) < self.frame.size.height - 100){
        [productsScrollView setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height + 100)];
    }else{
        [productsScrollView setContentSize:CGSizeMake(self.frame.size.width, (no + 1) / 3 * (width + Padding) + 100)];
    }
}

@end
