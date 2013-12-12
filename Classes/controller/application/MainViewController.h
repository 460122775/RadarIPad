//
//  MainViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-22.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ProductSmallView.h"
#import "MainView.h"
#import "ProductDataTableView.h"
#import "ProductModel.h"
#import "ProductMenuViewController.h"

@interface MainViewController : UIViewController{
    UIBarButtonItem *leftBtn;
    UIBarButtonItem *rightBtn;
    
    MainView *mainView;
    NSMutableDictionary *productDic;
    NSMutableDictionary *productViewDic;
    ProductMenuViewController *productMenuViewController;
    UIViewController  *_currentMainController;

    BOOL sideBarShowing;
    UITapGestureRecognizer *_tapGestureRecognizer;
}

typedef enum _SideBarShowDirection
{
    SideBarShowDirectionNone = 0,
    SideBarShowDirectionLeft = 1,
    SideBarShowDirectionRight = 2
}SideBarShowDirection;

@end
