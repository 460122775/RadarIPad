//
//  AppDelegate.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *rootController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *rootController;

@end
