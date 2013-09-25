//
//  ApplicationControllerViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-21.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "UserVo.h"

@interface ApplicationController : UIViewController{
    UserVo *userVo;
    MainViewController *mainViewController;
}

-(ApplicationController*) getInstance;

@end
