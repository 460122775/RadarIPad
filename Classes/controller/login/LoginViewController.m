//
//  LoginViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    loginView = [[LoginView alloc] initWithFrame:
                    CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.height,[[UIScreen mainScreen]bounds].size.width)];
    [loginView setBackgroundColor:[UIColor whiteColor]];
    [loginView setDelegate:self];
    [self.view addSubview: loginView];
}

#pragma mark - loginDelegate
-(void)loginBtnClick:(NSString *)username andPassword:(NSString *)password
{
    UserVo *userVo = [[UserVo alloc] init];
    userVo.username = username;
    userVo.password = password;
    userVo.privilige = ADMINISTRATOR;
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCCESS object:userVo];
}

-(void)noLoginBtnClick
{
    UserVo *userVo = [[UserVo alloc] init];
    userVo.privilige = ADMINISTRATOR;
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCCESS object:userVo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
