//
//  MainView.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-22.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSmallView.h"

@interface MainView : UIView{
    UIScrollView *productsScrollView;
}

@property(nonatomic, retain) NSMutableDictionary *productDic;

@end
