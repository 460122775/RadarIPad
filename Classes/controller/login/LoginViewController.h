//
//  LoginViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"

enum Privilige {
    VISITOR = 1,
    NORMALUSER = 2,
    ADMINISTRATOR = 3
    };

@interface LoginViewController : UIViewController<LoginDelegate>{
    LoginView *loginView;
}

@end
