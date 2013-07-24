//
//  LoginView.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVo.h"

@protocol LoginDelegate <NSObject>

-(void)loginBtnClick:(NSString*)username andPassword:(NSString*)password;
-(void)noLoginBtnClick;

@end

@interface LoginView : UIView<UITextFieldDelegate>{
    UIScrollView *scrollView;
    UIView *bgView;
    UIImageView *logo;
    UITextField *usernameTextField;
    UITextField *passwordTextField;
    UIButton *loginBtn;
    UIButton *noLoginBtn;
    
    id<LoginDelegate> delegate;
}

@property(nonatomic, retain) id<LoginDelegate> delegate;

@end
