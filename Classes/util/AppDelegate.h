//
//  AppDelegate.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationController.h"
#import "HistoryViewController.h"
#import "ControlViewController.h"
#import "ProductViewController.h"
#import "SystemViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    UINavigationController *rootController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *na;
@property (strong, nonatomic) NSMutableArray *controllerArray;

-(void)initTabBar;

@end
