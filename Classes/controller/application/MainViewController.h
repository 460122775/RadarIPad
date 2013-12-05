//
//  MainViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-22.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSmallView.h"
#import "MainView.h"
#import "ProductDataTableView.h"

@interface MainViewController : UIViewController{
    UIBarButtonItem *leftBtn;
    UIBarButtonItem *rightBtn;
    
    MainView *mainView;
    ProductDataTableView *productDataTableView;
}

@property(nonatomic, retain) NSMutableDictionary *productDic;

@end
