//
//  AppDelegate.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *rootViewController;

@end
